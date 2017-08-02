#!/bin/bash

while true; do

    read state
    a=$(Connect4/Connect4/./main.swift $state)
    echo "$a"

done
