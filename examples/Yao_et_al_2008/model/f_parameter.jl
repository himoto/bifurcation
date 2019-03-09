const F_P = [
    "S"
    "kE"
    "kM"
    "kCD"
    "kCDS"
    "kR"
    "kRE"
    "kb"
    "KS"
    "kCE"
    "dM"
    "dE"
    "dCD"
    "dCE"
    "dR"
    "dRP"
    "dRE"
    "kP1"
    "kP2"
    "kDP"
    "KM"
    "KE"
    "KCD"
    "KCE"
    "KRP"
];

#name2idx
for (index,value) in enumerate(F_P)
    eval(Meta.parse("const $value=$index"));
end

function f_params()
    p::Vector{Float64} = zeros(length(F_P));

    p[S] = 2.0;
    p[kE] = 0.4;
    p[kM] = 1.0;
    p[kCD] = 0.03;
    p[kCDS] = 0.45;
    p[kR] = 0.18;
    p[kRE] = 180;
    p[kb] = 0.003;
    p[KS] = 0.5;
    p[kCE] = 0.35;
    p[dM] = 0.7;
    p[dE] = 0.25;
    p[dCD] = 1.5;
    p[dCE] = 1.5;
    p[dR] = 0.06;
    p[dRP] = 0.06;
    p[dRE] = 0.03;
    p[kP1] = 18.0;
    p[kP2] = 18.0;
    p[kDP] = 3.6;
    p[KM] = 0.15;
    p[KE] = 0.15;
    p[KCD] = 0.92;
    p[KCE] = 0.92;
    p[KRP] = 0.01;

    return p
end
