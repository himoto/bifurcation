function analysis()
    global fp, br

    # BP: name(index) of bifurcation parameter
    global BP = C.InhCDK;

    fp = [];
    ev = [];
    br = [];

    for i=1:4
        global p = f_params();
        # i==1 -> Control
        if i==2 # Wee1 inhibition
            p[C.kweeS] = 0.0;
            p[C.kweeF] = 0.0;
        elseif i==3 # Gwl siRNA
            p[C.Gwtot] = 0.0;
        elseif i==4 # Wee1 inhibition & Gwl siRNA
            p[C.kweeS] = 0.0;
            p[C.kweeF] = 0.0;
            p[C.Gwtot] = 0.0;
        end

        newCurve!(p);
        push!(fp,readdlm("./Data/fp.dat",'\t',Float64,'\n'));
        push!(ev,readdlm("./Data/ev.dat",'\t',Float64,'\n'));
        push!(br,bistableRegime(ev[i]));
    end
end