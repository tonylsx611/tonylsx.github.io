---
title: Hexo多电脑同步指南
date: 2022-03-08 16:51:28
author: Tony
tags: 
	- Hexo
categories:
	- Hexo搭建
---

# 如何实现同步

Hexo的同步本质上很简单，使用`git`命令push一下，然后在另一台电脑pull一下就OK。但是我在实际的同步过程中却遇到了各种的报错，这篇文章同样也记录一下我遇到的问题，也为了后期我再次换电脑，或者再次遇到奇奇怪怪的报错做参考。

经过多次的试错后，总结了一些多电脑同步的固定方法，只需要严格按照下面的操作流程进行上载和更新文件，理论上就不会出现报错。如果出现了错误，可以参考下一章的常见报错处理。

简单的来说，GitHub就相当于是一个云盘，可以存储整个网页的数据。当我们在不同电脑更新文章的时候，需要先遵循以下步骤：

- 从云端更新内容到本地(git pull)
- 新建或修改文章
- 部署文章/测试页面内容(hexo deploy)
- 将更新后的文章同步到云端(git push)

如果多个设备同时更新文章 就极有可能出现本地内容与云端内容不符的情况，于是就会出现各种莫名其妙的报错。大多数情况下的解决方案都是再次从云端拉取新的内容，然后融合云端和本地数据(git merge) ，最后将融合后的数据同步到云端。

### 首次上传本地仓库到远程仓库

*注意所有命令都要在Hexo项目的目录下执行。

```bash
git init # 首先要在台式电脑上初始化git
git remote add origin https://github.com/username/username.github.io.git # 添加Github上的仓库地址
# username是你的GitHub的用户名
git checkout -b branch_name # 新建分支并切换到新建的分支
# branch_name随便起名字，不过最好简单一点，比如Hexo
git add . # 添加所有本地文件到本地的git
git commit -m "This is the first time to syn!" # 提交备注
# “这里的内容随便写，不过这句代码一定不要省略，后面会出问题！”
git push origin branch_name # 本地文件上传到hexo分支
```

### 首次下载远程仓库到本地仓库

*注意另一台电脑上要部署好所有的环境，如git，Nodejs，SSH等，详情参考：[Hexo 网站搭建指南](https://tonylsx611.github.io/2022/02/24/Hexo_creation/)

*注意所有命令都要在Hexo项目的目录下执行，没有目录的话找个地方新建一个。

```bash
git clone -b branch_name https://github.com/username/username.github.io
# 克隆分支到本地的博客文件夹
sudo npm install -g hexo-cli # install hexo
sudo npm install # 安装依赖库
sudo npm install hexo-deployer-git # git部署相关配置
```

# 同步编辑流程

### 从云端更新内容到本地

```bash
git pull origin branch_name   # 从Github同步数据到台式电脑
```

### 新建或修改文章

```bash
hexo new article_name  # 创建新的文章 
```

### 部署文章/测试页面内容

```bash
hexo clean
hexo deploy
hexo generate
hexo server
```

### 将更新后的文章同步到云端

```bash
git add .
git commit -m "your comments"
git push origin branch_name
```

只要严格按照以下流程操作，基本无忧。**一定要记得在测试页面之后及时更新文章到云端！！！**

# 同步过程中遇到的问题

### git pull文件冲突报错

![Screenshot 2022-03-08 161552](Hexo-synchronization/Screenshot%202022-03-08%20161552.png)

报错信息：

`error: Your local changes to the following files would be overwritten by merge`

报错原因：

在同步的时候出现两个相同文件名内容不同的文件，导致冲突；比如笔记本修改了之前的某个文章，在台式机`pull` 的时候就会产生这样的错误。

解决方法：

```bash
git stash # 备份工作区内容
git pull origin branch_name # 下载分支内容
git stash pop # 恢复工作区内容
```

### Clone后首次部署报错

![image-20220310172557250](Hexo-synchronization/image-20220310172557250.png)

报错信息：

```bash
fatal: in unpopulated submodule '.deploy.git'
FATAL:{
	error: Error: Spawn failed
		...
}
```

报错原因：

克隆远程分支到本地电脑的时候，把`.deploy.git`也一并克隆了过来，这个文件夹是部署到master的临时缓存文件夹，是另一个电脑部署用的，因此会产生冲突。

解决方法：

删掉本地的`.deploy.git`文件夹，重新部署。如果还有问题，可能是你开了多个命令行，多个terminal会产生冲突，全部关掉，重开一个来部署。

### 本地未关联远程分支报错

报错信息：

```bash
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

git branch --set-upstream-to=origin/<branch> release
```

报错原因：

在建立新的本地分支后，未与GitHub分支关联，通常出现在首次添加新的电脑时报错。

解决方法：

他不是说的明明白白的嘛，你就按照他的提示加一行代码，关联上就完了！这里的`remote_branch`就是GitHub上的远程分支，`your branch`就是你的本地分支。

```bash
git branch --set-upstream-to=origin/remote_branch your_branch
```

### fetch first 报错

![image-20220315180411753](Hexo-synchronization/image-20220315180411753.png)

报错原因：

远程库版本与本地版本不一致导致的报错。

解决方法：

```bash
git pull --rebase origin your_branch
```

### Non-fast-forward 报错

![image-20220516171510709](Hexo-synchronization/image-20220516171510709.png)

报错原因：

别人上传到远程仓库后，你没有及时的同步或拉取到本地，但是你同时又添加了一些内容。当你在提交时，它会检测到你之前从远程仓库拉取的时候的仓库状态和现在的不一样。于是，它为了安全起见拒绝了你的提交。

解决方法（推荐）：先合并之前的历史，再进行提交

```bash
git fetch origin your_branch # 先抓取远程仓库的更新到本地
git merge origin your_branch # 然后与你的本地仓库合并
git pull --rebase origin your_branch # 然后就可以提交修改了

```

解决方法（不推荐）：丢弃之前的历史，强行提交

```bash
git push --force # 这种方法很不安全
```

---

注：本文部分内容参考自[Hexo博客的安装部署及多电脑同步](https://cloud.tencent.com/developer/article/1046404)，如有侵权，请联系我。
