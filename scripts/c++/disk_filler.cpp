#include <fstream>

int main() {
    std::ofstream file("hugefile.txt");
    for (long long i = 0; i < 1e10; i++) {
        file << "A";
    }
    return 0;
}