---
title: KMP字符串匹配算法
date: 2022-04-14 18:55:04
tags:
	- KPM
	- algorithm
categories:
	- algorithm
author: Tony
katex: true
---

## 算法简介

KMP 算法（Knuth-Morris-Pratt 算法）是一个著名的字符串匹配算法，这个算法由Donald Knuth、Vaughan Pratt、James H. Morris三人于1977年联合发表，故取这3人的姓氏命名此算法。

该算法的执行时间是线性的，且只需要对目标字符串进行预处理，而非搜索的字符串；此算法利用这一特性以避免重新检查先前配对的字符。

该算法通常与BM算法同时被人们提及和熟知，其时间复杂度与空间复杂度均相同，但多数情况下KPM算法实际速度略逊一筹，如果还不了解BM算法，可以参考我的这篇文章：[BM字符串匹配算法 | Tony (tonylsx.top)](http://tonylsx.top/2022/03/27/BM-algorithm/)

## KMP算法原理



## KMP的实现



## 完整代码

```cpp
#include <iostream>
#include <string>
using namespace std;
const int len=10000;
int dp[len][256];
string str,substr;

void KMP(string pat)
{
    int M = pat.length();
    // dp[状态][字符] = 下个状态
    dp[0][pat[0]] = 1;// base case
    int X = 0;// 影子状态 X 初始为 0
    for (int j = 1; j < M; j++)// 构建状态转移图
    {
        for (int c = 0; c < 256; c++)
            dp[j][c] = dp[X][c];
        dp[j][pat[j]] = j + 1;
        X = dp[X][pat[j]];// 更新影子状态
    }
}

int search(string txt)
{
    int M = substr.length();
    int N = txt.length();

    int j = 0;// pat 的初始态为 0
    for (int i = 0; i < N; i++)
    {
        j = dp[j][txt[i]];// 计算 pat 的下一个状态
        if (j == M) // 到达终止态，返回结果
            return i - M + 1;
    }
    return -1;// 没到达终止态，匹配失败
}
int main()
{
    str="aaac5a9aab";
    substr="aaab";
    KMP(substr);
    int ans=search(str);
    cout<<ans<<endl;
    return 0;
}

```

