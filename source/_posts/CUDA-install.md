---
title: CUDA安装教程
date: 2022-09-17 18:33:48
author: Tony
categories:
  - Python
tags:
  - CUDA
  - Python
katex: true
---

# CUDA安装教程

CUDA仅针对NVIDIA显卡进行加速，对于AMD显卡及Inter集成显卡没有加速效果，此教程仅适用于拥有NVIDIA显卡电脑的朋友。

## CUDA下载

CUDA下载网址：https://developer.nvidia.com/cuda-toolkit-archive

选择电脑系统和版本型号，较旧的电脑需要根据电脑显卡版本选择较旧的CUDA Toolkit，一般电脑选择最新版即可。

![image-20220718135746089](CUDA-install/image-20220718135746089-1663410928185-1.png)

傻瓜式下一步：

<img src="CUDA-install/image-20220718135714318-1663410937840-3.png" alt="image-20220718135714318" style="zoom:67%;" />

<img src="CUDA-install/image-20220718135833425-1663410950886-5.png" alt="image-20220718135833425" style="zoom:67%;" />

使用命令`nvcc -V`验证是否安装成功：

<img src="CUDA-install/image-20220718135956517-1663410961962-7.png" alt="image-20220718135956517" style="zoom:67%;" />



## cuDNN下载

cuDNN下载网址：https://developer.nvidia.com/cudnn

选择电脑系统和版本型号，较旧的电脑需要根据电脑显卡版本选择较旧的CUDNN，一般电脑选择最新版即可。

<img src="CUDA-install/image-20220718160333419-1663410975368-9.png" alt="image-20220718160333419" style="zoom:80%;" />

下载后打开压缩包：



<img src="CUDA-install/image-20220718160419835-1663410988631-11.png" alt="image-20220718160419835" style="zoom:67%;" />

将下载好的cudnn文件复制到cuda的安装目录下面，默认路径为C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\vXX.X.





