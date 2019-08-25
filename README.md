# 针对第三方 KMS 激活服务器可用性的 定时监控 警报系统

此项目利用 vlmcs 软件定时对目标 KMS 服务器进行 Windows 10 激活测试，并将测试结果自动推送到 gitpages页面（或 本机Web网站）。

利用监控宝 实现宕机时 短信、邮件警报。

## ▚ 使用方式 一

对目标 KMS服务器 定时进行激活测试 并将测试结果自动推送到 git pages

准备：1.vps服务器一台 2.git仓库一个（用于推送 git pages 仅支持 master 必须包含 readme.md）

```

1.执行以下命令 安装git 拉取pull gitpages仓库到服务器

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

注意：当已安装“使用方式 一”时，将优先推送gitpages。

## ▚ 使用方式 三

对目标 KMS服务器 定时进行激活测试 并将测试结果自动推送到 vlmcs安装目录

准备：1.vps服务器一台

```

将以下代码添加到定时任务

bash <(curl -L -s git.io/x.sh) kms.v0v.bid

当未设置gitpages 且未添加Web路径参数 时，将自动把激活测试结果保存到安装目录，以备其它程序调用。

```

## ▚ 设置 短信 邮件 警报

准备：注册 https://www.jiankongbao.com 或者其它类似监控系统

```

1.注册 https://www.jiankongbao.com 或者其它类似监控系统
2.创建监控任务-普通网站监控-监控网址：https://bid.v0v.bid
3.更多高级设置-包含匹配内容-匹配内容：Successfully
4.按照该网站提示配置并开启Email和手机短信提醒
当 kms.v0v.bid 宕机时，你将及时收到宕机提醒，服务恢复时收到恢复提醒。

```

## ▚ 卸载全部

删除vlmcs安装目录 删除gitpages仓库 卸载相关依赖软件

```

bash <(curl -L -s git.io/x.sh) uninstall

```

# 关联项目

https://v0v.bid


