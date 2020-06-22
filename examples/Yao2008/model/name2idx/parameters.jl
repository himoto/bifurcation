module C
const NAMES = [
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
for (idx,name) in enumerate(NAMES)
    eval(Meta.parse("const $name = $idx"))
end

const NUM = length(NAMES)
end  # module