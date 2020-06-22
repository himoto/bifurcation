module V
const NAMES = [
    "Subp"
    "CycBCdk1"
    "PP1"
    "pENSAt"
    "Gwlp"
    "PP2AB55"
    "Wee1"
    "Wee1pp"
    "Cdc25"
    "Cdc25pp"
]

#name2idx
for (idx,name) in enumerate(NAMES)
    eval(Meta.parse("const $name = $idx"))
end

const NUM = length(NAMES)

end  # module