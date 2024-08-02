#include <iostream>

void pass(int* arr, size_t size, bool& swappedAtLeastOnce)
{
  if (size <= 1)
    return;

  if (arr[0] > arr[1]) {
    std::swap(arr[0], arr[1]);
    swappedAtLeastOnce = true;
  }

  pass(arr + 1, size - 1, swappedAtLeastOnce);
}

void bubbleSort(int* arr, size_t size)
{
  bool swappedAtLeastOnce = false;
  pass(arr, size, swappedAtLeastOnce);
  if (swappedAtLeastOnce)
    bubbleSort(arr, size);
}

void printArray(int* arr, size_t size)
{
  for (int i = 0; i < size; ++i) {
    std::cout << arr[i] << " ";
  }
  std::cout << std::endl;
}

int main()
{
  int arr[] = {5, -1, 2, 4, 1};
  bubbleSort(arr, 5);
  printArray(arr, 5);
  return 0;
}