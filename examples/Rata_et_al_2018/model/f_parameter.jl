const F_P = [
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
for (index,value) in enumerate(F_P)
    eval(Meta.parse("const $value=$index"));
end

function f_params()
    p::Vector{Float64} = zeros(length(F_P));

    p[InhCDK] = 2.0;
    p[CycBCdk1T] = 8.1808;
    p[CycACdk2T] = 1.0000;
    p[PP1T] = 1.0000;
    p[kapp1] = 0.0115
    p[kapp1a] = 0.7054;
    p[kipp1] = 0.0018;
    p[kipp1C] = 0.7549;
    p[kPP1Gw] = 18.4724
    p[ENSAtot] = 1.0000;
    p[B55tot] = 0.2500;
    p[SubT] = 1.0000;
    p[kass] = 617.2807;
    p[kdis] = 0.0088;
    p[kcatB55] = 1.0338;
    p[kGwENSA] = 20.8811;
    p[kppxGwl] = 0.1560;
    p[kcBc1Sub] = 0.0080;
    p[kcBc1G] = 0.2393;
    p[Gwtot] = 1.0000;
    p[kB55G] = 496.5636;
    p[kB55Sub] = 0.0593;
    p[kcAc2G] = 0.1916;
    p[k25S] = 0.0050;
    p[k25F] = 0.9411;
    p[kweeS] = 0.0050;
    p[kweeF] = 47.2937;
    p[kcBc1W1] = 1.3132;
    p[kcBc125] = 1.3132;
    p[kppxY15] = 0.0050;
    p[kcAc2W1] = 0.1096
    p[kcAc225] = 0.1096;
    p[kB55W1] = 0.5511;
    p[kB5525] = 0.5511;
    p[Kd] = 0.025;

    return p
end
