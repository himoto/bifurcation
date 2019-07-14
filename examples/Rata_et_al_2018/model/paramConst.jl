function f_params()::Vector{Float64}
    p::Vector{Float64} = zeros(C.len_f_params);

    p[C.InhCDK] = 2.0;
    p[C.CycBCdk1T] = 8.1808;
    p[C.CycACdk2T] = 1.0000;
    p[C.PP1T] = 1.0000;
    p[C.kapp1] = 0.0115
    p[C.kapp1a] = 0.7054;
    p[C.kipp1] = 0.0018;
    p[C.kipp1C] = 0.7549;
    p[C.kPP1Gw] = 18.4724
    p[C.ENSAtot] = 1.0000;
    p[C.B55tot] = 0.2500;
    p[C.SubT] = 1.0000;
    p[C.kass] = 617.2807;
    p[C.kdis] = 0.0088;
    p[C.kcatB55] = 1.0338;
    p[C.kGwENSA] = 20.8811;
    p[C.kppxGwl] = 0.1560;
    p[C.kcBc1Sub] = 0.0080;
    p[C.kcBc1G] = 0.2393;
    p[C.Gwtot] = 1.0000;
    p[C.kB55G] = 496.5636;
    p[C.kB55Sub] = 0.0593;
    p[C.kcAc2G] = 0.1916;
    p[C.k25S] = 0.0050;
    p[C.k25F] = 0.9411;
    p[C.kweeS] = 0.0050;
    p[C.kweeF] = 47.2937;
    p[C.kcBc1W1] = 1.3132;
    p[C.kcBc125] = 1.3132;
    p[C.kppxY15] = 0.0050;
    p[C.kcAc2W1] = 0.1096
    p[C.kcAc225] = 0.1096;
    p[C.kB55W1] = 0.5511;
    p[C.kB5525] = 0.5511;
    p[C.Kd] = 0.025;

    return p
end
