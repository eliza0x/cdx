import subprocess
import sys
import cdx_color
import os
argv = sys.argv


if(not(os.path.exists(argv[1]))):
    path=argv[1].split("/")
    path.pop(len(path)-1)
    path="/".join(path)
    list = subprocess.check_output(
        "ls -l "+path+"|grep '^d'|awk '{print "+"\""+path+"/\""+"$9}'", shell=True).decode('utf-8').split('\n')

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
    if l == "":
        continue
    print(cdx_color.yellow + "[" + str(idx) + "] " + cdx_color.reset + l)
    idx = idx + 1
