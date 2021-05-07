#include<stdio.h>
#include<stdlib.h>
#include<time.h>

int main(void)
{
        const char buchstaben[] = {"ABCDEFGHIJKLMNOPQRSTUVWXYZ"};
        srand(time(NULL));
        int zahl = rand() % 10;
        printf("%c\n", buchstaben[zahl]);
        return 0;
}
