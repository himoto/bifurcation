function param_values()::Vector{Float64}
    p::Vector{Float64} = zeros(C.NUM)

    p[C.kscyce] = 0.003
    p[C.kdcyce] = 0.001
    p[C.kdcycee] = 0.0001
    p[C.kdcycea] = 0.03
    p[C.kasse] = 1
    p[C.kdise] = 0.02
    ## CYCA SYNTHESISp[C.DEGRADATION AND P27 BINDING/DISSOCIATION:
    p[C.kscyca] = 0.0025
    p[C.kdcyca] = 0.002
    p[C.kdcycac1] = 0.4
    p[C.kassa] = 1
    p[C.kdisa] = 0.02
    ## P27 SYNTHESIS AND DEGRADATION:
    p[C.ks27] = 0.008
    p[C.kd27] = 0.004
    p[C.kd27e] = 2
    p[C.kd27a] = 2
    ## EMI1 SYNTHESIS AND DEGRADATION:
    p[C.ksemi1] = 0.003
    p[C.kdemi1] = 0.001
    ## CDH1 REGULATION:
    p[C.Cdh1T] = 1
    p[C.kacdh1] = 0.02
    p[C.kicdh1e] = 0.07
    p[C.kicdh1a] = 0.2
    p[C.kasec] = 2
    p[C.kdiec] = 0.02
    ## SKP2 SYNTHESIS AND DEGRADATION:
    p[C.ksskp2] = 0.004
    p[C.kdskp2] = 0.002
    p[C.kdskp2c1] = 0.2
    ## CDK INHIBITOR
    p[C.Inhibitor] = 0.0

    p[C.Emi1T] = 0.0
    p[C.CycElevel] = 1.0

    return p
end
