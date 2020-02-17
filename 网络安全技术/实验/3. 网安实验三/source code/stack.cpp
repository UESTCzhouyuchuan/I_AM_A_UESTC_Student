#include <stdio.h>
int main()
{
	_asm {
		push 0x12345678
		pop eax
	};
    return 0;
}
