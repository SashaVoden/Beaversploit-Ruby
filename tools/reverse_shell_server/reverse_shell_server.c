#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 4444

void handle_client(int client_socket) {
    char buffer[1024];

    while (1) {
        printf("> ");
        fgets(buffer, sizeof(buffer), stdin);
        send(client_socket, buffer, strlen(buffer), 0);
        recv(client_socket, buffer, sizeof(buffer), 0);
        printf("%s", buffer);
    }

    close(client_socket);
}

int main() {
    int server_socket, client_socket;
    struct sockaddr_in server_addr, client_addr;
    socklen_t addr_size = sizeof(client_addr);

    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);

    bind(server_socket, (struct sockaddr*)&server_addr, sizeof(server_addr));
    listen(server_socket, 1);
    printf("Server started on port %d, waiting...\n", PORT);

    client_socket = accept(server_socket, (struct sockaddr*)&client_addr, &addr_size);
    handle_client(client_socket);

    close(server_socket);
    return 0;
}