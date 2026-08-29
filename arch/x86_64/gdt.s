/*
 * Carl 0.2 - gdt.s
 */

.global gdt64_ptr

.section .data
gdt64:
    .quad 0x0000000000000000     # null
    .quad 0x00AF9A000000FFFF     # code
    .quad 0x00AF92000000FFFF     # data

gdt64_ptr:
    .word (gdt64_end - gdt64 - 1)
    .quad gdt64
gdt64_end:
