echo 'Converting all .png, .jpg, and .jpeg files to .webp...'
for f in $(find . -name '*.png' -or -name '*.jpg' -or -name '*.jpeg'); do
    if [ ! -f "${f%.*}.webp" ]; then
        cwebp -q 60 $f -o ${f%.*}.webp
    fi
done
