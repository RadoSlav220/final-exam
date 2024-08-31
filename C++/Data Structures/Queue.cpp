#include <iostream>

using std::cout;
using std::endl;

class Queue {
private:
  static const size_t CAPACITY = 4;
  int arr[CAPACITY];
  int first;
  int last;
  int _size;

public:
  Queue() {
    first = last = 0;
    _size = 0;
  }

  bool isEmpty() {
    return _size == 0;
  }

  int size() {
    return _size;
  }

  int front() {
    if (isEmpty()) {
      throw std::runtime_error("Queue is empty.");
    }
    return arr[first];
  }

  int back() {
    if (isEmpty()) {
      throw std::runtime_error("Queue is empty.");
    }
    return arr[last];
  }

  void push(int newElement) {
    if (_size == CAPACITY) {
      throw std::runtime_error("Maximum capacity is reached.");
    }

    if (_size > 0) {
      last = (last + 1) % CAPACITY;
    }
    
    arr[last] = newElement;
    _size++;
  }

  void pop() {
    if (isEmpty()) {
      throw std::runtime_error("Queue is empty.");
    }
    first = (first + 1) % CAPACITY;
    _size--;
  }

  void print() {
    for (int i=0; i<CAPACITY; i++) {
      cout << arr[i] << " ";
    }
    cout << endl;
  }
};

int main() {
  Queue q;
  q.push(5);
  q.push(1);
  q.push(-2);
  q.push(19);
  q.pop();
  q.pop();
  q.push(13);
  q.push(23);
  q.pop();

  q.print();

  while (!q.isEmpty()) {
    cout << q.front() << " ";
    q.pop();
  }

  return 0;
}