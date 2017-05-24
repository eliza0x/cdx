#!/bin/bash

istdir=$(dirname `pwd`)

echo ". $istdir/cdx/funcs.sh " >> ~/.bashrc
touch ~/.cdx_history
touch ~/.cdx.bookmark
chmod +x $istdir/cdx/*
