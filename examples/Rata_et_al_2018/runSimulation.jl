#---
include("model/f_parameter.jl");
include("model/f_variable.jl");
include("model/param_derivative.jl");
include("model/steady_state.jl");
include("model/differential_equation.jl");
include("../../bifurcation.jl");

# BP: name(index) of bifurcation parameter
const BP = InhCDK;

fp = [];
ev = [];
br = [];

for i=1:4
    global p = f_params();
    # i==1 -> Control
    if i==2 # Wee1 inhibition
        p[kweeS] = 0.0;
        p[kweeF] = 0.0;
    elseif i==3 # Gwl siRNA
        p[Gwtot] = 0.0;
    elseif i==4 # Wee1 inhibition & Gwl siRNA
        p[kweeS] = 0.0;
        p[kweeF] = 0.0;
        p[Gwtot] = 0.0;
    end

    newCurve(p);
    push!(fp,readdlm("./Data/fp.dat",'\t',Float64,'\n'));
    push!(ev,readdlm("./Data/ev.dat",'\t',Float64,'\n'));
    push!(br,bistable_regime(ev[i]));
end

include("plotFunc.jl");
savefig("./Subp_1NMPP1.png",bbox_inches="tight");
