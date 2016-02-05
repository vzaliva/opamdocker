#! /bin/bash
APPL_NAME="opamdocker_hello"

SRCS_DIR="/home/opam"

BUILD_DIR="./build"
BUILD_ASSETS="$BUILD_DIR/assets"

rm -rf $BUILD_DIR
mkdir $BUILD_DIR
mkdir $BUILD_ASSETS

cp -rp src $BUILD_DIR
cp ./assets/profile $BUILD_ASSETS/.profile 
cp ./assets/ocamlinit $BUILD_ASSETS/.ocamlinit

#Prepare Docker file
sed -e "s|\$SRCS_DIR|$SRCS_DIR|g" ./assets/dockerfile.tpl > $BUILD_DIR/Dockerfile

docker build -t $APPL_NAME $BUILD_DIR
