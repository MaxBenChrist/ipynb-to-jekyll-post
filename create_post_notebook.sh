#!/bin/bash

file_nb="$1"
ipython nbconvert --to html $file_nb
#ipython nbconvert --template basic $file_nb

# get date and split it into day and time
DATE=`date +%Y-%m-%d/%H:%M:%S`
IFS="/" read d t <<< "$DATE"

blogtitle=${file_nb//.ipynb/}
blogtitle=${blogtitle//_/ }

file_html=${file_nb//.ipynb/.html}
output=$d"-$file_html"

# Add header to file 
header="---\nlayout: post\ntitle:  \"$blogtitle\"\nsubtitle: \ndate:   $d $t \ncategories: [notebook] \n--- \nThis is the notebook $file_nb"

echo -e $header > $output

#delete the input prompts and add to file
#awk '!/input_prompt/' $file_html >>  $output
cat $file_html >>  $output
rm $file_html

