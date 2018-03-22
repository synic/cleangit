#!/bin/sh

git submodule init
git submodule update

for d in demos/*; do
    if [ -d $d ]; then
        name=`basename "$d"`

        printf "Working on $name ... "
        cwd=`pwd`
        cd $d
        ./.prepare.sh > /dev/null 2>&1
        cd $cwd
        printf "done.\n"
    fi
done
