#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

curPath=`pwd`
rootPath=$(dirname "$curPath")
rootPath=$(dirname "$rootPath")
serverPath=$(dirname "$rootPath")
sourcePath=${serverPath}/source
sysName=`uname`
install_tmp=${rootPath}/tmp/mw_install.pl

SYS_VERSION_ID=`cat /etc/*-release | grep VERSION_ID | awk -F = '{print $2}' | awk -F "\"" '{print $2}'`

# 检查是否通
# zabbix_get -s 127.0.0.1 -k agent.ping
Install_App()
{
	yum install -y glibc-langpack-zh

	mkdir -p $serverPath/source/zabbix

	ZABBIX_NAME=zabbix-release-6.0-5.el${SYS_VERSION_ID}.noarch.rpm

	rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/${SYS_VERSION_ID}/x86_64/${ZABBIX_NAME}

	cd $serverPath/source/zabbix && rpm -Uvh ${ZABBIX_NAME}
	dnf install -y zabbix-server-mysql zabbix-web-mysql zabbix-sql-scripts zabbix-selinux-policy zabbix-agent

	# dnf module switch-to zabbix-web-1:7.0.4
}

Uninstall_App()
{
	dnf remove -y zabbix-server-mysql zabbix-web-mysql zabbix-sql-scripts zabbix-selinux-policy zabbix-agent
	rm -rf /etc/zabbix
	echo "卸载成功"
}

action=${1}
if [ "${1}" == 'install' ];then
	Install_App
else
	Uninstall_App
fi
