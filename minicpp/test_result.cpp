#include <iostream>
#include <cmath>

int main() {
    double a = 0;
    double b = 0;
    a = 3 + 4 * 2;  // a = 11
    b = a + 10;     // b = 21
    b = a--;        // b = 11, a = 10
    b = 2*2*(pow(3,2)*9)/10;  // 2*2*(9*9)/10 = 4*81/10 = 324/10 = 32.4
    std::cout << "Final result of b: " << b << std::endl;
    return 0;
}
