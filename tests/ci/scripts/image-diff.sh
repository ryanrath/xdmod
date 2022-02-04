#!/bin/bash
function format
{
    for file in $(ls *.svg | grep -v "formatted"); 
    do
        dirname=$(dirname "$file")
        filename=$(basename "$file" .svg)
        newfile="$dirname/$filename.formatted.svg"
        if [[ ! -f "$newfile" ]]; then
            echo "Linting $file > $dirname/$filename.formatted.svg"
            xmllint --format "$file" > "$dirname/$filename.formatted.svg"
        else
            echo "$file already formatted"
        fi
    done

}

function diff
{
    for file in $(ls ~/scratch/images/*.svg | grep -v formatted | cut -d"-" -f 1 | uniq); do
        c7="$file-7-centos.formatted.svg"
        c8="$file-8-centos.formatted.svg"
        output_file="$file.diff"
        echo "Diffing $c7 && $c8"
        command diff "$c7" "$c8" > $output_file
        echo "Diff done!"
    done
    echo "Done!"
}

function convert 
{
    # for each file pair ( md5sum ), get the height / width via xmllint.
    # then use inkscape to convert the svg file to an appropriately sized png.
    for file in $(ls ~/scratch/images/*centos*.svg | grep -v formatted);
    do
        height=$(xmllint --xpath '/*[local-name()="svg"]/@height' "$file" | cut -d"=" -f 2 | tr -d '"')
        if [[ $? -ne 0 ]]; then 
            echo "Unable to get height from $file"
            break;
        fi
        width=$(xmllint --xpath '/*[local-name()="svg"]/@width' "$file" | cut -d"=" -f 2 | tr -d '"')
        if [[ $? -ne 0 ]]; then 
            echo "Unable to get height from $file"
            break;
        fi
        output_dir=$(dirname "$file")
        output_name=$(basename "$file" .svg)
        echo "File:        $file"
        echo "Height:      $height"
        echo "Width:       $width"
        echo "Output Dir:  $output_dir"
        echo "Output Name: $output_name"
        inkscape -w "$width" -h "$height" "$file" -e "$output_dir/$output_name.png"
        echo "***********************"
    done

}

function fix
{
    for file in $(ls ~/scratch/images/*centos*.svg | grep -v formatted); do
        type=$(file "$file" | cut -d":" -f 2 | cut -d" " -f 2)
        case "$type" in 
            "PNG")
                dir=$(dirname "$file")
                filename=$(basename "$file" .svg)
                echo "Moving $file to $dir/$filename.png"
                mv "$file" "$dir/$filename.png"
                ;;
        esac
    done
}

function compare
{
    for file in $(ls ~/scratch/images/*.svg | grep -v formatted | cut -d"-" -f 1 | uniq); do
       c7="$file-7-centos.png"
       c8="$file-8-centos.png" 
       output_file="$file-diff.png"
       echo "$c7"
       echo "$c8"
       echo "$output_file" 
       echo "*************"
       command compare -compose src $c7 $c8 $output_file
    done
#    for file in "${files[@]}"
#    do 
#       echo "Diffing $c7 to $c8"
#       compare -compose src "$c7" "$c8" "$output_file"
#       if [[ $? -ne 0 ]]; then
#           echo "unable to compare"
#           exit 1
#       fi
#    done
}

compare
