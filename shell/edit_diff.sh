#!/bin/sh

header="function diffeq(u::Vector)\n    du = similar(u)\n\n"
tail="    return du\nend"


printf "$header" > head.temp
printf "$tail" > tail.temp

# use sed to remove 999 lines following end and the first line concerning function
sed -E '/end/,$d' $1 | sed -e '/function/d' > file.temp

cat head.temp file.temp tail.temp > testfile.jl

rm file.temp
rm head.temp
rm tail.temp

echo "done editing differential equation file"
