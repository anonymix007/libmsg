#include <stdio.h>
#include <stdint.h>
#include <dlfcn.h>

typedef struct {
	uint8_t c_str[640];
} String;
typedef enum {
	WHO,
	HELLO,
	GOODBYE,
} Message_Kind;

typedef const char *(*get_message_function)(Message_Kind);

typedef void (*push_function)(int);
typedef int (*pop_function)(void);
typedef void (*messageinit_function)(void);
typedef void (*messagefinal_function)(void);

#define load_function(name, lib) \
    name##_function name = dlsym(lib, #name); \
    if (name == NULL) { \
		fprintf(stderr, "Error: %s\n", dlerror()); \
		return 1; \
	}

int main(void) {
	String name = {};

	void *libmsg = dlopen("./libmessage.so", RTLD_NOW);

	if (libmsg == NULL) {
		fprintf(stderr, "Error: %s\n", dlerror());
		return 1;
	}
	load_function(messageinit, libmsg);
	load_function(messagefinal, libmsg);
	load_function(get_message, libmsg);
	load_function(push, libmsg);
	load_function(pop, libmsg);
	messageinit();

	printf("%s", get_message(WHO));
	printf("Enter your name: ");
	scanf("%639s", name.c_str);
	printf( get_message(HELLO), name.c_str);

	for(int i = 0; i < 7; i++) {
		printf("Push: %d\n", i + 1);
		push(i + 1);
	}
	for(int i = 0; i < 7; i++) {
		printf("Pop: %d\n", pop());
	}

	printf(get_message(GOODBYE), name.c_str);
	messagefinal();
}
