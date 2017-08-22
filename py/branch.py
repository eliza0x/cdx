import os
import sys

argv = os.getenv("CDX_DEFAULT_OPTS", "").split(" ") + sys.argv[1:]

path=sys.argv[len(sys.argv)-1].split("/")
last=path[len(path)-1]


if any(opt in argv for opt in ['-h',]):
    print(0)
elif any(opt in argv for opt in ['-b',]):
    print(1)
elif last == '--':
    print(2)
elif any(opt in argv for opt in ['--automake',]):
    print(3)
elif any(opt in argv for opt in ['--make',]):
    print(4)
else:
    print(5)
