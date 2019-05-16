const F_V = [
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
for (index,value) in enumerate(F_V)
    eval(Meta.parse("const $value=$index"));
end