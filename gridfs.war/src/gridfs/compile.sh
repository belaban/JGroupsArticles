#!/bin/bash

ROOT=../..
LIB_DIR=$ROOT/WEB-INF/lib
CP=$ROOT/conf
for i in $LIB_DIR/*.jar
do
   CP=$CP:${i}
done

DEST_DIR=$ROOT/WEB-INF/classes
mkdir $DEST_DIR

javac -d $DEST_DIR -classpath $CP *.java