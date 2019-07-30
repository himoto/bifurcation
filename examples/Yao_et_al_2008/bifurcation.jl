module Bifurcation

using PyPlot;

include("model/model.jl");
using .Model;
include("model/differentialEquation.jl");

include("../../continuation.jl");

function analysis()
    global fp,br

    # BP: name(index) of bifurcation parameter
    global BP = C.S;

    global p = f_params();
    newCurve!(p);
    fp = readdlm("./Data/fp.dat",'\t',Float64,'\n');
    ev = readdlm("./Data/ev.dat",'\t',Float64,'\n');
    br = bistableRegime(ev);
end


function diagram()
    rc("figure",figsize = (8,6));
    rc("font",family = "Arial");
    rc("font",size = 24);
    rc("axes",linewidth = 1);
    rc("lines",linewidth = 3);

    plot(fp[1:br[1]-1,VN+1],fp[1:br[1]-1,V.E+1],"k-");
    plot(fp[br,VN+1],fp[br,V.E+1],lw=1.5,"k--");
    plot(fp[br[end]+1:end,VN+1],fp[br[end]+1:end,V.E+1],"k-");

    xlabel("Serum (percentage)");
    ylabel("E2F (μM)");

    xlim(0,2);
    xticks([0,0.5,1,1.5,2]);
    yscale("log");
    ylim(1e-4,2);
    yticks([1e-4,1e-2,1]);

    show();
end

end  # module