import sys
import os
import subprocess
import re

import cdx_color

argv = sys.argv[1:]

shell = os.environ["SHELL"]

defaultOpt = os.environ.get("CDX_DEFAULT_OPTS", "")
HOME = os.environ["HOME"]

current = subprocess.check_output("pwd").decode('utf-8').replace('\n', '')+"/"

argv = defaultOpt.split(" ") + argv

rt = ""


def export(name, value):
    if shell == "/bin/bash":
        return name + "='" + value + "';"
    elif shell == "/usr/bin/fish":
        return "set " + name + " " + value

# return :
# 0:exit
# 1:-p
# 2:--ssh
# 3:Unknown
# 4:--help
# else:option


command = ""

ssh = False
make = False
ls=False
automake=False
changeTo = current

cdcommand="pushd"

for opt in argv:
    if opt == '--ssh':
        ssh = True
    elif opt == '-p':
        command += "popd;"
    elif opt == '--ls':
        ls=True
    elif opt == '--make':
        make=True
    elif opt == '--automake':
        make=True
        automake=True
    elif opt=='--cd':
        cdcommand="cd"
    else:
        changeTo=opt


if ssh:
    if os.path.exists(HOME + "/.ssh/config"):
        check = subprocess.check_output(
            "cat " + HOME + "/.ssh/config|grep ^Host|awk '{print $2}'|grep " + changeTo, shell=True)
        if check != "":
            command = "ssh " + changeTo
            sys.exit()

#if os.system("cd "+changeTo+" 2> /dev/null 1 > /dev/null") != 0:
#    if make:
#        if automake:
#            os.mkdir(current+changeTo)
#            command+="echo -e \""+cdx_color.cyan+"Directory has made automatically by --automake option"+cdx_color.reset+"\";"
#            command+=cdcommand+" "+changeTo+" > /dev/null;"
#        else:
#            os.system("echo \""+cdx_color.cyan+changeTo+" is not exists at current direcory. \n Do you want to make direcory?(y/n) "+cdx_color.reset+"\"")
#            ans=input(">>>" )
#            if ans=='y':
#                os.mkdir(current+changeTo)
#                command+=cdcommand+" "+changeTo+" > /dev/null"
#            else:
#                command=""


if ls:
    command+="ls;"

print(command)
