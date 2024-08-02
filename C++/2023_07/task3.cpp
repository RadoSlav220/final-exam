#include <iostream>

using namespace std;

class Tree {
private:
  struct Node {
    int x;
    int y;
    Node* STleft;
    Node* STmid;
    Node* STright;

    Node(int n) {
      x = y = n;
    }
  };

  Node* root;

public: 
  Tree() {
    root = nullptr;
  }

  void insert(int n) {
    insertIntoNode(root, n);
  }

  bool find(int n) {
    return findInNode(root, n);
  }

  ~Tree(){
    clearMemory(root);
  }

private:
  void insertIntoNode(Node*& node, int n) {
    if (node == nullptr) {
      node = new Node(n);
    } else if (node->x > n) {
      insertIntoNode(node->STleft, n);
    } else if (node->x == n) {
      insertIntoNode(node->STmid, n);
    } else if (node->x == node->y) {
      node->y = n;
    } else if (node->y > n) {
      insertIntoNode(node->STmid, n);
    } else {
      insertIntoNode(node->STright, n);
    }
  }

  bool findInNode(Node* const node, int n) {
    return node != nullptr && 
          (node->x == n || node->y == n || 
          (node->x > n && findInNode(node->STleft, n)) ||
          (node->x <= n && node->y > n && findInNode(node->STmid, n)) ||
          (node->y < n && findInNode(node->STright, n)));
  }

  void clearMemory(Node* node) {
    if (node != nullptr) {
      clearMemory(node->STleft);
      clearMemory(node->STmid);
      clearMemory(node->STright);
      delete node;
    }
  }
};

void populateTree(Tree*& tree) {
  int n;
  cin >> n;
  for (int i = 0; i < n; i++) {
    int x;
    cin >> x;
    tree->insert(x);
  }
}

void checkPresenceOfANumber(Tree* const tree) {
  int numberToCheckIfPresent;
  cin >> numberToCheckIfPresent;

  bool isPresent = tree->find(numberToCheckIfPresent);
  
  if (isPresent) {
    cout << "It is here :)" << endl;
  } else {
    cout << "It is not here :(" << endl;
  }
}

int main() {
  Tree* t = new Tree();

  populateTree(t);
  checkPresenceOfANumber(t);
  
  delete t;
  
  return 0;
}