#!/bin/bash
metsfiles=`ls data/`
page=`find -name 'GT-PAGE'`
path=`pwd`


for eachfile in $page
do
jp=`pwd`
cd $path/$eachfile;cd ..
p=`pwd`



if test -f "mets.xml"; then
    # if grep -Eq "PAGE;IMG" mets.xml; then
    if (( ! $(grep -Eq "mets:fileGrp USE=\"OCR-D\-IMG" mets.xml))); then
        rm mets.xml
    fi   
fi
done