#! /bin/bash

var=' shonak soni'
#var1="${var//[[:space:]]/}"
echo "${var::-1}"
echo $var
echo "${var}" | sed -e 's/^[[:space:]]*//'
#echo "${var}" | sed -e 's/^[[:space:]]*//'
