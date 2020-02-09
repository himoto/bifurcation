function get_derivatives(u::Vector{Float64},p::Vector{Float64})
    # derivatives: dF/d[bifurcation_param]
    dFdp::Vector{Float64} = zeros(V.len_f_vars)

    dFdp[V.M] = p[C.kM]*p[C.KS]/(p[C.KS] + p[C.S])^2
    dFdp[V.CD] = p[C.kCDS]*p[C.KS]/(p[C.KS] + p[C.S])^2

    return dFdp
end