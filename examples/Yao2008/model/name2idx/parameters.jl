module C
const param_names = [
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
]

#name2idx
for (idx,name) in enumerate(param_names)
    eval(Meta.parse("const $name = $idx"))
end

const len_f_params = length(param_names)
end  # module