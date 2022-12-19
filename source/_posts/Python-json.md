---
title: Python处理json文件
date: 2022-07-21 22:00:11
author: Tony
tags: 
  - json
  - Python
categories: 
  - Python
katex: true
---



# 使用python处理json文件

本文简单介绍如何通过python正则表达式的方式和通过调用json package读取json数据，以及将python中的数组转化成json并导出到外部文档。

## 1.1 什么是json

JSON或JavaScript Object Notation，是一种**使用文本存储数据对象的格式。**换句话说，它是一种**数据结构，将对象用文本形式表示出来。**尽管它来源自JavaScript，但它已成为传输对象的实际标准。

大多数编程语言都支持JSON格式，本文将采用python读取数据。JSON格式的文件经常用于**API传输数据对象。**以下是JSON字符串的示例：

```json
{
	"name": "Tony",
	"ID": "455190",
	"language": "en",
	"course":
	[
		"Math",
		"Chinese",
		"Physics",
		"Computer Science"
	],
	"Graduated": "False"
}
```

这里需要注意的是，`{}`里的值称之为**key**, `[]`里的值称之为**array**.

## 正则表达式读取json文件

这里使用的是正则表达式来查找所要搜索的内容，此方法不具有通用性，需要根据具体的json文件的格式手动更改正则表达式的内容。

```python
'''
{
	"DATA1": [
	{"name": "Tony", "age": "19", "ID": "344909"},
	{"name": "Tina", "age": "22", "ID": "311921"},
	{"name": "Jack", "age": "23", "ID": "340223"},
	{"name": "Tian", "age": "20", "ID": "122008"}
	]
}
'''
import re # 正则表达式
# 读入文件
with open('test.json', 'r', encoding="utf-8") as f:
    data = f.read() # 读取json文件
    
age = [] # 存放字符串 "age": "XX"
ans = [] # 存放年龄数字 19 20 22

m = re.findall(r"\"age\": \"\d+\"", data) # "age": "XX"
if m:
    for i in m:
        age.append(i)
for i in age:
    temp = re.findall(r"\d+", i) # 搜索 "age": "XX" 中的XX
    ans.append(int(temp[0])) # str转换为int
    # temp = i.replace("age\": \"", "")
    # temp = temp.replace("\",", "")
    # age.append(temp)
# 读出文件
f = open('ans.txt', 'w', encoding="utf-8")
for i in ans:
    print(i, file=f)
f.close()
```

对于数字等区分度较大类型的格式，正则表达式相对容易些，但是如果要处理如姓名的json文件，正则表达式将会极其复杂；而且若是要处理较多种类的数据，我们需要对每一种数据类型都编写特定的正则表达式，其工作量将会极为庞大。

当然，这种相对传统的方法也有自己的优点，比如在非json文件格式下批量处理数据，我们就只能依靠这种”麻烦“的方法了，因此正则表达式的方法也需要我们熟练掌握。

## Python中的JSON处理json文件

当我们使用python中的json packages来处理json文件时，首先要保证json文件的格式是标准的，如果文件并非标准格式（比如少了一个后括号之类），python将会报错，文件无法正常读入。

```python
'''
{
	"DATA1": [
	{"name": "Tony", "age": "19", "ID": "344909"},
	{"name": "Tina", "age": "22", "ID": "311921"},
	{"name": "Jack", "age": "23", "ID": "340223"},
	{"name": "Tian", "age": "20", "ID": "122008"}
	],
	"DATA2": "data2",
	"DATA3": "data3"
}
'''
import json
import jsonpath
# input
with open('test.json', 'r', encoding='utf-8') as f:
    file = json.load(f)
    # print(type(file)) <class 'dict'>
    f.close()

file.keys() # dict_keys['DATA1', 'DATA2', 'DATA3']
data['DATA2'] # "data2"

name = jsonpath.jsonpath(file, '$..name')
age = jsonpath.jsonpath(file, '$..age')
print(name) # ["Tony", "Tina", "Jack", "Tian"]
print(age) # [19, 22, 23, 20]
# output
f = open('ans.txt', 'w', encoding="utf-8")
for i in range(0, len(name)):
    print(name[i] + ": " + age[i], file=f)
f.close()
```

以上示例中，`json.load()`函数自动将文档转化为`dict`格式读取到python中，我们可以通过`key()`函数访问其字典键值，通过`jsonpath.jsonpath()`函数获取数组中对应关键字的值（需要导入jsonpath）。此方法可以高效的处理json文件，但是需要注意的是原始文件的格式必须为json文件。

## 将python数据转换为json文件

我们使用`dump()`函数可以将python数据写成json格式，详情见样例：

```python
import json
languages = ("English", "Chinese")
country = 
{
    "name": "Tony",
    "age": 34,
    "languages": languages,
    "Male": False,
}

with open('countries_exported.json', 'w') as f:
json.dump(country, f, indent=4) # indent 缩进
```

其导出的json文件格式如下：

```json
{
    "name": "Tony",
    "age": 34,
    "languages": [
        "English",
        "Chinese"
    ],
    "Male": false
}
```

