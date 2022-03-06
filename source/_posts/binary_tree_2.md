---
title: 数组与链式二叉树的转换
date: 2022-02-24 22:20:55
author: Tony
categories:
	- algorithm
tags: 
	- Binary-tree
	- algorithm
katex: false
---

## 前言

对二叉树不是很了解的同学可以先看一下我之前的文章：

[链式二叉树简介](https://tonylsx611.github.io/2022/02/25/binary_tree_1/)

## 正文

在了解二叉树的基本原理后，我们尝试将一个数组转化成链表形式的二叉树，之后将二叉树以中序遍历打印出来。整个的过程即==数组——链表——数组==。

幸运的是，正好在leetcode中有着一道非常相似的题，所以我就直接拿来使用了，链接如下：

[94. 二叉树的中序遍历 – 力扣（LeetCode） (leetcode-cn.com)](https://leetcode-cn.com/problems/binary-tree-inorder-traversal/)

我们稍加修改，首先声明一个int类型的数组，然后把它放入链表二叉树中，如图所示：

![img](binary_tree_2/image.png)

```
int arr[7] = { 1, 2, 3, 4, 5, NULL, 6 };
```

之后的任务就是将数组转化为链表形式，链表的定义如下：

```
struct TreeNode 
{
    int val;
    TreeNode* left;
    TreeNode* right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode* left, TreeNode* right) : val(x), left(left), right(right) {}
};
```

转化为链表过后，剩下的事情就很容易了，无非就是前中后序的遍历，我们在[上一个blog](https://tonylsx611.github.io/2022/02/25/binary_tree_1/)中已经有详细的介绍，这里更希望大家掌握迭代的算法，而非递归；因为递归在电脑的底层逻辑中，依然是维护一个栈。

## 代码

那么全部的代码如下，不做过多解释，有疑问可以在留言板留言。

```
#include<iostream>
#include<vector>
using namespace std;
struct TreeNode {
...};
class Solution {
public:
    int arr[7] = { 1, 2, 3, 4, 5, NULL, 6 };
    void inorder(TreeNode* root, vector<int>& res)//中序遍历
    {
        if (root == nullptr)
            return;

        inorder(root->left, res);
        res.push_back(root->val);
        inorder(root->right, res);
    }
    vector<int> inorderTraversal(TreeNode* root)//递归法
    {
        vector<int> ans;
        inorder(root, ans);
        return ans;
    }
    vector<int> inorderTraversal(TreeNode* root)//迭代法
    {
        vector<int> ans;
        stack<TreeNode*> stk;
           
        while (1)
        {
            if (root != nullptr)
            {
                stk.push(root);
                root = root->left;
            }
            else if (!stk.empty())
            {
                root = stk.top();
                stk.pop();
                ans.push_back(root->val);
                root = root->right;
            }
            else
                return ans;
        }
        
    }
    TreeNode* addtree(TreeNode* tree, int arr[], int i)//数组转链表
    {
        if (arr[i] == 0)
            return NULL;
        if (i < 7)//arr.length()
        {
            TreeNode* tree = new TreeNode();
            
            tree->val = arr[i];
            tree->left = addtree(tree, arr, i + i + 1);
            tree->right = addtree(tree, arr, i + i + 2);
            return tree;
        }
        return NULL;
    }
};

int main()
{
    Solution sol;
    TreeNode* tree = NULL;
    tree= sol.addtree(tree, sol.arr, 0);
    sol.inorderTraversal(tree);
    for(int i= 0; i< sol.inorderTraversal(tree).size(); i++)
        cout << sol.inorderTraversal(tree)[i]<<" ";
    return 0;
}
```