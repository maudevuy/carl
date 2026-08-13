#ifndef CARL_VIDEO_H
#define CARL_VIDEO_H

void c_vinit(void);
void c_vclear(void);
void c_vput(char c);
void c_vputs(const char *str);

#define C_BLACK 0x000000
#define C_GREEN 0x00FF00
#define C_LIGHT_GREEN 0x80FF80
#define C_RED 0xFF0000
#define C_YELLOW 0xFFFF00

#endif /* CARL_VIDEO_H */
