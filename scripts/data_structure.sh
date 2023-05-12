#!/bin/bash
metsfiles=`ls data/`
page=`find -name 'GT-PAGE'`
path=`pwd`


for eachfile in $page
do
jp=`pwd`
cd $path/$eachfile;cd ..
p=`pwd`

if test -f "amets.xml"; then
    # if grep -Eq "PAGE;IMG" mets.xml; then
    if grep -Eq "mets:fileGrp USE=\"OCR-D\-IMG" amets.xml; then
        pwd
        cd $p;ocrd zip bag -i ocrd_data_structur_${PWD##*/};cd ${PWD##*/};mv $path/data/*.zip $path/ocrdzip_out/
        # echo "gefunden!"
            else
                pwd
                rm amets.xml
                ocrd workspace --directory $p init
                cat $path/scripts/mets.sh # for GH actions log
                sh $path/scripts/mets.sh
                cd $p
                ocrd zip bag -i ocrd_data_structur_${PWD##*/}
                cd $p
                cd ..
                sudo mv *.zip $path/ocrdzip_out/
    fi
    

else
    ocrd workspace --directory $p init
    cat $path/scripts/mets.sh # for GH actions log
    sh $path/scripts/mets.sh
    cd $p
    ocrd zip bag -i ocrd_data_structur_${PWD##*/}
    cd $p
    cd ..
    sudo mv *.zip $path/ocrdzip_out/
    
fi
done