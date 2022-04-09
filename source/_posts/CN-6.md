---
title: Computer Network 6 - Layer 5-7 Technology, Application Protocols
date: 2022-04-08 23:42:16
tags:
	- computer network
categories:
	- 计算机网络
author: Tony
katex: true
---

#### Layer 5-7 Technology, Application Protocols

#### Layer 5-7 technologies

###### What are the two types of application communications?

Peer-to-peer Communications

Client-Server Communications

###### List some Application layer protocols that is familiar

▪ Domain Name System (DNS) 

▪ Hypertext Transfer Protocol (HTTP) 

▪ File Transfer Protocol (FTP) 

▪ Trivial File Transfer Protocol (TFTP) 

▪ Telnet 

▪ Simple Mail Transfer Protocol (SMTP) 

▪ Post Office Protocol, version 3 (POP3) 

▪ Simple Network Management Protocol (SNMP)

###### What is the operations of DNS? What is the difference between the authoritative or non-authoritative DNS records?

These article is worth to read: 

[DNS 是什么？如何运作的？ - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/350054986)

[DNS运作方式 - 简书 (jianshu.com)](https://www.jianshu.com/p/441de4542245)

###### What is the operations of HTTP? 

Client use HTTP Protocol to request information from Server

Server then send the information(like HTML, CSS) to Client

Note that the HTTP Protocol is a stateless protocol

###### What is the format of URL?

URL: `https://Tony:tonytony@must.icu/menu/folder1/answer.html`

Protocol: `https://`

Username&password:`Tony:tonytony`

Domain name:`www.must.icu`

Folder&file:`menu/folder1/answer.html`

###### What is the operations of email system using SMTP and POP3?

Client use SMTP Protocol to send packages to Server

Server use POP3 Protocol to receive packages to Client 

Note that as long as the packages sent to the Server, Client will receive “send the E-mail successfully”, but actually we cannot guarantee that another has received the E-mail or not.



---

![image-20211207025902517](CN-6/image-20211207025902517.png)

Domain name: www.must.edu.mo

Application protocol: HTTP (Note that the application protocol is only depend on `http://`)

Transport protocol: TCP (just recite it)