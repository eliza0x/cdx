import cdx_color
import os
import sys
import subprocess

# input (code,path)
#   code : 3:automake
#        : 4:make
#   path : path
# output None
# exit status : 0 : correct
#               1 : cancel make direcory


HOME = os.environ["HOME"]

argv=sys.argv

if len(argv) == 2:
    changeTo=HOME
else:
    changeTo = argv[2]

make=False
automake=False

if argv[1] == 6:
    sys.exit()

if argv[1] == "4":
    make=True

if argv[1] == "3":
    make=True
    automake=True

if os.system("cd " + changeTo + " 2> /dev/null 1 > /dev/null") != 0:
    if make:
        if automake:
            os.mkdir(changeTo)
            print( cdx_color.cyan + \
                "Directory has made automatically by --automake option" + cdx_color.reset)
        else:
            print(cdx_color.cyan + changeTo +
                      " is not exists at current direcory. \n Do you want to make direcory?(y/n) " + cdx_color.reset)
            ans = input(">>> ")
            if ans == 'y':
                os.mkdir(changeTo)
            else:
                sys.exit(1)
