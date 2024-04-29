#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:/opt/homebrew/bin
export PATH

curPath=`pwd`
rootPath=$(dirname "$curPath")
rootPath=$(dirname "$rootPath")
rootPath=$(dirname "$rootPath")
serverPath=$(dirname "$rootPath")

install_tmp=${rootPath}/tmp/mw_install.pl
VERSION=7.0.9

MG_DIR=$serverPath/source/mongodb
mkdir -p $MG_DIR

if [ ! -f $MG_DIR/mongodb-macos-x86_64-${VERSION}.tgz ]; then
	wget --no-check-certificate -O $MG_DIR/mongodb-macos-x86_64-${VERSION}.tgz https://fastdl.mongodb.org/osx/mongodb-macos-x86_64-${VERSION}.tgz
	echo "wget --no-check-certificate -O $MG_DIR/mongodb-macos-x86_64-${VERSION}.tgz https://fastdl.mongodb.org/osx/mongodb-macos-x86_64-${VERSION}.tgz"
fi

if [ ! -d $MG_DIR/mongodb-macos-x86_64-${VERSION} ];then 
	cd $MG_DIR && tar -zxvf mongodb-macos-x86_64-${VERSION}.tgz
fi

if [ ! -d $serverPath/mongodb/bin ];then
	mkdir -p $serverPath/mongodb
	cd $MG_DIR/mongodb-macos-x86_64-${VERSION} && cp -rf ./bin $serverPath/mongodb
fi

TOOL_VERSION=2.2.5

if [ ! -f $MG_DIR/mongosh-${TOOL_VERSION}-darwin-arm64.zip ]; then
	wget --no-check-certificate -O $MG_DIR/mongosh-${TOOL_VERSION}-darwin-arm64.zip https://downloads.mongodb.com/compass/mongosh-${TOOL_VERSION}-darwin-arm64.zip
	echo "wget --no-check-certificate -O $MG_DIR/mongosh-${TOOL_VERSION}-darwin-arm64.zip https://downloads.mongodb.com/compass/mongosh-${TOOL_VERSION}-darwin-arm64.zip"
fi

