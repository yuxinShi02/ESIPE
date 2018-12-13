/*************************************************************************
	> File Name: attacked.c
	> Author: 
	> Mail: 
	> Created Time: jeu. 25 oct. 2018 11:40:41 CEST
 ************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
    char buffer[96];
    printf("- %p -\\n", &buffer);
    strcpy(buffer, getenv("KIRIKA"));
    return 0;
}
