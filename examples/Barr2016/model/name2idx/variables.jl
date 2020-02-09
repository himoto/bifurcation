module V
const var_names = [
    "p27T"
    "CycEp27"
    "Cdh1dp"
    "EmiC"
    "Cdh1"
    "Skp2"
]

#name2idx
for (idx,name) in enumerate(var_names)
    eval(Meta.parse("const $name = $idx"))
end

const len_f_vars = length(var_names)

end  # module