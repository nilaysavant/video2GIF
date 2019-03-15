#!/bin/bash

# Script to generate gif from video

input_file=$1
fps=24
xpath=${input_file%/*} # get full path
xbase=${input_file##*/} # get only base with extension
xfext=${xbase##*.} # get only extension
xpref=${xbase%.*} # get prefix (actual name only)

ffmpeg -y -i ${input_file} -vf fps=${fps},scale=-1:-1:flags=lanczos,palettegen palette.png

ffmpeg -i ${input_file} -i palette.png -filter_complex \
"fps=${fps},scale=-1:-1:flags=lanczos[x];[x][1:v]paletteuse" ${xpref}.gif
