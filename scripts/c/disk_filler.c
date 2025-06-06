#include <stdio.h>

int main() {
    FILE *file = fopen("hugefile.txt", "wb");
    for (long long i = 0; i < 1e10; i++) {
        fputc('A', file);
    }
    fclose(file);
    return 0;
}