using Printf;
using DelimitedFiles;
using LinearAlgebra;
using SteadyStateDiffEq;
using Sundials;
using ForwardDiff;


const SN = length(F_V);      # num of state variables
const PN = 1;                # num of parameters
const VN = SN+PN;            # num of variables
const MN = SN;               # dim of Newton's method

const MC = 100000;           # maximum of counts
const IVAL = 1e-2;           # first variation
const RATE = 1e-3;           # variation rate
const NEPS = 1e-12;          # eps of Newton's method


# matrix transformation (large diagonal elements move to upper) k: pivot
function pivoting!(
    m::Int,
    s::Matrix{Float64},
    k::Int
    )
    v0::Vector{Float64} = zeros(m+1);
    v1::Vector{Float64} = zeros(m+1);
    possess::Int = 0;
    max::Float64 = 0.0;

    for i=k:m
        r = abs(s[i,k]);
        if max <= r
            max = r;
            possess = i;
        end
    end

    for j=1:m+1
        v0[j] = s[possess,j];
        v1[j] = s[k,j];
    end

    for j=1:m+1
        s[possess,j] = v1[j];
        s[k,j] = v0[j];
    end
end

# Gaussian elimination (row reduction)
function gaussianElimination!(
    m::Int,
    s::Matrix{Float64},
    e::Vector{Float64}
    )
    for i=1:m
        pivoting!(m,s,i);
    end

    for l=1:m                 # forward
        if s[l,l] != 0.0
            w = 1.0/s[l,l];
        else
            w = 1.0;
        end
        for j=l:m+1
            s[l,j] *= w;
            for i=l:m
                s[i,j] -= s[i,l]*s[l,j];
            end
        end
    end

    for i=m:-1:1              # backward
        sum = 0.0;
        for j=i:m
            sum += s[i,j]*e[j];
        end
        e[i] = s[i,m+1] - sum;
    end
end

# Newton's method
function newtonsMethod!(
    x::Vector{Float64},
    real_part::Vector{Float64},
    imaginary_part::Vector{Float64},
    fix_num::Int,
    p::Vector{Float64},
    successful::Bool
    )
    u::Vector{Float64} = zeros(SN);
    vx::Vector{Float64} = zeros(MN);
    s::Matrix{Float64} = zeros(MN,MN+1);

    for i=1:VN
        if fix_num == i
            for j=1:MN
                idx = i+j;
                if idx > VN
                    idx -= VN;
                end
                vx[j] = x[idx];
            end
            break;
        else
            continue;
        end
    end

    # initial error
    e::Vector{Float64} = zeros(MN);
    error::Float64 = 1.0;

    while error > NEPS
        for i=1:VN
            if fix_num == i
                idx_param = VN-i;
                if idx_param == 0
                    y = x[fix_num];
                else
                    y = vx[idx_param];
                end
                p[BP] = y;
                for j=1:MN
                    idx = j-i;
                    if idx == 0
                        y = x[fix_num];
                    elseif idx < 0
                        y = vx[VN+idx];
                    else
                        y = vx[idx];
                    end
                    u[j] = y;
                end
                break;
            else
                continue;
            end
        end

        # initialization
        dFdx::Matrix{Float64} = ForwardDiff.jacobian(diffeq,u);
        dFdp::Vector{Float64} = get_derivatives(u,p);

        F::Vector{Float64} = diffeq(u);

        eigenvalues::Array{Complex{Float64},1} = eigvals(dFdx);
        for i=1:SN
            real_part[i] = real(eigenvalues[i]);
            imaginary_part[i] = imag(eigenvalues[i]);
        end

        # s = [dF-F]
        for i=1:VN
            if fix_num == i
                for k=1:SN
                    for j=1:SN
                        idx = i+j;
                        if idx == VN
                            dF = dFdp[k];
                        elseif idx > VN
                            dF = dFdx[k,idx-VN];
                        else
                            dF = dFdx[k,idx];
                        end
                        s[k,j] = dF;
                    end
                    s[k,VN] = -F[k];
                end
                break;
            else
                continue;
            end
        end

        gaussianElimination!(MN,s,e);

        # update error
        error = 0.0;
        for i=1:MN
            vx[i] += e[i];
            error += e[i]*e[i];
        end
        error = sqrt(error);
        if isnan(error) || isinf(error)
            successful = false;
            break;
        end
    end

    for i=1:VN
        if fix_num == i
            for j=1:MN
                idx = i+j;
                if idx > VN
                    idx -= VN;
                end
                x[idx] = vx[j];
            end
            break;
        else
            continue;
        end
    end
end


function newCurve!(p::Vector{Float64})
    count::Int = 1;
    x::Vector{Float64} = zeros(VN);
    dx::Vector{Float64} = zeros(VN);

    real_part::Vector{Float64} = zeros(SN);
    imaginary_part::Vector{Float64} = zeros(SN);

    # file
    if !isdir("./Data")
        mkdir("./Data");
    else
        files::Vector{String} = readdir("./Data");
        for file in files
            rm("./Data/$file");
        end
    end
    FOUT1 = open("./Data/fp.dat","w");  # file for fixed point
    FOUT2 = open("./Data/ev.dat","w");  # file for eigenvalues

    fix_num0::Int = VN;

    # initial condition
    x[1:SN] = get_steady_state(p);
    x[end] = p[BP];

    direction::Bool = false;  # <--- || --->

    # initial fixed
    fix_val::Float64 = x[fix_num0];
    fix_num::Int = fix_num0;
    x[fix_num] = fix_val;

    # first Newton's method
    successful::Bool = true;
    newtonsMethod!(x,real_part,imaginary_part,fix_num,p,successful);

    write(FOUT1,@sprintf("%d\t",count));
    for i=1:VN
        write(FOUT1,@sprintf("%10.8e\t",x[i]));
    end
    write(FOUT1,@sprintf("%d\n",fix_num));

    write(FOUT2,@sprintf("%d\t",count));
    for i=1:SN
        write(FOUT2,@sprintf("%10.8e\t%10.8e\t",real_part[i],imaginary_part[i]));
    end
    write(FOUT2,@sprintf("%10.8e\t%d\n",p[BP],fix_num));

    count += 1;

    # keep optimums
    px::Vector{Float64} = copy(x);

    # variation
    direction ? fix_val += IVAL : fix_val -= IVAL;

    # same fixed variable
    x[fix_num] = fix_val;

    while count <= MC && successful
        newtonsMethod!(x,real_part,imaginary_part,fix_num,p,successful);

        # maximum variation
        for i=1:VN
            dx[i] = x[i] - px[i];
        end
        sum = 0.0;
        for i=1:VN
            sum += dx[i]*dx[i];
        end
        ave = sqrt(sum);
        for i=1:VN
            dx[i] /= ave;
        end
        px = copy(x);
        for i=1:VN
            x[i] += abs(RATE)*dx[i];
        end

        # fix variable with maximum variation
        j::Int = 1;
        for i=2:VN
            if abs(dx[j]) < abs(dx[i])
                j = i;
            end
        end
        fix_num = j; # fix_num = argmax(abs.(dx));

        # Stop calc.
        if x[end] <= 0.0
            successful = false;
        end

        write(FOUT1,@sprintf("%d\t",count));
        for i=1:VN
            write(FOUT1,@sprintf("%10.8e\t",x[i]));
        end
        write(FOUT1,@sprintf("%d\n",fix_num));

        write(FOUT2,@sprintf("%d\t",count));
        for i=1:SN
            write(FOUT2,@sprintf("%10.8e\t%10.8e\t",real_part[i],imaginary_part[i]));
        end
        write(FOUT2,@sprintf("%10.8e\t%d\n",p[BP],fix_num));

        count += 1;
    end

    close(FOUT1);
    close(FOUT2);
end


function bistable_regime(ev::Matrix{Float64})
    br::Vector{Int} = [];

    for i=1:size(ev,1)
        if maximum(ev[i,[2j for j=1:length(F_V)]]) > 0.0
            push!(br,i);
        end
    end

    return br
end