function get_derivatives(u::Vector{Float64},p::Vector{Float64})
    # derivatives: dF/d[bifurcation_param]
    dFdp::Vector{Float64} = zeros(SN);

    dFdp[p27T]  = -p[kd27e]*u[Skp2]*u[p27T];
    dFdp[CycEp27] = p[kasse]*(1.0-u[CycEp27])*(u[p27T]-u[CycEp27])-(p[kd27e]*u[Skp2]+p[kdcycee])*u[CycEp27];
    dFdp[Cdh1dp] = -p[kicdh1e]*u[Cdh1dp];
    dFdp[Cdh1] =  -p[kicdh1e]*u[Cdh1];

    return dFdp
end