#!/bin/sh

# $1 = File Name
# $2 = Text

echo "File Name: $1"
echo "Text: $2"

echo $2 > output/$1
