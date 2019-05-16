function get_derivatives(u::Vector{Float64},p::Vector{Float64})
    # derivatives: dF/d[bifurcation_param]
    dFdp::Vector{Float64} = zeros(SN);

    Wee1p = 1 - u[Wee1] - u[Wee1pp];
    Cdc25p = 1 - u[Cdc25] - u[Cdc25pp];
    
    dFdp[Subp] = - (1/p[Kd])*(p[kcBc1Sub]*u[CycBCdk1]/(1 + (p[InhCDK]/p[Kd]))^2)*(p[SubT]-u[Subp]);
    dFdp[PP1] = (1/p[Kd])*(p[kipp1] + p[kipp1C]*u[CycBCdk1]/(1 + (p[InhCDK]/p[Kd]))^2)*u[PP1];
    dFdp[Gwlp] = - (1/p[Kd])*(p[kcBc1G]*u[CycBCdk1]/(1 + (p[InhCDK]/p[Kd]))^2)*(p[Gwtot] - u[Gwlp]);
    dFdp[Wee1] = (1/p[Kd])*(p[kcBc1W1]*u[CycBCdk1]/(1 + (p[InhCDK]/p[Kd]))^2)*u[Wee1];
    dFdp[Wee1pp] = - (1/p[Kd])*(p[kcBc1W1]*u[CycBCdk1]/(1 + (p[InhCDK]/p[Kd]))^2)*Wee1p;
    dFdp[Cdc25] = (1/p[Kd])*(p[kcBc125]*u[CycBCdk1]/(1 + (p[InhCDK]/p[Kd]))^2)*u[Cdc25];
    dFdp[Cdc25pp] = - (1/p[Kd])*(p[kcBc125]*u[CycBCdk1]/(1 + (p[InhCDK]/p[Kd]))^2)*(Cdc25p);

    return dFdp
end