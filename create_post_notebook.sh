#!/bin/bash

file_nb="$1"
ipython nbconvert --template basic $file_nb

# get date and split it into day and time
DATE=`date +%Y-%m-%d/%H:%M:%S`
IFS="/" read d t <<< "$DATE"

blogtitle=${file_nb//.ipynb/}
blogtitle=${blogtitle//_/ }

file_html=${file_nb//.ipynb/.html}
output=$d"-"${file_html//.html/.md}
echo $output
# Add header to file 
header="---\nlayout: post\ntitle:  \"$blogtitle\"\nsubtitle: \ndate:   $d $t \ncategories: [notebook] \n--- \nThis is the notebook $file_nb"

echo -e $header > $output
python strip_promt_nodes.py $file_html 

#delete the input prompts and add to file
cat $file_html >>  $output
rm $file_html

