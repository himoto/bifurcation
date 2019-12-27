module Bifurcation

using PyPlot;

include("model/model.jl");
using .Model;
include("./differentialEquation.jl");
include("../../continuation.jl");

function analysis()
    global fp, br

    # BP: name(index) of bifurcation parameter
    global BP = C.CycElevel;

    fp = [];
    ev = [];
    br = [];

    for i in 1:6
        global p = f_params();

        if i == 1
            p[C.Emi1T] = 0.0;
        elseif i == 2
            p[C.Emi1T] = 0.5;
        elseif i == 3
            p[C.Emi1T] = 0.75;
        elseif i == 4
            p[C.Emi1T] = 1.0;
        elseif i == 5
            p[C.Emi1T] = 1.25;
        elseif i == 6
            p[C.Emi1T] = 2.0;
        end

        newCurve!(p);
        push!(fp,readdlm("./Data/fp.dat",'\t',Float64,'\n'));
        push!(ev,readdlm("./Data/ev.dat",'\t',Float64,'\n'));
        push!(br,bistableRegime(ev[i]));
    end
end


function diagram()
    rc("figure",figsize = (9,6));
    rc("font",family = "Arial");
    rc("font",size = 20);
    rc("axes",linewidth = 1.2);
    rc("xtick.major",width = 1.2);
    rc("ytick.major",width = 1.2);
    rc("lines",linewidth = 2);

    for (i,(fixed_point,unstable_ss)) in enumerate(zip(fp,br))
        if i == 1
            color = "red";
        else
            color = "silver";
        end
        plot(
            fixed_point[1:unstable_ss[1]-1,VN+1],
            fixed_point[1:unstable_ss[1]-1,V.p27T+1],
            "-",color=color
        );
        plot(
            fixed_point[unstable_ss,VN+1],
            fixed_point[unstable_ss,V.p27T+1],
            "--",color=color
        );
        plot(
            fixed_point[unstable_ss[end]+1:end,VN+1],
            fixed_point[unstable_ss[end]+1:end,V.p27T+1],
            "-",color=color
        );
    end
    xlabel("CycE level");
    ylabel("p27 level");

    xlim(0.0,1.0);
    xticks([0,0.5,1]);
    ylim(0.0,2.05);
    yticks([0,1,2]);

    show();
end
end  # module