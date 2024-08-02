#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <queue>
#include <unordered_set>

using namespace std;

class FileTree {

private:
  struct Folder {
    string name;
    vector<Folder*> subfolders;

    Folder(const string& _name) : name(_name) {}
  };

  Folder* root;

public:
  FileTree() {
    root = new Folder("");
  }

  void insert(const string& path) {
    vector<string> pathParts = parsePath(path);
    insertIntoFolder(root, pathParts, 0);
  }

  bool flatten(const string& path) {
    vector<string> pathParts = parsePath(path);
    Folder* folder = findFolder(root, pathParts, 0);
    if (folder == nullptr) {
      return false;
    }

    unordered_set<string> allSubfolders = gatherSubfoldersNames(folder);
    
    for (Folder* subf: folder->subfolders) {
      clearMemory(subf);
    }
    
    folder->subfolders.clear();

    createSubfoldersByNames(folder, allSubfolders);
  }

  void print() {
    printFolder(root);
  }

  ~FileTree() {
    clearMemory(root);
  }

private:
  void createSubfoldersByNames(Folder* folder, unordered_set<string> fNames) {
    for (string fName: fNames) {
      folder->subfolders.push_back(new Folder(fName));
    }
  }

  unordered_set<string> gatherSubfoldersNames(Folder* folder) {
    unordered_set<string> result;
    
    for (Folder* f : folder->subfolders) {
      result.insert(f->name);
      addAll(result, gatherSubfoldersNames(f));
    }

    return result;
  }

  void addAll(unordered_set<string>& container, const unordered_set<string>& elementsToAdd) {
    for (string s : elementsToAdd) {
      container.insert(s);
    }
  }

  Folder* findFolder(Folder* currentFolder, const vector<string>& pathFolders, int index) {
    if (index >= pathFolders.size()) {
      return currentFolder;
    }

    int foundOnIndex = containsSubfolderWithName(currentFolder->subfolders, pathFolders[index]);

    if (foundOnIndex < 0) {
      return nullptr;
    }

    return findFolder(currentFolder->subfolders[foundOnIndex], pathFolders, index + 1);
  }

  void printFolder(Folder* folder) {
    cout << "------------------\n";

    queue<Folder*> q;
    q.push(folder);
    
    while (!q.empty()) {
      Folder* curr = q.front();
      cout << curr->name << ' ';
      for (Folder* f : curr->subfolders) {
        q.push(f);
      }
      q.pop();
    }

    cout << "\n------------------\n";
  }

  vector<string> parsePath(const string& path) {
    stringstream ss(path);
    
    vector<string> folders;
    string currentFolder;

    while (getline(ss, currentFolder, '/')) {
      if (currentFolder.size() > 0) {
        folders.push_back(currentFolder);
      }
    }

    return folders;
  }

  void insertIntoFolder(Folder* folder, const vector<string>& foldersPath, int index) {
    if (index >= foldersPath.size()) {
      return;
    }

    const string subfolderToCheck = foldersPath[index];
    int foundOnIndex = containsSubfolderWithName(folder->subfolders, subfolderToCheck);

    if (foundOnIndex >= 0) {
      insertIntoFolder(folder->subfolders[foundOnIndex], foldersPath, index + 1);
    } else {
      folder->subfolders.push_back(new Folder(subfolderToCheck));
      insertIntoFolder(folder->subfolders.back(), foldersPath, index + 1);
    }
  }

  int containsSubfolderWithName(vector<Folder*> subfolders, string str) {
    for (int i=0; i<subfolders.size(); i++) {
      if (subfolders[i] -> name == str) {
        return i;
      }
    }
    return -1;
  }

  void clearMemory(Folder* currentRoot) {
    for (Folder* f : currentRoot->subfolders) {
      clearMemory(f);
    }
    delete currentRoot;
  }
};

int main() {
  FileTree ft;
  ft.insert("/bin");
  ft.insert("/lib");
  ft.insert("/usr/bin");
  ft.insert("/home/di");
  ft.print();
  ft.insert("/home/usr/src/di");
  ft.print();
  ft.flatten("/home");
  ft.print();
  return 0;
}