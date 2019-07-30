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