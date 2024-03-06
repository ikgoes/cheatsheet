for num in `seq 1 10000`; do dd if=/dev/urandom  of=file-${num} bs=1024k count=1; done
