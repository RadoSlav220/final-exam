#include <iostream>
#include <vector>

using std::cout;
using std::endl;
using std::vector;

struct Node {
  int value;
  vector<Node*> children;

  Node(int value) : value(value) {}
};

class Tree {
private:
  Node* root;
  size_t _size;

public:
  Tree() {
    root = nullptr;
    _size = 0;
  }

  bool isEmpty() {
    return _size == 0;
  }
  
  size_t size() {
    return _size;
  }

  void add(int newValue, Node* parent = nullptr) {
    Node* newNode = new Node(newValue);

    if (!root) {
      root = newNode;
    } else if (!parent) {
      root->children.push_back(newNode);
    } else {
      parent->children.push_back(newNode);
    }

    _size++;
  }

  void removeByValue(int value) {
    if (root && root->value == value) {
      freeMemory(root);
      root = nullptr;
    } else {
      removeByValue(root, value);
    }
  }

  Node* find(int value) {
    return find(root, value);
  }

  ~Tree() {
    freeMemory(root);
  }

private:
  void removeByValue(Node* node, int value) {
    if (!node) {
      return;
    }

    for (int i=0; i<node->children.size(); i++) {
      if (node->children[i]->value == value) {
        freeMemory(node->children[i]);
        node->children.erase(node->children.begin() + i);
      } else {
        removeByValue(node->children[i], value);
      }
    }
  }

  Node* find(Node* node, int value) {
    if (!node) {
      return nullptr;
    } 
    
    if (node->value == value) {
      return node;
    } 

    for (int i=0; i<node->children.size(); i++) {
      Node* found = find(node->children[i], value);
      if (found) {
        return found;
      }
    }

    return nullptr;
  }

  void freeMemory(Node* node) {
    if (!node) {
      return;
    }

    for (int i=0; i<node->children.size(); i++) {
      freeMemory(node->children[i]);
    }

    delete node;
    _size--;
  }
};

int main() {
  Tree t;
  t.add(4);
  t.add(7);
  t.add(9);
  t.add(10);

  Node* p1 = t.find(7);
  t.add(18, p1);

  cout << t.size() << endl;
  cout << t.find(18)->children.size() << endl;

  t.removeByValue(7);
  cout << t.size() << endl;
  
  t.removeByValue(4);
  cout << t.size() << endl;

  return 0;
}
