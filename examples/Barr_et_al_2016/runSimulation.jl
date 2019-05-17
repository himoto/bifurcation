#---
include("model/f_parameter.jl");
include("model/f_variable.jl");
include("model/param_derivative.jl");
include("model/steadystate.jl");
include("model/differential_equation.jl");
include("../../bifurcation.jl");

# BP: name(index) of bifurcation parameter
const BP = CycElevel;

fp = [];
ev = [];
br = [];

for i=1:5
    global p = f_params();

    if i==1
        p[Emi1T] = 0.0;
    elseif i==1
        p[Emi1T] = 0.5;
    elseif i==2
        p[Emi1T] = 0.75;
    elseif i==3
        p[Emi1T] = 1.0;
    elseif i==4
        p[Emi1T] = 1.25;
    elseif i==5
        p[Emi1T] = 2.0;
    end

    newCurve(p);
    push!(fp,readdlm("./Data/fp.dat",'\t',Float64,'\n'));
    push!(ev,readdlm("./Data/ev.dat",'\t',Float64,'\n'));
    push!(br,bistable_regime(ev[i]));
end

include("plotFunc.jl");
savefig("./p27_CycE.png",bbox_inches="tight");