#!/bin/bash

EXECUTABLE="/tmp/$(echo $1 | cut -d. -f1)"
args=("$1")

clang++ $args -o $EXECUTABLE
$EXECUTABLE
