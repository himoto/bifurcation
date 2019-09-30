module V
const var_names = [
    "Subp"
    "CycBCdk1"
    "PP1"
    "pENSAt"
    "Gwlp"
    "PP2AB55"
    "Wee1"
    "Wee1pp"
    "Cdc25"
    "Cdc25pp"
];

#name2idx
for (idx,name) in enumerate(var_names)
    eval(Meta.parse("const $name = $idx"));
end

const len_f_vars = length(var_names);

end  # module