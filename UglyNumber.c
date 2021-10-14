#include <stdio.h>
#include <stdbool.h>

int main() {
    int n = 101;
    bool isUgly = true;
    if (n < 1)
	isUgly = false;
    while (n > 1) {
        if (n % 2 == 0)
            n /= 2;
	else if (n % 3 == 0)
	    n /= 3;
	else if(n % 5 == 0)
	    n /= 5;
	else {
	    isUgly = false;
            break;
	}
    }
    printf("%d\n", isUgly);
}
