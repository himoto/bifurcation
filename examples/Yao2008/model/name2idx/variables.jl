module V
const var_names = [
    "M"
    "E"
    "CD"
    "CE"
    "R"
    "RP"
    "RE"
]

for (idx,name) in enumerate(var_names)
    eval(Meta.parse("const $name = $idx"))
end

const len_f_vars = length(var_names)
end  # module