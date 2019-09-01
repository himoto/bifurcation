module C
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

const len_f_params = length(F_P);
end  # module