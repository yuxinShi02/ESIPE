#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char *argv[])
{
        char *input = malloc(20);
        char *output = malloc(20);
        strncpy(output, "normal output", 20);
        strncpy(input, argv[1], 20);
        printf("input at %p: %s\n", input, input);
        printf("output at %p: %s\n", output, output);
        printf("\n\n%s\n", output);
}
