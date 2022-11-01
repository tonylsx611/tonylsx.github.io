---
title: Socket网络编程1
date: 2022-09-17 19:13:23
author: Tony
tags:
  - Socket
  - Client
  - Server
categories:
  - 计算机网络
---

# Server 通信步骤

1. **Socket()** to Create a TCP socket 
2. **Bind()** to Assign a port to socket 
3. Set socket to **Listen** 
4. **Accept** new connection 
5. **Communicate** 
6. **Close** the connection

## Windows C++版

```c
#pragma comment(lib, "ws2_32.lib")
#include <iostream>
#include <cstdlib>
#include <string>
#include <winsock2.h>
#include <io.h>
using namespace std;

int main(void)
{
	//初始化模块，仅Windows系统需要
	WORD sockVersion = MAKEWORD(2, 2);
	WSADATA wsdata;
	if (WSAStartup(sockVersion, &wsdata) != 0)
	{
		cout << "Initialize Error!"<<endl;
		exit(-1);
	}
	//建立socket
	SOCKET s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	//IPPROTO_TCP参数也可写为0
	if (s == INVALID_SOCKET)
	{
		cout << "socket Error!" << endl;
		exit(-1);
	}
	
	sockaddr_in ss;
	memset(&ss, 0, sizeof(ss));
	ss.sin_family = AF_INET;//IPv4
	ss.sin_port = htons(6666);//port No.
	ss.sin_addr.s_addr = htonl(INADDR_LOOPBACK); 
    //INADDR_LOOPBACK：默认本机IP地址127.0.0.1
    //Windows不支持INADDR_ANY写法，默认IP地址为0.0.0.0
	//Windows支持该种写法：inet_addr("127.0.0.1")
    //bind:socket绑定IP地址和端口用于监听
	if (bind(s, (sockaddr*)&ss, sizeof(ss)) == SOCKET_ERROR)
	{
		cout<<"Bind Error!"<<endl;
		exit(-1);
	}
    //listen:设定可同时排队的Client最大连接个数
    if(listen(s, 10) < 0)
    {
        cout<<"Listen Error!"<<endl;
        return -1;
    }
    cout<<"Waiting for Clients request..."<<endl;
    //accept:等待客户端链接
    sockaddr_in clnt_addr;
    int clnt_addr_size = sizeof(clnt_addr);
    int fd = accept(s, (sockaddr*)&clnt_addr, &clnt_addr_size);
    //int fd = accept(s, (sockaddr*)NULL, NULL);
    if (fd < 0)
    {
        cout<<"Accept Error"<<endl;
        exit(-1);
    }
    //Linux或Mac是write()函数
    string message = "Hello Client!";
    send(fd, message.c_str(), message.length(), 0);
    //Linux或Mac是close()函数
    closesocket(fd);
    closesocket(s);
    return 0;
}
```

## Linux/Mac C版

```c
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
#include <ctype.h>

int main()
{
	//建立socket套接字 注意是int类型
	int listenfd = socket(AF_INET, SOCK_STREAM, 0);
	if(listenfd < 0)	
	{
		printf("Socket Error!\n");
		exit(-1);
	}
	struct sockaddr_in st_sersock;
	memset(&st_sersock, 0, sizeof(st_sersock));
	st_sersock.sin_family = AF_INET;  //IPv4协议
	st_sersock.sin_addr.s_addr = htonl(INADDR_ANY);//127.0.0.1
	//INADDR_ANY是0.0.0.0指的是本机IP地址
	//Windows要写成INADDR_LOOPBACK
	st_sersock.sin_port = htons(6666);//host number
	//Socket绑定IP和端口用于监听
	if(bind(listenfd,(struct sockaddr*)&st_sersock, sizeof(st_sersock)) < 0) 
	{
		printf("Bind Error!\n");
		exit(-1);
	}
	//设定可同时排队的客户端最大连接个数
	if(listen(listenfd, 10) < 0)	
	{
		printf("Listen Error!\n");
		exit(-1);
	}
	//准备接受客户端连接
	printf("======Waiting for client's request======\n");
	//阻塞等待客户端连接
	int connfd = accept(i_listenfd, (struct sockaddr*)NULL, NULL));
	if(connfd < 0)	
	{
		printf("Accept Error!\n");
		exit(-1);
	}	
	else
		printf("Client %d, welcome!\n", connfd);
	char msg[32] = "Hello Client!";
	//将msg发送到Client端
	write(connfd, message, sizeof(message));
	//Windows下是closesocket	
	close(connfd);
	close(listenfd);
	return 0;
}
```

## Python版

```python
import socket
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
except Exception:
    print("Socket Error!")
# listen port
try:
    s.bind(('127.0.0.1', 6666))
except Exception:
    print("Bind Error!")
try:
    s.listen(5)
except Exception:
    print("Listen Error!")
print('Waiting for connection...')
try:
	sock, addr = s.accept()
except Exception:
    print("Accept Error!")
print(addr)  # (Id, port)
msg = "Hello Client!"
sock.send(msg)
sock.close()
exit(0)
```

# Client通信步骤

1. **Socket()** to Create a TCP socket
2.  Establish **connection**
3. Communicate (**read**) 
4. **Close** the connection

## Windows C++版

```c
#pragma comment(lib, "ws2_32.lib")
#include <iostream>
#include <cstdlib>
#include <string>
#include <winsock2.h>
using namespace std;

int main(void)
{
    //初始化模块，仅Windows系统需要
    WORD sockVersion = MAKEWORD(2, 2);
    WSADATA wsdata;
    if (WSAStartup(sockVersion, &wsdata) != 0)
    {
        cout << "Initialize Error!"<<endl;
        exit(-1);
    }
    SOCKET s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (s == INVALID_SOCKET)
    {
        cout<<"Invalid Socket!"<<endl;
        exit(-1);
    }
    sockaddr_in ss;
    ss.sin_family = AF_INET;//IPv4
    ss.sin_port = htons(6666);//port No.
    ss.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    if(connect(s, (sockaddr*)&ss, sizeof(ss)) == SOCKET_ERROR)
    {
        cout<<"Connect Error!"<<endl;
        closesocket(s);
        exit(-1);
    }
    string message;
    //LInux或Mac是read()函数
    //read函数第三个参数必须为固定值，不能使用message.length()
    //因为message.length()对于c++的string来说初始值为0！
    if (recv(s, message.c_str(), 128, 0))
        cout<<message<<endl;
    closesocket(s);
    return 0;
}
```

## Linux/Mac C版

```c
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
#include <ctype.h>

int main(void)
{
    int s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (s == INVALID_SOCKET)
    {
        printf("Invalid Socket!\n");
        exit(-1);
    }
    sockaddr_in ss;
    ss.sin_family = AF_INET;//IPv4
    ss.sin_port = htons(6666);//port No.
    ss.sin_addr.s_addr = htonl(INADDR_ANY);
    if(connect(s, (sockaddr*)&ss, sizeof(ss)) == SOCKET_ERROR)
    {
        printf("Connect Error!\n");
        close(s);
        exit(-1);
    }
    char message[32];
    if (read(s, message, sizeof(message)))
        printf("%s", message);
    close(s);
    return 0;
}
```

## Python版

```python
import socket
try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
except Exception:
    print("Socket Error!")
# listen port
try:
	s.connect(('127.0.0.1', 6666))
except Exception:
    print("Connection Error!")
s.recv(256).decode('utf-8')
s.send(b'exit')
s.close()
exit(0)
```

---

下一篇：[Socket网络编程2 | Tony](http://tonylsx.top/2022/10/14/socket-program-2/)
