import os
import cdx_color

Homepath = os.environ["HOME"]


def view(cdir):
    # パスの分割
    paths = cdir.split('/')

    if paths[len(paths) - 1] == "":
        paths.pop(len(paths) - 1)

    length = len(cdir)
    if length >= 40:
        text = "/".join(paths)[length - 20:length].split("/")
        last = text[len(text) - 1]
        text[len(text) - 1] = ""
        rt = cdx_color.cyan + Homepath + cdx_color.black + "/..." + \
            cdx_color.blue + "/".join(text) + cdx_color.yellow + last
    else:
        length = len(paths)
        last = paths[length - 1]
        paths[length - 1] = ""
        rt = cdx_color.cyan + "/".join(paths) + cdx_color.yellow + last
    return rt


def cdx_echo(d1, d2):
    prefix = cdx_color.reset + " -->  " + cdx_color.magenta + \
        "cdx  " + cdx_color.reset + ": "
    sepa = cdx_color.reset + " ->>> "
    print(prefix + view(d1) + sepa + view(d2) + cdx_color.reset)
