# coding:utf-8

import sys
import io
import os
import time
import re
import json
import shutil

reload(sys)
sys.setdefaultencoding('utf8')

sys.path.append(os.getcwd() + "/class/core")
sys.path.append("/usr/local/lib/python2.7/site-packages")

import public

app_debug = False
if public.isAppleSystem():
    app_debug = True


def getPluginName():
    return 'php_guard'


def getPluginDir():
    return public.getPluginDir() + '/' + getPluginName()


def getServerDir():
    return public.getServerDir() + '/' + getPluginName()


def getInitDFile(version):
    if app_debug:
        return '/tmp/' + getPluginName()
    return '/etc/init.d/' + getPluginName()+version


def getArgs():
    args = sys.argv[3:]
    tmp = {}
    args_len = len(args)

    if args_len == 1:
        t = args[0].strip('{').strip('}')
        t = t.split(':')
        tmp[t[0]] = t[1]
    elif args_len > 1:
        for i in range(len(args)):
            t = args[i].split(':')
            tmp[t[0]] = t[1]

    return tmp


def checkArgs(data, ck=[]):
    for i in range(len(ck)):
        if not ck[i] in data:
            return (False, public.returnJson(False, '参数:(' + ck[i] + ')没有!'))
    return (True, public.returnJson(True, 'ok'))


if __name__ == "__main__":
    func = sys.argv[1]
    if func == 'status':
        print 'start'
    else:
        print "fail"
