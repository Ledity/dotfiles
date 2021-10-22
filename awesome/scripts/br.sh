#!/bin/sh
brightnessctl i | awk -F '[()% ]' '$0 ~ "Current" {print $5}'
