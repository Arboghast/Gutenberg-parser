# Gutenberg-parser
A set of R scripts that Parses and Filters Project Gutenberg text files and converts them into a Hashmap.

Steps to replicate:

1: Download the data at: http://static.decontextualize.com/gutenberg-dammit-files-v002.zip 
or obtain .txt files from the website

2: Place .txt files in the same directory as R files

3: Rename and tweak filename code in both Break.R and Clean.R (TODO: automate this process)

4: Run Clean.R first, then Break.R

5: Resulting JSON file should have a simillar structure as this: https://github.com/Arboghast/Gutenberg-parser/blob/master/reformattedX.json
