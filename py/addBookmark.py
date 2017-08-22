import os
import cdx_color
import sys
import pView

if __name__ == '__main__':
    argv=sys.argv[1]
    path=os.environ["HOME"]+"/.cdx.bookmark"

    with open(path,"a") as f:
        f.write("\n"+argv)

    print(cdx_color.magenta+"add Bookmark <<< "+pView.view(argv))
