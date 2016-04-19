#include <stdio.h>
int main()
{
  char string[11]="A nice cat";
  char key[11]="ABCDEFGHIJ";
  char dec[11];
  for(int x=0; x<10; x++)
  {
    dec[x]=string[x]^key[x];
    printf("%c",dec[x]);
  }
  printf("-----------------------------------------\n");
  for(int x=0; x<10; x++)
  {
    dec[x]=dec[x]^key[x];
    printf("%c",dec[x]);
  }
  return 0;
}
