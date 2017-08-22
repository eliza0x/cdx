import sys
import os
import subprocess

argv = sys.argv[1:]

defaultOpt = os.environ.get("CDX_DEFAULT_OPTS", "")
HOME = os.environ["HOME"]

current = subprocess.check_output("pwd").decode('utf-8').replace('\n', '')

argv = defaultOpt.split(" ") + argv

rt = ""

# return :
# 0:exit
# 1:-p
# 2:--ssh
# 3:Unknown
# 4:--help
# else:option

for opt in argv:
    if opt == "+b":
        with open(HOME + '/.cdx.bookmark', 'a') as f:
            f.write(current + "\n")
        print(0)
        sys.exit()
    elif opt == "-p":
        print(1)
        sys.exit(1)
    elif opt == "--ssh":
        print(2)
        sys.exit()
    elif opt == "--help":
        # print help
        print(4)
        sys.exit()
    elif any(opt == x for x in ['-h', '-b', '--make', '--ssh', '--automake', '--fuzzy', '--ls', '--cd']):
        rt += opt+" "
    else:
        print(3)
        sys.exit()
print(rt)
