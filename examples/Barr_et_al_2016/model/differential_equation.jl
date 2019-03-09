function diffeq(u::Vector)
    du = similar(u);

    CycE = p[CycElevel] - u[CycEp27];

    Vdp27 = p[kd27] + (p[kd27e]*CycE)*u[Skp2];
    Vdcyce = p[kdcyce] + p[kdcycee]*CycE;
    Vdskp2 = p[kdskp2] + p[kdskp2c1]*u[Cdh1];

    Vicdh1 = p[kicdh1e]*CycE;

    du[p27T] = p[ks27] - Vdp27*u[p27T];

    du[Skp2] = p[ksskp2] - Vdskp2*u[Skp2];

    du[CycEp27] = p[kasse]*(p[CycElevel]-u[CycEp27])*(u[p27T]-u[CycEp27])-(p[kdise]+Vdp27+Vdcyce)*u[CycEp27];

    du[EmiC] = p[kasec]*(p[Cdh1T]-u[EmiC])*(p[Emi1T]-u[EmiC]) - (p[kdiec]+p[kdemi1])*u[EmiC];

    du[Cdh1dp] = p[kacdh1]*(p[Cdh1T]-u[Cdh1dp]) - Vicdh1*u[Cdh1dp];

    du[Cdh1] = (p[kdiec]+p[kdemi1])*(u[Cdh1dp]-u[Cdh1]) - p[kasec]*u[Cdh1]*(p[Emi1T]-u[EmiC])+p[kacdh1]*(p[Cdh1T]-u[EmiC]-u[Cdh1])-Vicdh1*u[Cdh1];


    return du
end