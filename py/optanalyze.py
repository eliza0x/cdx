import sys

argv = sys.argv[1:]

for opt in argv:
    if opt == "-h":
        print("history")
    elif opt == "-b":
        print("bookmark")
    elif opt == "--ssh":
        print("ssh")
    elif opt == "--fuzzy":
        print("fuzzy")
    elif opt == "--make":
        print("make")
    elif opt == "--automake":
        print("automake")
    elif opt == "--ls":
        print("ls")
    elif opt == "--cd":
        print("cd")
    else:
        print(opt)
        break

