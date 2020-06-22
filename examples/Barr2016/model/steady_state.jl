function diffeq(du,u,p,t)
    CycE = p[C.CycElevel] - u[V.CycEp27]

    Vdp27 = p[C.kd27] + (p[C.kd27e]*CycE)*u[V.Skp2]
    Vdcyce = p[C.kdcyce] + p[C.kdcycee]*CycE
    Vdskp2 = p[C.kdskp2] + p[C.kdskp2c1]*u[V.Cdh1]

    Vicdh1 = p[C.kicdh1e]*CycE

    du[V.p27T] = p[C.ks27] - Vdp27*u[V.p27T]

    du[V.Skp2] = p[C.ksskp2] - Vdskp2*u[V.Skp2]

    du[V.CycEp27] = p[C.kasse]*(p[C.CycElevel]-u[V.CycEp27])*(u[V.p27T]-u[V.CycEp27])-(p[C.kdise]+Vdp27+Vdcyce)*u[V.CycEp27]

    du[V.EmiC] = p[C.kasec]*(p[C.Cdh1T]-u[V.EmiC])*(p[C.Emi1T]-u[V.EmiC]) - (p[C.kdiec]+p[C.kdemi1])*u[V.EmiC]

    du[V.Cdh1dp] = p[C.kacdh1]*(p[C.Cdh1T]-u[V.Cdh1dp]) - Vicdh1*u[V.Cdh1dp]

    du[V.Cdh1] = (p[C.kdiec]+p[C.kdemi1])*(u[V.Cdh1dp]-u[V.Cdh1]) - p[C.kasec]*u[V.Cdh1]*(p[C.Emi1T]-u[V.EmiC])+p[C.kacdh1]*(p[C.Cdh1T]-u[V.EmiC]-u[V.Cdh1])-Vicdh1*u[V.Cdh1]


end


function get_steady_state(p::Vector{Float64})
    tspan::Tuple{Float64,Float64} = (0.0,Inf)
    u0::Vector{Float64} = zeros(V.NUM)

    prob = ODEProblem(diffeq,u0,tspan,p)
    prob = SteadyStateProblem(prob)
    sol = solve(prob,DynamicSS(CVODE_BDF()),dt=1.0)

    return sol.u
end