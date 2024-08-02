#include <iostream>

bool isWhitespace(char c)
{
  return c == ' ' || c == '\t' || c == '\r' || c == '\n';
}

char* removeWhitespace(char* str)
{
  size_t read=0, write=0;
  while(str[read]){
    if (isWhitespace(str[read]))
      read++;
    else
      str[write++] = str[read++];
  }
  str[write] = '\0';
  return str;
}

int main() 
{
  char str[] = "hey whats up\t boy ";
  std::cout << removeWhitespace(str) << std::endl;
  return 0;
}