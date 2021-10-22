#!/bin/sh
uname -a | awk '{print $3" | "$1}'
