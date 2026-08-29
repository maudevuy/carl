/*
 * CarlOS 0.2 - entry.s
 * 64-bit kernel entry point
 */

.section .text
.global _start
.type _start, @function

.extern run_kernel
.extern boot_info

_start:
    cli

    # Set up aligned stack
    lea stack_top(%rip), %rsp
    and $~0xF, %rsp
    mov %rsp, %rbp

    # Pass boot_info to run_kernel()
    lea boot_info(%rip), %rdi

    call run_kernel

.hang:
    hlt
    jmp .hang

.section .bss
.align 16
stack_bottom:
    .space 16384
stack_top:
