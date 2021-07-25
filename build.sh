#!/bin/bash
VERSION=0.2.0
NAME="Cursed Shaderpack"

# clean old files
if [ -f "$NAME $VERSION.zip" ]; then
    rm "./$NAME $VERSION.zip"
fi

if [ ! -f ".build" ]; then
	mkdir ./.build
fi

# copy build files
if [ ! -f "LICENSE" ]; then
	cp LICENSE .build
fi

if [ ! -f "README.md" ]; then
	cp README.md .build
fi

cp -r shaders .build

# zip shader
zip -r "$NAME $VERSION.zip" .build/*

# clean build dir
rm -rf .build

# put zip into build dir
mkdir .build
cp "$NAME $VERSION.zip" .build
rm "$NAME $VERSION.zip"
