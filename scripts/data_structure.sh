#!/bin/bash
metsfiles=`ls data/`
page=`find -name 'GT-PAGE'`
path=`pwd`


for eachfile in $page
do
cd $path/$eachfile;cd ..
p=`pwd`

if test -f "mets.xml"; then
    cd $p;ocrd zip bag -i ocrd_data_structur_${PWD##*/};cd ${PWD##*/};mv $path/data/*.zip $path/ocrdzip_out/
    

else
    ocrd workspace --directory $p init
    echo "hallo1"
    pwd
    cd ..
    ls
    echo "hallo2"
    cd ..
    ls
    echo "hallo"
    cat $path/scripts/mets.sh # for GH actions log
    sh $path/scripts/mets.sh
    cd $p
    ocrd zip bag -i ocrd_data_structur_${PWD##*/}
    cd $p
    cd ..
    sudo mv *.zip $path/ocrdzip_out/
    
fi
done


