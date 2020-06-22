function diffeq(du,u,p,t)
    Complex = p[C.B55tot] - u[V.PP2AB55]
    Wee1p = 1 - u[V.Wee1] - u[V.Wee1pp]
    Cdc25p = 1 - u[V.Cdc25] - u[V.Cdc25pp]
    Vwee = (p[C.kweeS]*(1-u[V.Wee1]) + p[C.kweeF]*u[V.Wee1])
    V25 = p[C.k25S]*(1-u[V.Cdc25pp]) + p[C.k25F]*u[V.Cdc25pp]
    VGwl = p[C.kGwENSA]*u[V.Gwlp]

    du[V.Subp] = p[C.kcBc1Sub]*u[V.CycBCdk1]/((1 + (p[C.InhCDK]/p[C.Kd])))*(p[C.SubT]-u[V.Subp]) - p[C.kB55Sub]*u[V.PP2AB55]*u[V.Subp]
    du[V.CycBCdk1] = V25*(p[C.CycBCdk1T] - u[V.CycBCdk1]) - Vwee*u[V.CycBCdk1]
    du[V.PP1] = (p[C.kapp1] + p[C.kapp1a]*u[V.PP1])*(p[C.PP1T] - u[V.PP1]) - (p[C.kipp1] + p[C.kipp1C]*u[V.CycBCdk1]/((1 + (p[C.InhCDK]/p[C.Kd]))))*u[V.PP1]
    du[V.pENSAt] = VGwl*(p[C.ENSAtot] - u[V.pENSAt]) - p[C.kcatB55]*Complex
    du[V.Gwlp] = (p[C.kcBc1G]*u[V.CycBCdk1]/((1 + (p[C.InhCDK]/p[C.Kd]))) + p[C.kcAc2G]*p[C.CycACdk2T])*(p[C.Gwtot] - u[V.Gwlp]) - (p[C.kB55G]*u[V.PP2AB55] + p[C.kppxGwl] + p[C.kPP1Gw]*u[V.PP1])*u[V.Gwlp]
    du[V.PP2AB55] = p[C.kdis]*Complex + p[C.kcatB55]*Complex - p[C.kass]*u[V.PP2AB55]*(u[V.pENSAt] - Complex)
    du[V.Wee1] = (p[C.kppxY15] + p[C.kB55W1]*u[V.PP2AB55])*Wee1p - (p[C.kcBc1W1]*u[V.CycBCdk1]/((1 + (p[C.InhCDK]/p[C.Kd]))) + p[C.kcAc2W1]*p[C.CycACdk2T])*u[V.Wee1]
    du[V.Wee1pp] = (p[C.kcBc1W1]*u[V.CycBCdk1]/((1 + (p[C.InhCDK]/p[C.Kd]))) + p[C.kcAc2W1]*p[C.CycACdk2T])*Wee1p - (p[C.kppxY15] + p[C.kB55W1]*u[V.PP2AB55])*u[V.Wee1pp]
    du[V.Cdc25] = (p[C.kppxY15] + p[C.kB5525]*u[V.PP2AB55])*Cdc25p - (p[C.kcBc125]*u[V.CycBCdk1]/((1 + (p[C.InhCDK]/p[C.Kd]))) + p[C.kcAc225]*p[C.CycACdk2T])*u[V.Cdc25]
    du[V.Cdc25pp] = (p[C.kcBc125]*u[V.CycBCdk1]/((1 + (p[C.InhCDK]/p[C.Kd]))) + p[C.kcAc225]*p[C.CycACdk2T])*(Cdc25p) - (p[C.kppxY15] + p[C.kB5525]*u[V.PP2AB55])*u[V.Cdc25pp]

end

function get_steady_state(p::Vector{Float64})
    tspan::Tuple{Float64,Float64} = (0.0,Inf)
    u0::Vector{Float64} = zeros(V.NUM)
    u0[V.PP1] = 1.0
    u0[V.PP2AB55] = 0.25
    u0[V.Wee1] = 1.0
    u0[V.Cdc25] = 1.0

    prob = ODEProblem(diffeq,u0,tspan,p)
    prob = SteadyStateProblem(prob)
    sol = solve(prob,DynamicSS(CVODE_BDF()),dt=1.0)

    return sol.u
end