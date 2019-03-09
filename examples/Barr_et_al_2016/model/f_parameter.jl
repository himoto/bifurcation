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

function f_params()
    p::Vector{Float64} = zeros(length(F_P));

    p[kscyce] = 0.003;
    p[kdcyce] = 0.001;
    p[kdcycee] = 0.0001;
    p[kdcycea] = 0.03;
    p[kasse] = 1;
    p[kdise] = 0.02;
    ## CYCA SYNTHESISp[DEGRADATION AND P27 BINDING/DISSOCIATION:
    p[kscyca] = 0.0025;
    p[kdcyca] = 0.002;
    p[kdcycac1] = 0.4;
    p[kassa] = 1;
    p[kdisa] = 0.02;
    ## P27 SYNTHESIS AND DEGRADATION:
    p[ks27] = 0.008;
    p[kd27] = 0.004;
    p[kd27e] = 2;
    p[kd27a] = 2;
    ## EMI1 SYNTHESIS AND DEGRADATION:
    p[ksemi1] = 0.003;
    p[kdemi1] = 0.001;
    ## CDH1 REGULATION:
    p[Cdh1T] = 1;
    p[kacdh1] = 0.02;
    p[kicdh1e] = 0.07;
    p[kicdh1a] = 0.2;
    p[kasec] = 2;
    p[kdiec] = 0.02;
    ## SKP2 SYNTHESIS AND DEGRADATION:
    p[ksskp2] = 0.004;
    p[kdskp2] = 0.002;
    p[kdskp2c1] = 0.2;
    ## CDK INHIBITOR
    p[Inhibitor] = 0.0;

    p[Emi1T] = 0.0;
    p[CycElevel] = 1.0;

    return p
end
