import subprocess
import sys
import cdx_color

argv = sys.argv


if(len(argv) == 1):
    list = subprocess.check_output(
        "ls -l|grep '^d'|awk '{print $9}'", shell=True).decode('utf-8').split('\n')
else:
    list = []
    with open(argv[1], 'r') as f:
        read = f.readlines()

    for line in read:
        list.append(line.replace('\n', ""))

if len(list) == 0:
    sys.exit

idx = 1
for l in list:
    print(cdx_color.yellow + "[" + str(idx) + "] " + cdx_color.reset + l)
    idx = idx + 1
