---
title: BFS简介
date: 2022-03-10 17:43:09
tags:
	- algorithm
	- BFS
	- DFS
categories:
	- algorithm
katex: true
---

## BFS基本概念

**广度优先算法**（Breadth-First-Search），简称BFS，是一种图形搜索演算法，最糟糕的情况算法时间复杂度为O(V+E)。简单的说，BFS是从根节点开始，沿着树的宽度遍历树的节点，如果发现目标，则演算终止。

## **经典例题**

------

### 1. 填涂颜色

#### 题目描述

由数字$0$组成的方阵中，有一任意形状闭合圈，闭合圈由数字$1$构成，围圈时只走上下左右$4$个方向。现要求把闭合圈内的所有空间都填写成$2$。例如：$6×6$的方阵$(n=6)$，涂色前和涂色后的方阵如下：

```bash
0 0 0 0 0 0
0 0 1 1 1 1
0 1 1 0 0 1
1 1 0 0 0 1
1 0 0 0 0 1
1 1 1 1 1 1
-----------
0 0 0 0 0 0
0 0 1 1 1 1
0 1 1 2 2 1
1 1 2 2 2 1
1 2 2 2 2 1
1 1 1 1 1 1
```

#### 输入格式

每组测试数据第一行一个整数$n(1≤n≤30)$

接下来$n$行，由$0$和$1$组成的$n×n$的方阵。

方阵内只有一个闭合圈，圈内至少有一个$0$。

#### 输出格式

已经填好数字$2$的完整方阵。

#### 输入输出样例

**输入 #1**

```bash
6
0 0 0 0 0 0
0 0 1 1 1 1
0 1 1 0 0 1
1 1 0 0 0 1
1 0 0 0 0 1
1 1 1 1 1 1
```

**输出 #1**

```bash
0 0 0 0 0 0
0 0 1 1 1 1
0 1 1 2 2 1
1 1 2 2 2 1
1 2 2 2 2 1
1 1 1 1 1 1
```

#### 说明/提示

$1≤n≤30$

#### 答案解析

```c
#include<iostream>
using namespace std;
int num[40][40];
int main()
{
    int c,i,j,k;
    cin>>c;
    for(i=1;i<=c;i++)
		for(j=1;j<=c;j++)
    {
        cin>>num[i][j];
        if(num[i][j]==0)
			num[i][j]=2;
        //先认为所有的0都应该被修改,并且真的把它修改成了2;
    }
    for(i=1;i<=c;i++)
    {
        //边角上的'2'其实本来不应该被修改的,那我们把他们改回去,改成0
        if(num[1][i]==2)
			num[1][i]=0;
        if(num[i][1]==2)	
			num[i][1]=0;
        if(num[c][i]==2)
			num[c][i]=0;
        if(num[i][c]==2)
			num[i][c]=0;
    }
    //然后来寻找与这些零相邻的'2',它们其实也是被改错了的
    for(k=1;k<=100;k++)//广度优先搜索 阈值=100 (事实上不需要那么多)
    	for(i=1;i<=c;i++)
    		for(j=1;j<=c;j++)
    		    if(num[i][j]!=1)
    			    if(!num[i][j-1]||!num[i-1][j]||!num[i+1][j]||!num[i][j+1])
    				    num[i][j]=0; 
    for(i=1;i<=c;i++)
    {
        for(j=1;j<=c;j++)
        cout<<num[i][j]<<" ";
        cout<<endl;
    }
    return 0;
}
```

当然，本题仍可以用DFS来做：

```c
#include <cstdio>
using namespace std;
int n;
int a[32][32];
void dfs(int x, int y)
{
    if(x >= 0 && x <= n + 1 && y >= 0 && y <= n + 1)
    {
        if(a[x][y] == 1 || a[x][y] == 3) 
        	return ;
        else
        {
        	a[x][y] = 3;
            dfs(x + 1, y); 
            dfs(x - 1, y);
            dfs(x, y + 1); 
            dfs(x, y - 1);
        }
    }
}
int main()
{
    scanf("%d", &n);
    for(int i = 1; i <= n; ++ i)
    	for(int j = 1; j <= n; ++ j)
    		scanf("%d", &a[i][j]);
    dfs(0, 0);
    for(int i = 1; i <= n; ++ i)
    	for(int j = 1; j <= n; ++ j)
    		if(a[i][j] == 3) 
    			a[i][j] = 0;
    		else 
    			if(a[i][j] == 0) 
    				a[i][j] = 2;
    for(int i = 1; i <= n; ++ i)
    {
    	for(int j = 1; j <= n; ++ j) 
    		printf("%d ", a[i][j]);
    	printf("\n")
    }
    return 0;
}
```

注意：dfs在先搜索的时候应该搜索到矩阵的外面一圈$(0， n + 1)$ 否则的话就会出现错误！(边缘处被涂色)

------

### 01迷宫

#### 题目描述

有一个仅由数字$0$与$1$组成的$n×n$格迷宫。若你位于一格$0$上，那么你可以移动到相邻$4$格中的某一格$1$上，同样若你位于一格$1$上，那么你可以移动到相邻$4$格中的某一格$0$上。

你的任务是：对于给定的迷宫，询问从某一格开始能移动到多少个格子（包含自身）。

#### 输入格式

第$1$行为两个正整数$n,m$。

下面$n$行，每行*$n$*个字符，字符只可能是$0$或者$1$，字符之间没有空格。

接下来$m$行，每行$2$个用空格分隔的正整数$i,j$，对应了迷宫中第$i$行第$j$列的一个格子，询问从这一格开始能移动到多少格。

#### 输出格式

$m$行，对于每个询问输出相应答案。

#### 输入输出样例

**输入 #1**

```bash
2 2
01
10
1 1
2 2
```

**输出 #1**

```bash
4
4
```

#### 说明/提示

对于20%的数据，$n≤10$；

对于40%的数据，$n≤50$；

对于50%的数据，$m≤5$；

对于60%的数据，$n*≤100,*m≤100$；

对于100%的数据，$n*≤1000,*m≤100000$。

#### 答案解析

BFS，70分代码：

```c
#include<iostream>
#include<cstring>
using namespace std;
struct mg
{
    int x,y;
};
bool map[1001][1001];
bool flag[1001][1001];
mg q[1000001];
int m,n;
void bfs(int x,int y);
int main()
{
	cin>>n>>m;
	char ch;
	for(int i=1;i<=n;i++)
		for(int j=1;j<=n;j++)
		{
			cin>>ch;
			if(ch=='1')
				map[i][j]=true;
		}
	for(int i=0;i<m;i++)
	{
		int x,y;
		cin>>x>>y;
		bfs(x,y);
	}
	return 0;
}
void bfs(int x,int y)
{
	int dx[4]={0,0,-1,1};
    int dy[4]={1,-1,0,0};
    int ans,f,r,newx,newy;
    ans=f=r=1;
    q[f].x=x;
    q[f].y=y;
    memset(flag,false,sizeof(flag));
    flag[x][y]=true;
    while(f<=r)
    {
    	for(int i=0;i<4;i++)
    	{
    		newx=q[f].x+dx[i];
    		newy=q[f].y+dy[i];
    		if(newx>0 && newx<=n && newy>0 && newy<=n && !flag[newx][newy])
    			if((map[q[f].x][q[f].y]==0 && map[newx][newy]==1) || (map[q[f].x][q[f].y]==1 && map[newx][newy]==0))
    			{
    				r++;
    				ans++;
    				flag[newx][newy]=true;
    				q[r].x=newx;
    				q[r].y=newy;
				}
		}
		f++;
	}
	cout<<ans<<endl;
 } 
```

有三个点TEL，所以对代码进行一定时间优化，学名叫记忆化搜索，以时间换空间，优化如下：

```c
#include<iostream>
#include<cstring>
using namespace std;
struct mg
{
    int x,y;
};
bool map[1001][1001];
bool flag[1001][1001];
int a[1001][1001];
mg q[5000001];
int m,n;
void bfs(int x,int y);
int main()
{
	cin>>n>>m;
	char ch;
	for(int i=1;i<=n;i++)
		for(int j=1;j<=n;j++)
		{
			cin>>ch;
			if(ch=='1')
				map[i][j]=true;
		}
	for(int i=0;i<m;i++)
	{
		int x,y;
		cin>>x>>y;
		if(a[x][y]==0)
			bfs(x,y);
		else
			cout<<a[x][y]<<endl;
	}
	return 0;
}
void bfs(int x,int y)
{
	int dx[4]={0,0,-1,1};
    int dy[4]={1,-1,0,0};
    int ans,f,r,newx,newy;
    ans=f=r=1;
    q[f].x=x;
    q[f].y=y;
    memset(flag,false,sizeof(flag));
    flag[x][y]=true;
    while(f<=r)
    {
    	for(int i=0;i<4;i++)
    	{
    		newx=q[f].x+dx[i];
    		newy=q[f].y+dy[i];
    		if(newx>0 && newx<=n && newy>0 && newy<=n && !flag[newx][newy])
    			if((map[q[f].x][q[f].y]==0 && map[newx][newy]==1) || (map[q[f].x][q[f].y]==1 && map[newx][newy]==0))
    			{
    				r++;
    				ans++;
    				flag[newx][newy]=true;
    				q[r].x=newx;
    				q[r].y=newy;
				}
		}
		f++;
	}
	for(int i=1;i<n;i++)
		for(int j=1;j<n;j++)
			if(flag[i][j])
				a[i][j]=ans;
	cout<<ans<<endl;
 } 
```

当然，本题也可以用DFS来做，读者可以先自行写一写，不要看下面的答案：

```c
#include<cstdio>
#include<cstring>
int n,m,x,y;
int ans[100002],f[1002][1002];
char s[1002][1002];
void dfs(int r,int c,int z,int lll)
{
    if (r<0 || r>=n || c<0 || c>=n || f[r][c]!=-1 || s[r][c]-'0'!=z)
        return;
    f[r][c]=lll;
    ans[lll]++;
    dfs(r-1,c,!z,lll);
    dfs(r+1,c,!z,lll);
    dfs(r,c-1,!z,lll);
    dfs(r,c+1,!z,lll);
}
int main()
{
    scanf("%d%d",&n,&m);
    for (int i=0;i<n;i++)
    	scanf("%s",s[i]);
    memset(f,-1,sizeof(f));
    for (int i=0;i<m;i++)
    {
        scanf("%d%d",&x,&y);
        x--;
        y--;
        if (f[x][y]==-1)
            dfs(x,y,s[x][y]-'0',i);
        else 
            ans[i]=ans[f[x][y]];
    }
    for (int i=0;i<m;i++)
    	printf("%d\n",ans[i]);
    return 0;
}
```

$$
END
$$

