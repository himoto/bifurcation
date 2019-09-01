function diffeq(u::Vector)

    du = similar(u);

    du[V.M] = p[C.kM]*p[C.S]/(p[C.KS]+p[C.S]) - p[C.dM]*u[V.M];
    du[V.E] = p[C.kE]*(u[V.M]/(p[C.KM]+u[V.M]))*(u[V.E]/(p[C.KE]+u[V.E])) + p[C.kb]*u[V.M]/(p[C.KM]+u[V.M]) +
            p[C.kP1]*u[V.CD]*u[V.RE]/(p[C.KCD]+u[V.RE]) + p[C.kP2]*u[V.CE]*u[V.RE]/(p[C.KCE]+u[V.RE]) - p[C.dE]*u[V.E]-p[C.kRE]*u[V.R]*u[V.E];
    du[V.CD] = p[C.kCD]*u[V.M]/(p[C.KM]+u[V.M]) + p[C.kCDS]*p[C.S]/(p[C.KS]+p[C.S]) - p[C.dCD]*u[V.CD];
    du[V.CE] = p[C.kCE]*u[V.E]/(p[C.KE]+u[V.E]) - p[C.dCE]*u[V.CE];
    du[V.R] = p[C.kR] + p[C.kDP]*u[V.RP]/(p[C.KRP]+u[V.RP]) - p[C.kRE]*u[V.R]*u[V.E] - p[C.kP1]*u[V.CD]*u[V.R]/(p[C.KCD]+u[V.R]) -
            p[C.kP2]*u[V.CE]*u[V.R]/(p[C.KCE]+u[V.R]) - p[C.dR]*u[V.R];
    du[V.RP] = p[C.kP1]*u[V.CD]*u[V.R]/(p[C.KCD]+u[V.R]) + p[C.kP2]*u[V.CE]*u[V.R]/(p[C.KCE]+u[V.R]) + p[C.kP1]*u[V.CD]*u[V.RE]/(p[C.KCD]+u[V.RE]) +
             p[C.kP2]*u[V.CE]*u[V.RE]/(p[C.KCE]+u[V.RE]) - p[C.kDP]*u[V.RP]/(p[C.KRP]+u[V.RP]) - p[C.dRP]*u[V.RP];
    du[V.RE] = p[C.kRE]*u[V.R]*u[V.E]-p[C.kP1]*u[V.CD]*u[V.RE]/(p[C.KCD]+u[V.RE]) - p[C.kP2]*u[V.CE]*u[V.RE]/(p[C.KCE]+u[V.RE]) - p[C.dRE]*u[V.RE];

    return du
end