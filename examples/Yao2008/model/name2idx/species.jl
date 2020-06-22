module V
const NAMES = [
    "M"
    "E"
    "CD"
    "CE"
    "R"
    "RP"
    "RE"
]

for (idx,name) in enumerate(NAMES)
    eval(Meta.parse("const $name = $idx"))
end

const NUM = length(NAMES)
end  # module