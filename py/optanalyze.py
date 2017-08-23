import sys
import os
import subprocess
import re

import cdx_color

argv = sys.argv[1:]

shell = os.environ["SHELL"]
#shell = "/usr/bin/fish"

defaultOpt = os.environ.get("CDX_DEFAULT_OPTS", "")
HOME = os.environ["HOME"]

cdx_dir=os.environ["CDX_DIR"]

current = subprocess.check_output("pwd").decode('utf-8').replace('\n', '')+"/"

argv = defaultOpt.split(" ") + argv

rt = ""


def export(name, value):
    if shell == "/bin/bash":
        return name + "='" + value + "';"
    elif shell == "/usr/bin/fish":
        return "set " + name + " \"" + value + "\";"

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
popd=False
cdcommand="pushd"

for opt in argv:
    if opt == '--ssh':
        ssh = True
    elif opt == '--help':
        print(export("cdcommand","help")+"cat "+cdx_dir+"/help.txt")
        sys.exit()
    elif opt == '-p':
        popd=True
    elif opt == '--ls':
        ls=True
    elif opt == '--make':
        pass
    elif opt == '--automake':
        pass
    elif opt=='--cd':
        cdcommand="cd"
    else:
        changeTo=opt


if ssh:
    if os.path.exists(HOME + "/.ssh/config"):
        check = subprocess.check_output(
            "cat " + HOME + "/.ssh/config|grep ^Host|awk '{print $2}'|grep " + changeTo, shell=True)
        if check != "":
            print("ssh " + changeTo)
            sys.exit()
if popd:
    changeTo=""
    cdcommand="popd"
#command="cdcommand="+cdcommand+";"+command+"changeTo="+changeTo+";"
command=export("cdcommand",cdcommand)+command+export("changeTo",changeTo)


if ls:
    command=export("autols","1")+command

print(command)
