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

# Set argument variables
fn_ipynb="$1"
fn_md="../content/en/docs/$2"
new=0

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
if [ -f "$fn_md" ]; then
    exists=1
else
	exists=0
	new=1
fi

# Create new temporary md file in local directory
jupyter nbconvert --to markdown $fn_ipynb --output "tmp1" > /dev/null

# If new file is wanted
if [ "$new" -eq 1 ]; then

	echo "Creating new markdown file at: $fn_md"
	
	# Create new empty header in new file
	echo '---' > 'tmp2.md'
	echo 'title:' >> 'tmp2.md'
	echo 'linkTitle:' >> 'tmp2.md'
	echo 'date:' >> 'tmp2.md'
	echo 'weight:' >> 'tmp2.md'
	echo 'description:' >> 'tmp2.md'
	echo '---' >> 'tmp2.md'
	
	# Concatenate two files into one (new markdown file)
	cat tmp2.md tmp1.md > tmp3.md
	mv tmp3.md "$fn_md"
	rm tmp1.md tmp2.md
	
else # If not a new file

	echo "Replacing body of markdown file at: $fn_md"

	# Get old header
	sed -n '/---/,/---/p' $fn_md > tmp2.md
	
	# Concatenate two files into one (new markdown file)
	cat tmp2.md tmp1.md > tmp3.md
	mv tmp3.md "$fn_md"
	rm tmp1.md tmp2.md
fi

	


