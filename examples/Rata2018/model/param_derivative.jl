function get_derivatives(u::Vector{Float64},p::Vector{Float64})
    # derivatives: dF/d[bifurcation_param]
    dFdp::Vector{Float64} = zeros(V.len_f_vars)

    Wee1p = 1 - u[V.Wee1] - u[V.Wee1pp]
    Cdc25p = 1 - u[V.Cdc25] - u[V.Cdc25pp]

    dFdp[V.Subp] = - (1/p[C.Kd])*(p[C.kcBc1Sub]*u[V.CycBCdk1]/(1 + (p[C.InhCDK]/p[C.Kd]))^2)*(p[C.SubT]-u[V.Subp])
    dFdp[V.PP1] = (1/p[C.Kd])*(p[C.kipp1] + p[C.kipp1C]*u[V.CycBCdk1]/(1 + (p[C.InhCDK]/p[C.Kd]))^2)*u[V.PP1]
    dFdp[V.Gwlp] = - (1/p[C.Kd])*(p[C.kcBc1G]*u[V.CycBCdk1]/(1 + (p[C.InhCDK]/p[C.Kd]))^2)*(p[C.Gwtot] - u[V.Gwlp])
    dFdp[V.Wee1] = (1/p[C.Kd])*(p[C.kcBc1W1]*u[V.CycBCdk1]/(1 + (p[C.InhCDK]/p[C.Kd]))^2)*u[V.Wee1]
    dFdp[V.Wee1pp] = - (1/p[C.Kd])*(p[C.kcBc1W1]*u[V.CycBCdk1]/(1 + (p[C.InhCDK]/p[C.Kd]))^2)*Wee1p
    dFdp[V.Cdc25] = (1/p[C.Kd])*(p[C.kcBc125]*u[V.CycBCdk1]/(1 + (p[C.InhCDK]/p[C.Kd]))^2)*u[V.Cdc25]
    dFdp[V.Cdc25pp] = - (1/p[C.Kd])*(p[C.kcBc125]*u[V.CycBCdk1]/(1 + (p[C.InhCDK]/p[C.Kd]))^2)*(Cdc25p)

    return dFdp
end