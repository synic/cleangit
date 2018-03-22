#!/bin/sh

git submodule init
git submodule update

for d in demos/*; do
    if [ -d $d ]; then
        name=`basename "$d"`

        echo -n "Working on $name ... "
        cwd=`pwd`
        cd $d
        ./.prepare.sh > /dev/null 2>&1
        cd $cwd
        echo "done."
    fi
done
