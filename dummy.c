#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#ifdef __ANDROID__
// Dummy implementations to workaround GNAT-LLVM bugs
typedef void __sigtramphandler_t (int signo, void *siginfo, void *sigcontext);

void __gnat_sigtramp (int signo, void *siginfo, void *sigcontext, __sigtramphandler_t * handler) {
	printf("%s: Signal %d, siginfo %p, sigcontext %p, handler %p", __func__, signo, siginfo, sigcontext, handler);
	exit(1);
}

unsigned char _r_debug[640*1024] = {};
#endif

void c_puts(const char *msg) {
	puts(msg);
}

typedef struct {
	char c_str[640];
} String;

// Color, 4 components, R8G8B8A8 (32bit)
typedef struct Color {
    unsigned char r;        // Color red value
    unsigned char g;        // Color green value
    unsigned char b;        // Color blue value
    unsigned char a;        // Color alpha value
} Color;

#define Color_Fmt "{0x%02x, 0x%02x, 0x%02x, 0x%02x}"
#define Color_Arg(c) (c).r, (c).g, (c).b, (c).a

Color GetColor(unsigned int hexValue) {

    Color color;

    color.r = (unsigned char)(hexValue >> 24) & 0xFF;
    color.g = (unsigned char)(hexValue >> 16) & 0xFF;
    color.b = (unsigned char)(hexValue >> 8) & 0xFF;
    color.a = (unsigned char)hexValue & 0xFF;
	printf("%s: hexValue: 0x%08x, color: "Color_Fmt"\n", __func__, hexValue, Color_Arg(color));

    return color;
}

// Get hexadecimal value for a Color
int ColorToInt(Color color) {
	unsigned hexValue = (((unsigned) color.r << 24) | ((unsigned) color.g << 16) | ((unsigned) color.b << 8) | (unsigned) color.a);
	printf("%s: hexValue: 0x%08x, color: "Color_Fmt"\n", __func__, hexValue, Color_Arg(color));

    return hexValue;
}

const char *c_int_str(int value) {
	static String mem = {};
	memset(mem.c_str, 0, sizeof(mem));
	printf("%s: value: %d\n", __func__, value);

	snprintf(mem.c_str, sizeof(mem), "%d", value);
	return mem.c_str;
}
const char *c_uint_str(unsigned value) {
	static String mem = {};
	memset(mem.c_str, 0, sizeof(mem));
	printf("%s: value: 0x%08x\n", __func__, value);
	snprintf(mem.c_str, sizeof(mem), "0x%08x", value);
	return mem.c_str;
}
