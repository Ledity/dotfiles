#!/bin/sh
if [[ $(pulsemixer --list-sinks | grep "Default" | awk -F '[,:]' '{print $7}' | awk '{print $1}') -eq 0 ]]
then
    if [[ $(pulsemixer --list-sinks | grep "Default" | awk -F '[,:]' '{print $11}' | awk -F "['%]" '{print $2}') -ge 75 ]]
    then
        echo ''
    else
        if [[ $(pulsemixer --list-sinks | grep "Default" | awk -F '[,:]' '{print $11}' | awk -F "['%]" '{print $2}') -ge 25 ]]
        then
            echo ''
        else
            echo ''
        fi
    fi
else
    echo ''
fi
