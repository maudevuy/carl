#ifndef CARL_BOOT_INFO_H
#define CARL_BOOT_INFO_H

#include <stdint.h>

typedef struct {
    uint64_t mem_lower;
    uint64_t mem_upper;
    uint64_t fb_addr;
    uint32_t fb_width;
    uint32_t fb_height;
    uint32_t fb_pitch;
    uint32_t fb_bpp;
} carl_boot_info;

#endif

