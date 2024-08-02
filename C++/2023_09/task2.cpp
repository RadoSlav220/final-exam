/*


virtual std::vector<SearchResult> search(const std::string&) const = 0;

Document(std::string &name, std::string &contents): ???

std::vector<SearchResult> search(std::string &str) const



std::vector<File> files;
Folder(std::string &name): ???

void addFile(const File& f)
*/

#include <iostream>
#include <string>
#include <vector>
#include <sstream>

struct SearchResult
{
  std::string fileName;
  unsigned line_number;
  std::string line;
};

const std::string &fileName = "file.txt";
const std::string &content = "Ivan Petrov\nJane Smith\nsomething funny";

SearchResult func(std::string str) {
  SearchResult result;
  std::stringstream strStream;
  strStream << content;

  unsigned currentLineNumber = 1;
  std::string currentLine;
  while(getline(strStream, currentLine)) {
    if (currentLine.find(str) != std::string::npos) {
      result.fileName = fileName;
      result.line = currentLine;
      result.line_number = currentLineNumber;
      return result;
    }
    currentLineNumber++;
  }

  return result;
}


int main() {
  SearchResult sr = func(std::string("Smith"));
  std::cout << sr.fileName << "\n" << sr.line << "\n" << sr.line_number << std::endl;
  return 0;
}