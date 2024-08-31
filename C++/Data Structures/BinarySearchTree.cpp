#include <iostream>
#include <cassert>

class BinarySearchTree {
private:
  struct Node {
    int value;
    Node* left;
    Node* right;

    Node(int value) : value(value) {
      left = right = nullptr;
    }
  };

  Node* root;
  size_t _size;

public:
  BinarySearchTree() {
    root = nullptr;
    _size = 0;
  }

  size_t size() {
    return _size;
  }

  void add(int value) {
    if (!root) {
      root = new Node(value);
    } else {
      add(root, value);
    }
    ++_size;
  }

  void remove(int value) {
    if (root && root->value == value) {
      eraseMemory(root);
      root = nullptr;
    } else {
      remove(root, value);
    }
  }

  bool contains(int num) {
    return contains(root, num);
  }

  ~BinarySearchTree() {
    eraseMemory(root);
  }

private:
  bool contains(Node* node, int value) {
    return node && (node->value == value || contains(node->left, value) || contains(node->right, value));
  }

  void add(Node* node, int value) {
    if (value <= node->value) {
      if (!node->left) {
        node->left = new Node(value);
      } else {
        add(node->left, value);
      }
    } else {
      if (!node->right) {
        node->right = new Node(value);
      } else {
        add(node->right, value);
      }
    }
  }

  void remove(Node* node, int value) {
    if (node) {
      if (node->left->value == value) {
        eraseMemory(node->left);
        node->left = nullptr;
      } else if (node->right->value == value) {
        eraseMemory(node->right);
        node->right = nullptr;
      } else if (node->value > value) {
        remove(node->left, value);
      } else {
        remove(node->right, value);
      }
    }
  }

  void eraseMemory(Node* node) {
    if (node) {
      eraseMemory(node->left);
      eraseMemory(node->right);
      delete node;
      _size--;
    }
  }
};

int main() {
  BinarySearchTree bst;
  bst.add(4);
  bst.add(1);
  bst.add(7);
  bst.add(8); 
  bst.add(6);

  assert(bst.size() == 5);

  bst.remove(7);

  assert(bst.size() == 2);
  assert(bst.contains(1));
  assert(bst.contains(4));
  assert(!bst.contains(6));
  assert(!bst.contains(7));
  assert(!bst.contains(8));

  std::cout << "Everything works fine :)" << std::endl;

  return 0;
}