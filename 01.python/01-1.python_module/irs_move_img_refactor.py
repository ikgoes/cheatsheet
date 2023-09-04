import os
import subprocess
import sys
import threading
import time
import logging


def split_text(text, n):
    chunks = [text[i:i + n] for i in range(0, len(text), n)]
    return chunks


def file_count(path):
    try:
        file_cnt = int(subprocess.check_output("find {} | grep .JPG | wc -l".format(path), shell=True))
        if file_cnt == 0:
            return 0
        else:
            return file_cnt - 1
    except OSError:
        return 0


def copy_files(files, source_dir, dest_dir, thread_id):
    global source_file_cnt, dest_file_cnt
    for file in files:
        src_path = source_dir + file + '/'
        dst_path = dest_dir + file
        src_file_count = file_count(src_path)

        if src_file_count == 0:
            logging.info("Thread {}: No File Found {}".format(thread_id, src_path))
            continue

        logging.info("Thread {}: {} Found / Started {} < -> To {}".format(thread_id, src_file_count, src_path, dst_path))
        os.makedirs(dst_path, exist_ok=True)
        logging.info("Thread {}: Created : {}".format(thread_id, dst_path))

        try:
            subprocess.call(["rsync", "-rltgoD", src_path, dst_path])
        except OSError:
            logging.info("Thread {}: RSYNC FAILED {}".format(thread_id, src_path))
            pass

        dst_file_count = file_count(dst_path)
        source_file_cnt += src_file_count
        dest_file_cnt += dst_file_count
        logging.info("Thread {}: (SRC {} | DST {}) Copied {}".format(thread_id, src_file_count, dst_file_count, file))

        subprocess.call(["chmod", "777", "-R", dst_path])
        logging.info("Thread {}: Permission changed : {}".format(thread_id, dst_path))


def create_full_list(path_list, src_path, last_path=['/WELDING-PLUS/01', '/WELDING-MINUS/01']):
    assert all(item.endswith("/") and "*" in item for item in path_list), "incorrect path format"

    path_no_aster_list = [item[:item.find('*')] for item in path_list]
    full_cluster_path = []

    for path in path_no_aster_list:
        try:
            mid_path = [path + item for item in os.listdir(src_path + path)]
        except OSError:
            continue
        full_cluster_path += [item + last for item in mid_path for last in last_path]

    return full_cluster_path


def main(request_list, source_dir, dest_dir, num_chunks):
    global source_file_cnt, dest_file_cnt

    # Set up logging
    logging.basicConfig(filename="copy_files.log", 
                        level=logging.INFO, 
                        format="%(asctime)s %(message)s", 
                        datefmt="%Y-%m-%d %H:%M:%S")
    logging.info("Started copying files")

    # Read the text file
    with open(request_list, "r") as file:
        request_path_list = file.read().splitlines()

    full_path_list = create_full_list(request_path_list, source_dir)
    
    # Split the file list into chunks
    chunk_size = (len(full_path_list) // num_chunks) + 1
    file_chunks = split_text(full_path_list, chunk_size)
    
    # Start a new thread for each chunk of files
    threads = []
    
    for i, chunk in enumerate(file_chunks):
        t = threading.Thread(target=copy_files, args=(chunk, source_dir, dest_dir, i))
        threads.append(t)
        t.start()
    
    # Wait for all threads to finish
    for t in threads:
        t.join()
    
    # Log the number of files in source and destination directories
    logging.info("Source directory: {} files".format(source_file_cnt))
    logging.info("Destination directory: {} files".format(dest_file_cnt))
    
    # Log the time taken
    end_time = time.time()
    elapsed_time = end_time - start_time
    logging.info("Time taken: {:.2f} seconds".format(elapsed_time))
    logging.info("Finished copying files")


if __name__ == "__main__":
    if len(sys.argv) != 5:
        print("Usage: python script.py file_list.txt source_dir dest_dir num_chunks")
        sys.exit(1)
    
    start_time = time.time()
    source_file_cnt, dest_file_cnt = 0, 0
    
    file_list_file, source_dir, dest_dir, num_chunks = sys.argv[1:]
    main(file_list_file, source_dir, dest_dir, int(num_chunks))