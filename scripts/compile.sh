#!/bin/bash

for v in $(find . -name "*.md" | sort -V); do
	echo "" >>temp
	cat "$v" >>temp
done

pandoc -f markdown -t pdf temp -o notes.pdf
rm temp
