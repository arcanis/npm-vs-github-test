cat "$1" | while read x; do
    time wget -nv "$x" -O /dev/null
done
