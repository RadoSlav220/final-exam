#include <iostream>

int main() 
{
  // 02468
  for (int i = 0; i < 10; ++i) {
    if (i % 2) continue;
      std::cout << i;
  }

  std::cout << "\n";

  // 16
  int i = 0x10;
  std::cout << i;

  std::cout << "\n";

  // 2
  int a = 1, b = 2, c = 3;
  std::cout << (a ? b : c);

  std::cout << "\n";

  // acc
  char str[] = "abc";
  char* p = str;
  ++p;
  ++*p;
  std::cout << str;

  std::cout << "\n";
  return 0;
}