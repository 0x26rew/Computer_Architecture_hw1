#include <stdio.h>
#include <stdbool.h>

int isUgly(int n);

int main() {
    int n = 100;
    int ugly = isUgly(n);
    char *str;
    if (ugly)
        printf("%d is ugly.\n", n);
    else 
        printf("%d is not ugly.\n", n);
    
}

int isUgly(int n) {
    int ugly = 1;
    if (n <= 1)
        ugly = 0;
    do {
        if (n % 2 == 0)
            n /= 2;
	    else if (n % 3 == 0)
	        n /= 3;
	    else if(n % 5 == 0)
	        n /= 5;
	    else {
	        ugly = 0;
            break;
	    }
    } while (n > 1);
    return ugly;
}