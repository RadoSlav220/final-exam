#include <iostream>

using std::cout;
using std::endl;

class List {
private:
  struct Node {
    int value;
    Node* next;
    Node(int value, Node* next) : value(value), next(next) {}
  };

  Node* first;
  int _size;

public:
  List() {
    first = nullptr;
    _size = 0;
  }

  bool isEmpty() {
    return _size == 0;
  }

  int size() {
    return _size;
  }

  void push_front(int num) {
    Node* newFirst = new Node(num, first);
    first = newFirst;
    _size++;
  }

  void pop_front() {
    if (!first) {
      throw std::runtime_error("The List is empty.");
    }
    Node* temp = first;
    first = first->next;
    delete temp;
    _size--;
  }

  void insert(int num, int pos) {
    if (pos > _size || pos < 0) {
      throw std::out_of_range("Position is out of range");
    }

    if (pos == 0) {
      push_front(num);
    } else {
      Node* prev = first;
      
      for (int i=1; i<pos; i++) {
        prev = prev->next;
      }

      Node* newNode = new Node(num, prev->next);
      prev->next = newNode;
    }

    _size++;
  }

  void dropElement(int num) {
    if (!first) {
      throw std::runtime_error("List is empty");
    }

    if (first->value == num) {
      pop_front();
    } else {
      Node* prev = first;
      Node* it = first->next;
      while(it && it->value != num) {
        prev = it;
        it = it->next;
      }

      if (!it) {
        throw std::invalid_argument("This element is not in the list.");
      }

      prev->next = it->next;
      delete it;
    }

    _size--;
  }

  bool contains(int num) {
    Node* it = first;

    while(it && it->value != num) {
      it = it->next;
    }

    return it;
  }

  void print() {
    Node* it = first;
    while(it) {
      cout << it->value << " ";
      it = it->next;
    }
    cout << endl;
  }

  ~List() {
    while (first) {
      Node* temp = first;
      first = first->next;
      delete temp;
    }
    _size = 0;
  }
};


int main() {
  List l;
  l.push_front(1);
  l.push_front(3);
  l.push_front(4);
  l.insert(12, 0);
  // 12 4 3 1

  l.print();
  cout << l.contains(4) << endl;
  cout << l.contains(12) << endl;
  cout << l.contains(3) << endl;
  cout << l.contains(11) << endl;

  l.dropElement(12);
  l.dropElement(1);
  l.print();

  l.pop_front();
  cout << l.contains(4) << endl;
  cout << l.contains(12) << endl;
  cout << l.contains(3) << endl;
  cout << l.contains(11) << endl;

  return 0;
}