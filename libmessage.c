#include <stddef.h>

void messageinit(void) {
}
void messagefinal(void) {
}

static const char *messages[] = {
    "Who are you?\n",
     "Hello from C, %s\n",
     "Goodbye, %s\n",
};

const char *get_message(unsigned kind) {
	if (kind >= sizeof(messages) / sizeof(messages[0])) return NULL;
	
	return messages[kind];
}

#define Q_LEN 32

static int fixed_queue[Q_LEN] = {};
static size_t top = 0;

void push(int value) {
	if (top >= Q_LEN) {
		return;
	}
	
	fixed_queue[top++] = value;
}

int pop(void) {
	if (top >= Q_LEN) {
		return -1;
	}
	
	return fixed_queue[--top];
}
