module C
const NAMES = [
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
]

#name2idx
for (idx,name) in enumerate(NAMES)
    eval(Meta.parse("const $name = $idx"))
end

const NUM = length(NAMES)

end  # module