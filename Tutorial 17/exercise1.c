#include <stdio.h>
int getsum(); // function prototype

int main()
{

  int j; // initialize where to store the sum result

  j = getsum(); // call the function

  printf("Sum is: %d\n", j); // print out the result

  return 0;
  
}
