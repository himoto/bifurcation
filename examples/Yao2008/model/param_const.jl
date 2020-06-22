function param_values()::Vector{Float64}
    p::Vector{Float64} = zeros(C.NUM)

    p[C.S] = 2.0
    p[C.kE] = 0.4
    p[C.kM] = 1.0
    p[C.kCD] = 0.03
    p[C.kCDS] = 0.45
    p[C.kR] = 0.18
    p[C.kRE] = 180
    p[C.kb] = 0.003
    p[C.KS] = 0.5
    p[C.kCE] = 0.35
    p[C.dM] = 0.7
    p[C.dE] = 0.25
    p[C.dCD] = 1.5
    p[C.dCE] = 1.5
    p[C.dR] = 0.06
    p[C.dRP] = 0.06
    p[C.dRE] = 0.03
    p[C.kP1] = 18.0
    p[C.kP2] = 18.0
    p[C.kDP] = 3.6
    p[C.KM] = 0.15
    p[C.KE] = 0.15
    p[C.KCD] = 0.92
    p[C.KCE] = 0.92
    p[C.KRP] = 0.01

    return p
end
