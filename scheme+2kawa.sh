#!/bin/bash

# convert curly infix scheme to prefix scheme

# example: ./scheme+2kawa.sh test-kawa+.scm


if [ $# -eq 0 ]
  then
      echo "No arguments supplied"
      exit 1
fi


if [ -z ${SCHEME_PLUS_FOR_KAWA+x} ];
  then
    echo "SCHEME_PLUS_FOR_KAWA is unset,set it to the path to Scheme+ for Kawa";
    exit 1
  # else
  #   echo "SCHEME_PLUS_FOR_KAWA is set to '$SCHEME_PLUS_FOR_KAWA'";
fi

filename_with_ext=$1

extension="${filename_with_ext##*.}"

filename="${filename_with_ext%.*}"
output_filename="${filename%+*}"

# echo $filename
# echo $output_filename
# echo $extension

if [ "$filename" = "$output_filename" ]; then
    echo "Error: input and output files are equal"
    exit 1
fi


kawa $SCHEME_PLUS_FOR_KAWA/curly-infix2prefix4kawa.scm --srfi-105 $filename_with_ext  | tr -d '|'  > $output_filename.$extension





