#!/bin/sh
if [[ $(pulsemixer --list-sinks | grep "Default" | awk -F '[,:]' '{print $7}' | awk '{print $1}') -eq 0 ]]
then
    echo ''
else
    echo ''
fi
