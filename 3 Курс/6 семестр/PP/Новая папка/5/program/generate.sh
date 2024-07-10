#!/usr/bin/bash

#current dir
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cd $HOME/pvm3/bin/$PVM_ARCH

$SCRIPTPATH/generator