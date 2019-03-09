const F_V = [
    "M"
    "E"
    "CD"
    "CE"
    "R"
    "RP"
    "RE"
];

#name2idx
for (index,value) in enumerate(F_V)
    eval(Meta.parse("const $value=$index"));
end