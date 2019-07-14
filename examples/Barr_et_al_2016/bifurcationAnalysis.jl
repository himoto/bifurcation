function analysis()
    global fp, br

    # BP: name(index) of bifurcation parameter
    global BP = C.CycElevel;

    fp = [];
    ev = [];
    br = [];

    for i=1:6
        global p = f_params();

        if i==1
            p[C.Emi1T] = 0.0;
        elseif i==2
            p[C.Emi1T] = 0.5;
        elseif i==3
            p[C.Emi1T] = 0.75;
        elseif i==4
            p[C.Emi1T] = 1.0;
        elseif i==5
            p[C.Emi1T] = 1.25;
        elseif i==6
            p[C.Emi1T] = 2.0;
        end

        newCurve!(p);
        push!(fp,readdlm("./Data/fp.dat",'\t',Float64,'\n'));
        push!(ev,readdlm("./Data/ev.dat",'\t',Float64,'\n'));
        push!(br,bistableRegime(ev[i]));
    end
end