import os
import subprocess
import sys
import threading
import time
import logging


def split_text(text, n):
    """Splits a string into chunks of size `n`."""
    chunks = []
    for i in range(0, len(text), n):
        chunks.append(text[i:i + n])
    return chunks


def file_count(path):
    """Returns the number of JPG files in the given path."""
    try:
        return int(subprocess.check_output(
            ["find", path, "-name", "*.JPG", "-type", "f"], shell=True))
    except subprocess.CalledProcessError:
        return 0


def copy_files(files, source_dir, dest_dir, thread_id):
    """Copies the given files to the destination directory."""
    global source_file_cnt, dest_file_cnt
    for file in files:
        src_path = os.path.join(source_dir, file)
        dst_path = os.path.join(dest_dir, file)

        src_file_count = file_count(src_path)
        if src_file_count == 0:
            logging.info("Thread {}: No File Found {}".format(thread_id, src_path))
            continue

        logging.info("Thread {}: {} Found / Started {} < -> To {}".format(
            thread_id, src_file_count, src_path, dst_path))
        os.makedirs(dst_path, exist_ok=True)
        logging.info("Thread {}: Created : {}".format(thread_id, dst_path))

        try:
            subprocess.check_call(
                ["rsync", "-rltgoD", src_path, dst_path])
        except subprocess.CalledProcessError:
            logging.info("Thread {}: RSYNC FAILED {}".format(thread_id, src_path))
            continue

        dst_file_count = file_count(dst_path)
        source_file_cnt += src_file_count
        dest_file_cnt += dst_file_count
        logging.info("Thread {}: (SRC {} | DST {}) Copied {}".format(
            thread_id, src_file_count, dst_file_count, file))

        subprocess.check_call(["chmod", "777", "-R", dst_path])
        logging.info("Thread {}: Permission changed : {}".format(thread_id, dst_path))


def create_full_list(path_list, src_path, last_path=['/WELDING-PLUS/01', '/WELDING-MINUS/01']):
    """Creates a list of full paths from a list of paths and a source directory."""
    assert all(item.endswith("/") and "*" in item for item in path_list), "incorrect path format"

    path_no_aster_list = [item[:item.find("*")] for item in path_list]
    full_cluster_path = []

    for path in path_no_aster_list:
        try:
            mid_path = [path + item for item in os.listdir(src_path + path)]
        except FileNotFoundError:
            continue
        full_cluster_path += [item + last for item in mid_path for last in last_path]

    return full_cluster_path


def main(request_list, source_dir, dest_dir, num_chunks):
    """Copies the files in the given request list to the destination directory.

    Args:
        request_list: A text file containing a list of paths to the files to copy.
        source_dir: The source directory containing the files to copy.
        dest_dir: The destination directory to copy the files to.
        num_chunks: The number of chunks to divide the files into.
    """
    global source_file_cnt, dest_file_cnt

    # Set up logging
    logging.basicConfig(
        filename="copy_files.log", level=logging.INFO, format="%(asctime)