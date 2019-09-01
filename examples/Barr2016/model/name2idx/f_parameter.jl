module C
const F_P = [
    "kscyce"
    "kdcyce"
    "kdcycee"
    "kdcycea"
    "kasse"
    "kdise"
    "kscyca"
    "kdcyca"
    "kdcycac1"
    "kassa"
    "kdisa"
    "ks27"
    "kd27"
    "kd27e"
    "kd27a"
    "ksemi1"
    "kdemi1"
    "Cdh1T"
    "kacdh1"
    "kicdh1e"
    "kicdh1a"
    "kasec"
    "kdiec"
    "ksskp2"
    "kdskp2"
    "kdskp2c1"
    "Inhibitor"
    "CycElevel"
    "Emi1T"
];

#name2idx
for (index,value) in enumerate(F_P)
    eval(Meta.parse("const $value=$index"));
end

const len_f_params = length(F_P);

end  # module