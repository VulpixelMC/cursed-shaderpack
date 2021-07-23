#!/bin/bash
VERSION=0.1.1
NAME="Cursed Shaderpack"

if [ -f "$NAME $VERSION.zip" ]; then
    rm "./$NAME $VERSION.zip"
fi

if [ ! -f ".build" ]; then
	mkdir ./.build
fi

if [ ! -f "LICENSE" ]; then
	cp LICENSE .build
fi

if [ ! -f "README.md" ]; then
	cp README.md .build
fi

zip -r $NAME.zip .build/*
