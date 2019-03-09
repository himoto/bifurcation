function get_derivatives(u::Vector{Float64},p::Vector{Float64})
    # derivatives: dF/d[bifurcation_param]
    dFdp::Vector{Float64} = zeros(SN);

    dFdp[M] = p[kM]*p[KS]/(p[KS] + p[S])^2;
    dFdp[CD] = p[kCDS]*p[KS]/(p[KS] + p[S])^2;

    return dFdp
end