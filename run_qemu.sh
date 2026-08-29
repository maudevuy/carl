qemu-system-x86_64 \
    -cdrom build/carl.iso \
    -boot d \
    -m 512M \
    -nographic \
    -drive if=none,file=/dev/null,format=raw \
    -serial mon:stdio

