#!/bin/bash
# Bash script for converting a Jupyter Notebook to a markdown file suitable for the docsy site.
# This script should be run from insite the COAsT-site/jupyter_notebooks directory.
#
# Useage:
#
# 	./ipynb_to_docsy_md.sh <ipynb_file_name> <md_file_name>
#
# md_file_name should be provided relative to the content/en/docs/ directory.
#
# Other flags:
#
#	--new | Creates a brand new markdown file with new header. By default, if the markdown file
#		already exists, the old header file will be preserved (only the body will be replaced
#		by the Jupyter Notebook. If markdown file doesn't exist, --new will be used anyway.
#		If a new file is created, the header will be blank and will need populating. 
#
# Note: You will need to have jupyter nbconvert installed -- you already have it. But you should check.

cd ..
base_path="$(pwd)"

# Set argument variables
fn_ipynb="$1"
fn_md="$base_path/content/en/docs/$2"
new=0
shift
shift

while :; do
	case $1 in
		--new)
			new=1
			;;
	    --)
            shift
            break
            ;;
        *)
            break
	esac
	shift
done
	
# Check if output file exists
echo $fn_md
echo $new
if [ -f "$fn_md" ]; then
    exists=1
else
	exists=0
	new=1
fi

dn_out="$(dirname $fn_md)"
fn_md="$(basename $fn_md)"
fn_head="tmp_head.md"
fn_body="tmp_body.md"

echo $fn_md
echo $dn_out
echo $fn_head

cd $dn_out

# Handle headers
# If new file is wanted
echo $new
if [ "$new" -eq 1 ]; then

	echo "Creating new markdown file at: $fn_md"
	
	# Create new empty header in new file
	echo '---' > $fn_head
	echo 'title:' >> $fn_head
	echo 'linkTitle:' >> $fn_head
	echo 'date:' >> $fn_head
	echo 'weight:' >> $fn_head
	echo 'description:' >> $fn_head
	echo '---' >> $fn_head
	
else # If not a new file

	echo "Replacing body of markdown file at: $fn_md"

    # Get old header
	sed -n '/---/,/---/p' $fn_md > $fn_head
fi

# Create new temporary md file in output directory
ln -sf "$base_path/jupyter_notebooks/$fn_ipynb" .
echo "jupyter nbconvert --to markdown $fn_ipynb --output $fn_md"
jupyter nbconvert --to markdown $fn_ipynb --output $fn_md
mv $fn_md $fn_body

# Change image links in file
echo 'Replacing'
lines=$(grep -ne 'png](' $fn_body | grep -Eo '^[^:]+')
IFS=' ' read -r -a lines_array <<< "$lines"

for i in "${lines_array[@]}"
do
   : 
   old_line=$(sed "${i}q;d" $fn_body)
   fn_img="${old_line:7:${#old_line}-8}"
   new_line="{{ <imgproc $fn_img> }}{{ </imgproc> }}"
   sed "${i}"'s=.*='"'$new_line'"'= ' "$fn_body" >> tmp_body_mod
   mv tmp_body_mod $fn_body
done

# Concatenate two files into one (new markdown file)
cat $fn_head $fn_body > $fn_md

# Remove files
rm $fn_head $fn_body $fn_ipynb
