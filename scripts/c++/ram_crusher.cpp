#include <vector>

int main() {
    std::vector<char*> data;
    while (true) {
        data.push_back(new char[1024*1024]);
    }
    return 0;
}