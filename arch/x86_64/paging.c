#include <stdint.h>
#include <carl/paging.h>

extern uint64_t pml4_table[];

void paging_init(void)
{
    // Already set by head.s, but you can extend here
}
