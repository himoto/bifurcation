#!/bin/sh

header="function diffeq(u::Vector)\n    du = similar(u)\n\n"
tail="    return du\nend"


printf "$header" > head.temp
printf "$tail" > tail.temp

# use sed to remove 999 lines following end and the first line concerning function
sed -E '/end/,$d' model/steady_state.jl | sed -e '/function/d' > file.temp

cat head.temp file.temp tail.temp > differential_equation.jl

rm file.temp
rm head.temp
rm tail.temp