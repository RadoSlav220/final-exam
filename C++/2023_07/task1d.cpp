#include <iostream>

using namespace std;

int main()
{
  int x = 2;
  int arr[] = {10, 20, 30};
  cout << "\nA: " << 5./x;
  cout << "\nB: " << (x << 4);
  cout << "\nC: " << arr[!x];
  cout << "\nD: " << *(arr+x);
  cout << "\nE: " << (2 + x++);
  cout << endl;
  return 0;
}