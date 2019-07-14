module V
const F_V = [
    "M"
    "E"
    "CD"
    "CE"
    "R"
    "RP"
    "RE"
];

for (index,value) in enumerate(F_V)
    eval(Meta.parse("const $value=$index"));
end

const len_f_vars = length(F_V);
end  # module