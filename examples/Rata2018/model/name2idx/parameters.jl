module C
const param_names = [
    "InhCDK"
    "CycBCdk1T"
    "CycACdk2T"
    "PP1T"
    "kapp1"
    "kapp1a"
    "kipp1"
    "kipp1C"
    "kPP1Gw"
    "ENSAtot"
    "B55tot"
    "SubT"
    "kass"
    "kdis"
    "kcatB55"
    "kGwENSA"
    "kppxGwl"
    "kcBc1Sub"
    "kcBc1G"
    "Gwtot"
    "kB55G"
    "kB55Sub"
    "kcAc2G"
    "k25S"
    "k25F"
    "kweeS"
    "kweeF"
    "kcBc1W1"
    "kcBc125"
    "kppxY15"
    "kcAc2W1"
    "kcAc225"
    "kB55W1"
    "kB5525"
    "Kd"
];

#name2idx
for (idx,name) in enumerate(param_names)
    eval(Meta.parse("const $name = $idx"));
end

const len_f_params = length(param_names);

end  # module