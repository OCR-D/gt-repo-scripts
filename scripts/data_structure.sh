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
    if grep -Eq "mets:fileGrp USE=\"OCR-D\-IMG" mets.xml; then
        cd $p
        pwd
        ocrd zip bag -i ocrd_data_structur_${PWD##*/}
        mv $path/data/*.zip $path/ocrdzip_out/
        
    
    fi
fi
done
