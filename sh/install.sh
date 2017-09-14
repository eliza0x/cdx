#!/bin/bash

# install cdx


shell=$SHELL

echo -e $(cat ./logobase64.txt|base64 -d)

if [ $shell = "/bin/bash" ]; then
  # bash

  echo "# cdx settings " >> ~/.bashrc
  echo "export CDX_DEFAULT_OPT=\"\"" >> ~/.bashrc
  echo -ne  "Please input intaractive filter command name\n>>> "
  read commandname
  echo "export CDX_FUZZY_COMMAND=\""$commandname"\"" >> ~/.bashrc
  echo "export CDX_DIR=\""$(pwd)"\"" >> ~/.bashrc
  echo ". "$(pwd)"/sh/func.sh" >> ~/.bashrc
  echo ". "$(pwd)"/sh/complete.sh" >> ~/.bashrc
elif [ $shell -eq "/usr/bin/fish" ]; then
  
  echo "You write the following settings to config.fish."
  echo "------------------------------------------------"
  echo ". /path/to/cdx/sh/func.fish"
  echo "set CDX_FUZZY_COMMAND command_name"
  echo "set CDX_DIR path/to/cdx"
  echo "set CDX_DEFAULT_OPT \"options\""
fi
