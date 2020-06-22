module V
const NAMES = [
    "p27T"
    "CycEp27"
    "Cdh1dp"
    "EmiC"
    "Cdh1"
    "Skp2"
]

#name2idx
for (idx,name) in enumerate(NAMES)
    eval(Meta.parse("const $name = $idx"))
end

const NUM = length(NAMES)

end  # module