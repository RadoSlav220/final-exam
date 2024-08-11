#include <iostream>

using std::cout;
using std::endl;
using std::swap;

void merge(int* arr, int left, int mid, int right) {
  int subArrLeftSize = mid - left + 1;
  int subArrRightSize = right - mid;

  int* subArrLeft = new int[subArrLeftSize];
  int* subArrRight = new int[subArrRightSize];

  for (int i=0; i<subArrLeftSize; i++) {
    subArrLeft[i] = arr[left + i];
  }

  for (int i=0; i<subArrRightSize; i++) {
    subArrRight[i] = arr[mid + i + 1];
  }

  int i = 0, j = 0, k = left;

  while (i < subArrLeftSize && j < subArrRightSize) {
    if (subArrLeft[i] < subArrRight[j]) {
      arr[k++] = subArrLeft[i++];
    } else {
      arr[k++] = subArrRight[j++];
    }
  }

  while (i < subArrLeftSize) {
    arr[k++] = subArrLeft[i++];
  }

  while (j < subArrRightSize) {
    arr[k++] = subArrRight[j++];
  }
}

void mergeSort(int* arr, int left, int right) {
  if (left < right) {
    int mid = (left + right) / 2;

    mergeSort(arr, left, mid);
    mergeSort(arr, mid + 1, right);
    
    merge(arr, left, mid, right);
  }
}

void mergeSort(int* arr, size_t n) {
  mergeSort(arr, 0, n - 1);
}

int partition(int* arr, int low, int high) {
  // Choose pivot to be arr[high].
  int pivot = arr[high];

  // The index of biggest smaller than pivot element.
  int i = low - 1;

  // Traverse the array. Elements from low to i are smaller than pivot.
  for (int j = low; j <= high - 1; j++) {
    if (arr[j] < pivot) {
      swap(arr[i + 1], arr[j]);
      i++;
    }
  }

  // Put the pivot on its correct index
  swap(arr[i + 1], arr[high]);
  return i + 1;
}

void quickSort(int* arr, int low, int high) {
  if (low < high) {
    int index = partition(arr, low, high);
    quickSort(arr, low, index - 1);
    quickSort(arr, index + 1, high);
  }
}

void quickSort(int* arr, size_t n) {
  quickSort(arr, 0, n - 1);
}

void bubbleSort(int* arr, size_t n) {
  for (int i = 0; i < n - 1; i++) {
    bool isSwapped = false;
    
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j+1]) {
        swap(arr[j], arr[j+1]);
        isSwapped = true;
      }
    }

    if (!isSwapped) {
      break;
    }
  }
}

void insertionSort(int* arr, size_t n) {
  for (int i = 1; i < n; i++) {
    int currentNumber = arr[i];
    int j = i;
    while (j > 0 && currentNumber < arr[j - 1]) {
      arr[j] = arr[j - 1];
      j--;
    }
    arr[j] = currentNumber;
  }
}

void selectionSort(int* arr, size_t n) {
  for (int i=0; i<n-1; ++i) {
    int minIndex = i;
    for (int j=i; j<n; ++j) {
      if (arr[j] < arr[minIndex]) {
        minIndex = j;
      }
    }
    
    if (minIndex != i) {
      swap(arr[minIndex], arr[i]);
    }
  }
}

void printArr(int* arr, size_t n) {
  for (int i=0; i<n; ++i) {
    cout << arr[i] << ' ';
  }
  cout << endl;
}

int main() {
  int arr[] = {7, 2, 5, 10, -2, 0};
  size_t n = sizeof(arr) / sizeof(int);
  // selectionSort(arr, n);
  // insertionSort(arr, n);
  // bubbleSort(arr, n);
  // quickSort(arr, n);
  mergeSort(arr, n);
  printArr(arr, n);
  return 0;
}