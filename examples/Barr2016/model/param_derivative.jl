function get_derivatives(u::Vector{Float64},p::Vector{Float64})
    # derivatives: dF/d[bifurcation_param]
    dFdp::Vector{Float64} = zeros(V.NUM)

    dFdp[V.p27T]  = -p[C.kd27e]*u[V.Skp2]*u[V.p27T]
    dFdp[V.CycEp27] = p[C.kasse]*(1.0-u[V.CycEp27])*(u[V.p27T]-u[V.CycEp27])-(p[C.kd27e]*u[V.Skp2]+p[C.kdcycee])*u[V.CycEp27]
    dFdp[V.Cdh1dp] = -p[C.kicdh1e]*u[V.Cdh1dp]
    dFdp[V.Cdh1] =  -p[C.kicdh1e]*u[V.Cdh1]

    return dFdp
end