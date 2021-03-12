#!/bin/bash
# Cicak bin Kadal
# Tue 13 Oct 2020 10:37:14 AM WIB

REC1="operatingsystems@vlsm.org"
REC2="cbk@dummy"
FILES="my*.asc my*.txt my*.sh"
SHA="SHA256SUM"

[ -d $HOME/RESULT ] || { echo "No $HOME/RESULT directory" ; exit; }
pushd $HOME/RESULT
for II in W?? ; do
    TARFILE=my$II.tar.bz2
    TARFASC=$TARFILE.asc
    rm -f $TARFILE $TARFASC
    echo "tar cfj $TARFILE $II/"
    tar cfj $TARFILE $II/
    echo "gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE"
    gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE
done
popd

echo "mv -f $HOME/RESULT/myW*.tar.bz2.asc ."
mv -f $HOME/RESULT/myW*.tar.bz2.asc .

echo "rm -f $SHA $SHA.asc"
rm -f $SHA $SHA.asc

echo "sha256sum $FILES > $SHA"
sha256sum $FILES > $SHA

echo "sha256sum -c $SHA"
sha256sum -c $SHA

echo "gpg -o $SHA.asc -a -sb $SHA"
gpg -o $SHA.asc -a -sb $SHA

echo "gpg --verify $SHA.asc $SHA"
gpg --verify $SHA.asc $SHA

exit 0

# Mon Sep 28 21:05:04 WIB 2020
# Tue 29 Sep 2020 11:02:39 AM WIB

