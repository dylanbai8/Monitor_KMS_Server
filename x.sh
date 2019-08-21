#!/bin/bash

#====================================================
# KMS 激活服务器 定时监控 报警系统
# 项目地址：https://github.com/dylanbai8/Monitor_KMS_Server
#====================================================



#获取配置信息
kms_server="$1"
git_repository="$2"
git_path="$3"



#配置vlmcs和gitpages根目录名称
#:::::::::::::::::::::::::::::::::::::

vlmcs_path="Monitor_KMS"
git_pages_path="Monitor_PAGES"

vlmcs_message="successful"

git_pages_email="${git_repository}@microsoft.com"

#:::::::::::::::::::::::::::::::::::::



#更新系统安装必要软件
system_update(){

echo ""
echo "----------------------------------------------------------"
echo "正在 更新操作系统 安装必要软件（gcc git make）"
echo "----------------------------------------------------------"
echo ""

source /etc/os-release

case $ID in

debian|ubuntu)
    apt-get update -y
    apt-get install gcc git make -y
    ;;

centos|fedora|redhat)
    yum update -y
    yum install gcc git make -y
    ;;

*)
    clear
    echo "----------------------------------------------------------"
    echo ":: 错误！此脚本不支持您的操作系统 ::"
    echo "----------------------------------------------------------"
    echo ""
    exit
    ;;

esac

}



#储存配置信息
store_info(){

echo "----------------------------------------------------------"
echo "正在 储存配置信息"
echo "----------------------------------------------------------"
echo ""

touch /usr/local/${git_pages_path}/git_repository_txt
cat <<EOF > /usr/local/${git_pages_path}/git_repository_txt
${git_repository}
EOF

touch /usr/local/${git_pages_path}/git_path_txt
cat <<EOF > /usr/local/${git_pages_path}/git_path_txt
${git_path}
EOF

}



#读取配置信息
read_info(){

echo "----------------------------------------------------------"
echo "正在 读取配置信息"
echo "----------------------------------------------------------"
echo ""

get_git_repository="$(cat /usr/local/${git_pages_path}/git_repository_txt)"

get_git_path="$(cat /usr/local/${git_pages_path}/git_path_txt)"

}



make_pages(){

echo "----------------------------------------------------------"
echo "正在 生成 html 页面"
echo "----------------------------------------------------------"
echo ""

touch ${git_pages_file}

cat <<EOF > ${git_pages_file}
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="KMS服务器状态监控系统">
<meta name="description" content="KMS服务器状态监控系统">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all">

<title>KMS服务器状态监控系统</title>

<style>
* {font-family:"Microsoft Yahei";margin:0;font-weight:lighter;text-decoration:none;text-align:center;line-height:2.2em;}
html,body {height:100%;}
h1 {font-size:2em;line-height:1em;}
table {width:100%;height:100%;border:0;}
a {color:#00AEED;}
</style>

<link rel="shortcut icon" href="https://c.s-microsoft.com/favicon.ico">
<link rel="bookmark" href="https://c.s-microsoft.com/favicon.ico">

</head>
<body>

<table cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>

<h1>${monitor_message_1}</h1>
<br>
<h1>${monitor_message_2}</h1>
<br>
<p>
<a href="">${monitor_message_3}</a>
</p>

</td>
</tr>
</tbody>
</table>

</body>
</html>
EOF

}



#卸载全部
if [ "${kms_server}" == uninstall ]; then

echo ""
echo "----------------------------------------------------------"
echo "正在 卸载 gcc git make 软件"
echo "----------------------------------------------------------"
echo ""

source /etc/os-release

case $ID in

debian|ubuntu)
    apt-get purge gcc git make -y
    ;;

centos|fedora|redhat)
    yum erase gcc git make -y
    ;;

*)
    clear
    echo "----------------------------------------------------------"
    echo ":: 错误！此脚本不支持您的操作系统 ::"
    echo "----------------------------------------------------------"
    echo ""
    exit
    ;;

esac

echo "----------------------------------------------------------"
echo "正在 卸载 vlmcs 删除 gitpages仓库（如果存在）"
echo "----------------------------------------------------------"
echo ""

rm -rf /usr/local/${git_pages_path}
rm -rf /usr/local/${vlmcs_path}

echo "----------------------------------------------------------"
echo "操作已完成"
echo "----------------------------------------------------------"
echo ""

exit
fi



#安装gitpages
if [ "${kms_server}" == -gitpages ]; then

system_update

echo "----------------------------------------------------------"
echo "正在 安装gitpages"
echo "----------------------------------------------------------"
echo ""

rm -rf /usr/local/${git_pages_path}
mkdir /usr/local/${git_pages_path}

store_info

cd /usr/local/${git_pages_path}

git config --global user.email "${git_pages_email}"
git config --global core.autocrlf false
git config --global credential.helper store
git clone ${git_path}

cd ~

    if [[ -e /usr/local/${git_pages_path}/${git_repository}/README.md ]]; then

    clear
    echo "----------------------------------------------------------"
    echo ":: gitpages 安装成功 ::"
    echo "----------------------------------------------------------"
    echo ""

    else

    clear
    echo "----------------------------------------------------------"
    echo ":: gitpages 安装失败 请检查 git仓库名称、地址是否正确 ::"
    echo "----------------------------------------------------------"
    echo ""
    exit

    fi

echo "----------------------------------------------------------"
echo "正在 推送测试"
echo "----------------------------------------------------------"
echo ""

read_info
monitor_message_1="安装成功！"
monitor_message_2=""
monitor_message_3=""

git_pages_file="/usr/local/${git_pages_path}/${get_git_repository}/index.html"
make_pages

cd /usr/local/${git_pages_path}/${git_repository}

git add .
git commit -m "由KMS监控系统自动推送"

echo ""
echo "----------------------------------------------------------"
echo "开始 push 推送 gitpages 按照提示输入 git 用户名 和 密码"
echo "----------------------------------------------------------"
echo ""

git push origin master

cd ~

    if [[ -e /usr/local/${git_pages_path}/${git_repository}/index.html ]]; then

    clear
    echo "----------------------------------------------------------"
    echo ":: 推送测试通过 gitpages 安装成功 ::"
    echo ":: 请按照 教程 手动添加 定时任务 ::"
    echo "----------------------------------------------------------"
    echo ""

    else

    clear
    echo "----------------------------------------------------------"
    echo ":: 推送测试失败 gitpages 安装失败 请检查 git账户名称、密码是否正确 ::"
    echo "----------------------------------------------------------"
    echo ""
    exit

    fi

exit
fi



if [[ -e /usr/local/${vlmcs_path}/vlmcs ]]; then

echo ""
echo "----------------------------------------------------------"
echo ":: 检测到本机已安装 vlmcs 开始执行激活测试命令 ::"
echo "----------------------------------------------------------"
echo ""

else

echo ""
echo "----------------------------------------------------------"
echo ":: 首次执行命令 开始安装 vlmcs 到本机 ::"
echo "----------------------------------------------------------"
echo ""

rm -rf /usr/local/${vlmcs_path}
mkdir /usr/local/${vlmcs_path}

cd /usr/local/${vlmcs_path}
git clone https://github.com/Wind4/vlmcsd.git

cd vlmcsd
make

cd bin
mv vlmcs /usr/local/${vlmcs_path}

cd ~
rm -rf /usr/local/${vlmcs_path}/vlmcsd/

fi



#开始测试激活
echo ""
echo "----------------------------------------------------------"
echo ":: 正在 激活测试 ::"
echo "----------------------------------------------------------"
echo ""

rm -rf /usr/local/${vlmcs_path}/monitor_log_txt

monitor_cmd=`/usr/local/${vlmcs_path}/vlmcs -l 1 ${kms_server}`
echo "激活测试结果:"${monitor_cmd} >> /usr/local/${vlmcs_path}/monitor_log_txt

if cat /usr/local/${vlmcs_path}/monitor_log_txt | grep "${vlmcs_message}"; then

monitor_message_1="KMS服务器：${kms_server} &nbsp;&nbsp;&nbsp; 服务器状态：在线"
monitor_message_2="激活测试结果：Windows 10 Activated Successfully ！"
monitor_message_3="上次激活测试时间：$(date "+%Y-%m-%d %H:%M:%S")"

else

monitor_message_1="KMS服务器：${kms_server} &nbsp;&nbsp;&nbsp; 服务器状态：离线"
monitor_message_2="激活测试结果：Windows 10 Activation Failed ！"
monitor_message_3="上次激活测试时间：$(date "+%Y-%m-%d %H:%M:%S")"

echo ""
echo "----------------------------------------------------------"
echo ":: 操作已完成 ::"
echo "----------------------------------------------------------"
echo ""

fi



#推送到gitpages
read_info

if [[ -e /usr/local/${git_pages_path}/${get_git_repository}/README.md ]]; then

echo "----------------------------------------------------------"
echo ":: 正在 将测试结果推送到 gitpages ::"
echo "----------------------------------------------------------"
echo ""

git_pages_file="/usr/local/${git_pages_path}/${get_git_repository}/index.html"
make_pages

cd /usr/local/${git_pages_path}/${get_git_repository}

git add .
git commit -m "由KMS监控系统自动推送"
git push origin master

cd ~

echo ""
echo "----------------------------------------------------------"
echo ":: 操作已完成 ::"
echo ":: 推送路径：${git_path} ::"
echo "----------------------------------------------------------"
echo ""

elif [[ -n ${git_repository} ]]; then

echo "----------------------------------------------------------"
echo ":: 正在 将测试结果推送到 指定路径 ::"
echo "----------------------------------------------------------"
echo ""

git_pages_file="${git_repository}"
make_pages

echo "----------------------------------------------------------"
echo ":: 操作已完成 ::"
echo ":: 推送路径：${git_repository} ::"
echo "----------------------------------------------------------"
echo ""

else

echo "----------------------------------------------------------"
echo ":: 缺少参数 正在 将测试结果推送到默认文件 以备其它程序调用 ::"
echo "----------------------------------------------------------"
echo ""

touch /usr/local/${vlmcs_path}/monitor_message.txt

cat <<EOF > /usr/local/${vlmcs_path}/monitor_message.txt
${monitor_message_1}
${monitor_message_2}
${monitor_message_3}
EOF

echo "----------------------------------------------------------"
echo ":: 操作已完成 ::"
echo ":: 推送路径：/usr/local/${vlmcs_path}/monitor_message.txt ::"
echo "----------------------------------------------------------"
echo ""

fi

exit


