#ifndef CARL_NET_ARP_H
#define CARL_NET_ARP_H

#include <stdint.h>

void c_arp_init(void);

int c_arp_resolve(
    uint32_t ip,
    uint8_t mac[6]
);

#endif /* CARL_NET_ARP_H */
