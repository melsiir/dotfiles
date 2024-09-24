
function image3x -d "upscale image by 300%"
    convert $argv[1] -resize 300% $argv[1].3x-basic.png
end


# kinda fancy
# colorspace RGB +sigmoidal-contrast 7.5 \
#           -filter Lanczos -define filter:blur=.9891028367558475 \
#           -distort Resize 200% \
#           -sigmoidal-contrast 7.5 -colorspace sRGB
#
#
#
# # winnar
#       convert caapa-main-edit-a-only.png   -colorspace RGB +sigmoidal-contrast 7.5 \
#           -filter Lanczos -define filter:blur=.9264075766146068 \
#           -distort Resize 300% \
#           -sigmoidal-contrast 7.5 -colorspace sRGB caapa-main-edit-a-only.otherfancy.png
#
#
# filename="carloses color plot.png"
# convert "$filename" -resize 300% "$filename.3x-basic.png"
# convert "$filename" -colorspace RGB +sigmoidal-contrast 7.5 -filter Lanczos -define filter:blur=.9264075766146068 -distort Resize 300% -sigmoidal-contrast 7.5 -colorspace sRGB "$filename.3x-awesome.png"
