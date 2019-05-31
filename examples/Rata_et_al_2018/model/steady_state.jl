function diffeq_ss(du,u,p,t)
    Complex = p[B55tot] - u[PP2AB55];
    Wee1p = 1 - u[Wee1] - u[Wee1pp];
    Cdc25p = 1 - u[Cdc25] - u[Cdc25pp];
    Vwee = (p[kweeS]*(1-u[Wee1]) + p[kweeF]*u[Wee1]);
    V25 = p[k25S]*(1-u[Cdc25pp]) + p[k25F]*u[Cdc25pp];
    VGwl = p[kGwENSA]*u[Gwlp];

    du[Subp] = p[kcBc1Sub]*u[CycBCdk1]/((1 + (p[InhCDK]/p[Kd])))*(p[SubT]-u[Subp]) - p[kB55Sub]*u[PP2AB55]*u[Subp];
    du[CycBCdk1] = V25*(p[CycBCdk1T] - u[CycBCdk1]) - Vwee*u[CycBCdk1];
    du[PP1] = (p[kapp1] + p[kapp1a]*u[PP1])*(p[PP1T] - u[PP1]) - (p[kipp1] + p[kipp1C]*u[CycBCdk1]/((1 + (p[InhCDK]/p[Kd]))))*u[PP1];
    du[pENSAt] = VGwl*(p[ENSAtot] - u[pENSAt]) - p[kcatB55]*Complex;
    du[Gwlp] = (p[kcBc1G]*u[CycBCdk1]/((1 + (p[InhCDK]/p[Kd]))) + p[kcAc2G]*p[CycACdk2T])*(p[Gwtot] - u[Gwlp]) - (p[kB55G]*u[PP2AB55] + p[kppxGwl] + p[kPP1Gw]*u[PP1])*u[Gwlp];
    du[PP2AB55] = p[kdis]*Complex + p[kcatB55]*Complex - p[kass]*u[PP2AB55]*(u[pENSAt] - Complex);
    du[Wee1] = (p[kppxY15] + p[kB55W1]*u[PP2AB55])*Wee1p - (p[kcBc1W1]*u[CycBCdk1]/((1 + (p[InhCDK]/p[Kd]))) + p[kcAc2W1]*p[CycACdk2T])*u[Wee1];
    du[Wee1pp] = (p[kcBc1W1]*u[CycBCdk1]/((1 + (p[InhCDK]/p[Kd]))) + p[kcAc2W1]*p[CycACdk2T])*Wee1p - (p[kppxY15] + p[kB55W1]*u[PP2AB55])*u[Wee1pp];
    du[Cdc25] = (p[kppxY15] + p[kB5525]*u[PP2AB55])*Cdc25p - (p[kcBc125]*u[CycBCdk1]/((1 + (p[InhCDK]/p[Kd]))) + p[kcAc225]*p[CycACdk2T])*u[Cdc25];
    du[Cdc25pp] = (p[kcBc125]*u[CycBCdk1]/((1 + (p[InhCDK]/p[Kd]))) + p[kcAc225]*p[CycACdk2T])*(Cdc25p) - (p[kppxY15] + p[kB5525]*u[PP2AB55])*u[Cdc25pp];

end

function get_steady_state(p::Vector{Float64})
    tspan_ss::Tuple{Float64,Float64} = (0.0,Inf);
    u0::Vector{Float64} = zeros(SN);
    u0[PP1] = 1.0;
    u0[PP2AB55] = 0.25;
    u0[Wee1] = 1.0;
    u0[Cdc25] = 1.0;

    prob = ODEProblem(diffeq_ss,u0,tspan_ss,p);
    prob = SteadyStateProblem(prob);
    sol = solve(prob,DynamicSS(CVODE_BDF()),dt=1.0);

    return sol.u[end]
end