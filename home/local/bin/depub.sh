#! /bin/bash

shopt -s globstar nullglob
for f in **/*.epub
do
    echo "processing: $f"
    pandoc "$f" -o "${f%.*}.md" --wrap=preserve;
    pandoc --from markdown --to plain "${f%.*}.md" -o "${f%.*}.txt";
    rm "${f%.*}.md";
done
