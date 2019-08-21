# 针对第三方 KMS 激活服务器可用性的 定时监控 警报系统

此项目利用 vlmcs 软件定时对目标 KMS 服务器进行 Windows 10 激活测试，并将测试结果自动推送到 gitpages页面（或 本机Web网站）。

利用监控宝 实现宕机时 短信、邮件警报。

## ▚ 使用方式 一

对目标 KMS服务器 定时进行激活测试 并将测试结果自动推送到 git pages

准备：1.vps服务器一台 2.git仓库一个（用于推送 git pages 仅支持 master 必须包含 readme.md）

```

1.安装git 拉取pull 仓库到服务器

安装过程中 按提示输入 git 用户名 密码

格式：

bash <(curl -L -s git.io/x.sh) -gitpages 仓库名称 仓库地址

举例：

bash <(curl -L -s git.io/x.sh) -gitpages Monitor_KMS_Server_Pages https://github.com/dylanbai8/Monitor_KMS_Server_Pages.git

2.将以下代码添加到定时任务

格式：

bash <(curl -L -s git.io/x.sh) KMS服务器地址

举例：

bash <(curl -L -s git.io/x.sh) kms.v0v.bid

```


## ▚ 使用方式 二

对目标 KMS服务器 定时进行激活测试 并将测试结果自动推送到 本机的web网站

准备：1.vps服务器一台 2.本机web网站（用于推送 html pages）

```

将以下代码添加到定时任务

格式：

bash <(curl -L -s git.io/x.sh) KMS服务器地址 网站Web路径(文件夹)

举例：

bash <(curl -L -s git.io/x.sh) kms.v0v.bid /www/wwwroot/www.mydomain.com/Monitor_KMS_Server_Pages

```

## ▚ 使用方式 三

对目标 KMS服务器 定时进行激活测试 并将测试结果自动推送到 安装目录

准备：1.vps服务器一台

```

将以下代码添加到定时任务

bash <(curl -L -s git.io/x.sh) kms.v0v.bid

当未设置gitpages 且为添加Web路径参数 时，将自动将激活测试结果保存到安装目录，以备其它程序调用

```

## ▚ 设置 短信 邮件 警报

准备：注册 https://www.jiankongbao.com 或者其它类似监控系统

```

添加 gitpages页面地址（或者本机Web网站监控页地址）为 “监控项目”

点开 “更多高级设置” - “匹配内容” 中填写：successful

按提示开启 短信 邮件 警报提醒

```

## ▚ 卸载全部

删除根目录 删除gitpages仓库 卸载相关依赖软件

```

bash <(curl -L -s git.io/x.sh) uninstall

```

# 关联项目

https://v0v.bid


