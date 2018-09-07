/*************************************************************************
	> File Name: pgcd.c
	> Author: 
	> Mail: 
	> Created Time: ven. 13 avril 2018 12:08:20 CEST
 ************************************************************************/

#include<stdio.h>

int pgdc(long a, long b)
{
    long x = 1;
    long y = 0;
    long xx = 0;
    long yy =1;
    long temp = 0;
    long tempx = 0;
    long tempy = 0;
    long q = 0;
    while(b != 0){
        q = b/a;
        temp = a;
        a = b;
        b = temp%b;
        
        tempx = xx;
        xx = x - q*xx;
        x = tempx;
        
        tempy = yy;
        yy = y - q*yy;
        y = tempy;
    };
    
    if (yy < 0)
    {
        yy += b;    
    }
    return yy;
}

int main()
{
    long d = pgdc(13, 352);
    printf("d is : %ld\n", d);
}
