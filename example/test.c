// test.c - Sample C code for testing
#include <stdio.h>

int main() {
    int x = 10;
    int y = 20;
    int sum = x + y;
    
    if (sum > 25) {
        printf("Sum is greater than 25\n");
    } else if (sum == 30) {
        printf("Sum is exactly 30\n");
    } else {
        printf("Sum is less than 30\n");
    }
    
    // Loop example
    for (int i = 0; i < 5; i++) {
        printf("i = %d\n", i);
    }
    
    // Bitwise operations
    int a = 5 & 3;
    int b = 5 | 3;
    
    return 0;
}
