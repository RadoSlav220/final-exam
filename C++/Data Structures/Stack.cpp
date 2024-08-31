#include <iostream>

using std::cout;
using std::endl;

class Stack {
private:
  static const size_t STACK_CAPACITY = 100;

  int arr[STACK_CAPACITY];
  int _top;
  int _size;

public:
  Stack() {
    _top = -1; 
    _size = 0;
  }

  bool isEmpty() {
    return _top == -1;
  }

  int size() {
    return _size;
  }

  void push(int newElement) {
    if (_size == STACK_CAPACITY) {
      throw std::runtime_error("Maximum capacity is reached.");
    }
    arr[++_top] = newElement;
    _size++;
  }

  void pop() {
    if (isEmpty()) {
      throw std::runtime_error("The stack is empty.");
    }
    _top--;
    _size--;
  }

  int top() {
    if (_top < 0) {
      throw std::runtime_error("The stack is empty.");
    }
    return arr[_top];
  }
};

int main() {
  Stack s;
  s.push(5);
  s.push(7);
  s.push(2);

  while (!s.isEmpty()) {
    cout << s.top() << " ";
    s.pop();
  }
  cout << endl;
  
  return 0;
}