module V
const F_V = [
    "p27T"
    "CycEp27"
    "Cdh1dp"
    "EmiC"
    "Cdh1"
    "Skp2"
];

#name2idx
for (index,value) in enumerate(F_V)
    eval(Meta.parse("const $value=$index"));
end

const len_f_vars = length(F_V);

end  # module