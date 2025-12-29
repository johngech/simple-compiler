#!/bin/bash

# Install script for Ubuntu

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root: sudo $0"
  exit 1
fi

make clean && make

cp minicpp /usr/local/bin/

echo "MiniCPP installed to /usr/local/bin/minicpp"