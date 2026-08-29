/*
 * Carl 0.2 - head.s
 * Switch from 32-bit (GRUB) to 64-bit long mode
 */

.section .text
.global _head_start
.extern _start

_head_start:
    cli

    # Enable PAE
    mov %cr4, %eax
    or $0x20, %eax
    mov %eax, %cr4

    # Load PML4
    mov $pml4_table, %eax
    mov %eax, %cr3

    # Enable long mode
    mov $0xC0000080, %ecx
    rdmsr
    or $0x100, %eax
    wrmsr

    # Enable paging
    mov %cr0, %eax
    or $0x80000000, %eax
    mov %eax, %cr0

    # Load 64-bit GDT
    lgdt gdt64_ptr

    # Far jump to 64-bit entry
    ljmp $0x08, $_start
