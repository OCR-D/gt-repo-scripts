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
    cat $path/scripts/mets.sh # for GH actions log
    sh $path/scripts/mets.sh
    cd $p
    ocrd zip bag -i ocrd_data_structur_${PWD##*/}
    cd $p
    cd ..
    pwd
    echo "Hallo"
    sudo mv *.zip $path/ocrdzip_out/
    
    # pwd;ls -l
    
    # mv $path/data/*.zip $path/ocrdzip_out/
    
    # mkdir $path/ghout/${PWD##*/};sudo mv mets.xml $path/ghout/${PWD##*/}/
fi
done


