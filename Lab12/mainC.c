#include <stdio.h>

void asmString(char sir[], char res1[], char res2[]);

int main()
{
    char sirRead[100];
    char sirRes1[100];
    char sirRes2[100];
    
    printf("Give sentence: ");
    gets(sirRead);
    
    asmString(sirRead, sirRes1, sirRes2);
    printf("Lower case letters string: %s\n", sirRes1);
    printf("Upper case letters string: %s", sirRes2);
    
    return 0;
}