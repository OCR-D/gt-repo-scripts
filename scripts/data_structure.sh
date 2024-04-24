#!/bin/bash
metsfiles=`ls data/`
page=`find -name 'GT-PAGE'`
path=`pwd`
var_path1=$(basename "$PWD")


for eachfile in $page
do
jp=`pwd`
cd $path/$eachfile;cd ..
p=`pwd`




if test -f "mets.xml"; then
    # if grep -Eq "PAGE;IMG" mets.xml; then
    if grep -Eq "mets:fileGrp USE=\"OCR-D\-IMG" mets.xml; then
        cd $p
        pwd
        var_path2=$(basename "$PWD")
        ocrd zip bag -i ocrd_data_${var_path1}_${var_path2} -q OCR-D-IMG -q GT-PAGE
        mv $path/data/*.zip $path/ocrdzip_out/
    fi
fi
done
