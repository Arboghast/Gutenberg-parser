# Gutenberg-parser
A set of R scripts that process and deconstruct Project Gutenberg plain utf-8 text files into a Hashmap of sentences.

Steps to replicate:

1: Obtain any utf-8 .txt book file from the website

2: Place .txt files in the same directory as R files

3: Rename and tweak filename code in both Break.R and Clean.R (TODO: automate this process)

4: Run Clean.R first, then Break.R

5: Resulting JSON file should have a simillar structure to this: https://github.com/Arboghast/Gutenberg-parser/blob/master/reformattedX.json

References:
http://static.decontextualize.com/gutenberg-dammit-files-v002.zip 
