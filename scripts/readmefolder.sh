#!/bin/bash

DIR=./readme
if [ -d "$DIR" ];
then
    echo "$DIR and readme.old are exists..."
else
	mkdir readme
    mv README.md readme/README.old
    git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
    git config --local user.name "github-actions[bot]"
    git add ./readme/*
    git commit -m "[Automatic] Update readme.old files" || echo "Nothing to update"
    touch README.xml

fi