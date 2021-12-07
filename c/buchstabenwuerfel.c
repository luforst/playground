#include<stdio.h>
#include<stdlib.h>
#include<time.h>

int main(void)
{
        srand(time(NULL));
        int zahl = rand() % 26;
        printf("%c\n", zahl+65); /* wegen ASCII-Code 65 für A */
        return 0;
}
