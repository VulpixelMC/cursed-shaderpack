#!/bin/bash
VERSION=0.2.1
NAME="Cursed Shaderpack"
FILE="$NAME $VERSION.zip"

# clean old files
if [ -f "./.build/$FILE" ]; then
	rm "./.build/$FILE"
fi

if [ ! -f ".build" ]; then
	mkdir .build
fi

# copy build files
if [ ! -f "LICENSE" ]; then
	cp LICENSE .build
fi

if [ ! -f "README.md" ]; then
	cp README.md .build
fi

# copy shaders
cp -r ./shaders .build

# zip shader
cd ./.build; zip -r "../$FILE" ./*; cd ..

# clean build dir
rm -rf .build

# put zip into build dir
mkdir .build
cp "$FILE" .build
rm "$FILE"
