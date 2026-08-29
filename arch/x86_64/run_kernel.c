#include <stdint.h>
#include "boot_info.h"
#include "idt.h"
#include "paging.h"

void run_kernel(carl_boot_info* info)
{
    idt_init();
    paging_init();

    // TODO: initialize framebuffer console
    // TODO: initialize GSOD
    // TODO: initialize memory manager
    // TODO: initialize driver manager

    for (;;) __asm__("hlt");
}
