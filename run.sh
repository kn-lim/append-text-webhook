#!/bin/sh

# $1 = File Name
# $2 = File
# $3 = Text

echo "File Name: $1"
echo "File Contents: $2"
echo "Text: $3"

content=$(echo $2 | base64 --decode)
echo $content > output/$1
echo $3 >> output/$1
