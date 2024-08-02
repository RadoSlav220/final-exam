#include <iostream>
#include <string>

using std::string;
using std::cout;

int main() {
  string str = "test";

  bool isEmpty = str.empty();
  cout << "Is empty: " << isEmpty << '\n';

  int length = str.length();
  cout << "Length: " << length << '\n';

  const int charIndex = 3;
  char charAt = str.at(charIndex);
  cout << "Char at " << charIndex << ": " << charAt << '\n';

  const char* c_type_str = str.c_str();
  cout << "c_str: " << c_type_str << '\n';

  

  return 0;
}