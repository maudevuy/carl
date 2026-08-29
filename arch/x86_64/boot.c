#include <stdint.h>
#include <carl/boot_info.h>

carl_boot_info boot_info;

extern void run_kernel(carl_boot_info* info);

void boot_main(void)
{
    // TODO: fill boot_info with real data from GRUB or Limine

    run_kernel(&boot_info);

    for (;;) __asm__ volatile("hlt");
}
