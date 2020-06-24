using Printf
using DelimitedFiles
using LinearAlgebra
using ForwardDiff: jacobian


const SN = V.NUM            # num of state variables
const PN = 1                # num of parameters
const VN = SN + PN          # num of variables
const MN = SN               # dim of Newton's method

const MC = 100000           # maximum of counts
const IVAL = 1e-2           # first variation
const RATE = 1e-3           # variation rate
const NEPS = 1e-12          # eps of Newton's method


# matrix transformation (large diagonal elements move to upper) k: pivot
function pivoting!(s::Matrix{Float64}, pivot::Int)
    v0::Vector{Float64} = zeros(MN+1)
    v1::Vector{Float64} = zeros(MN+1)
    possess::Int = 0
    max_element::Float64 = 0.0

    for i in pivot:size(s,1)
        current_element = abs(s[i, pivot])
        if max_element <= current_element
            max_element = current_element
            possess = i
        end
    end

    for j in 1:size(s,2)
        v0[j] = s[possess, j]
        v1[j] = s[pivot, j]
    end

    for j in 1:size(s,2)
        s[possess, j] = v1[j]
        s[pivot, j] = v0[j]
    end
end

# Gaussian elimination (row reduction)
function gaussian_elimination!(s::Matrix{Float64}, e::Vector{Float64})
    for i in 1:MN
        pivoting!(s, i)
    end
    # forward
    for k in 1:size(s,1)
        w = (s[k, k] != 0.0) ? 1.0 / s[k, k] : 1.0
        for j in k:size(s,2)
            s[k, j] *= w
            for i in k:size(s,1)
                s[i, j] -= s[i, k] * s[k, j]
            end
        end
    end
    # backward
    for i in size(s,1):-1:1
        sum = 0.0
        for j in i:length(e)
            sum += s[i, j] * e[j]
        end
        e[i] = s[i, end] - sum
    end
end


# Newton's method
function newtons_method!(x::Vector{Float64},
                         real_part::Vector{Float64},
                         imaginary_part::Vector{Float64}, 
                         fix_num::Int, p::Vector{Float64},
                         successful::Bool)
    u::Vector{Float64} = zeros(SN)
    vx::Vector{Float64} = zeros(MN)
    s::Matrix{Float64} = zeros(MN, MN+1)

    for i in eachindex(x)
        if fix_num == i
            for j in eachindex(vx)
                idx = i + j
                if idx > length(x)
                    idx -= length(x)
                end
                vx[j] = x[idx]
            end
            break
        else
            continue
        end
    end

    # initial error
    e::Vector{Float64} = zeros(MN)
    error::Float64 = 1.0

    while error > NEPS
        for i in 1:VN
            if fix_num == i
                idx_param = VN - i
                p[BP] = (idx_param == 0) ? x[fix_num] : vx[idx_param]
                for j in eachindex(u)
                    idx = j - i
                    if idx == 0
                        u[j] = x[fix_num]
                    elseif idx < 0
                        u[j] = vx[VN+idx]
                    else
                        u[j] = vx[idx]
                    end
                end
                break
            else
                continue
            end
        end

        # initialization
        dFdx::Matrix{Float64} = jacobian(diffeq, u)
        dFdp::Vector{Float64} = get_derivatives(u, p)

        F::Vector{Float64} = diffeq(u)

        eigenvalues::Array{Complex{Float64}, 1} = eigvals(dFdx)
        for (i, eigenvalue) in enumerate(eigenvalues)
            real_part[i] = real(eigenvalue)
            imaginary_part[i] = imag(eigenvalue)
        end

        # s = [dF-F]
        for i in 1:VN
            if fix_num == i
                for k in 1:SN
                    for j in 1:SN
                        idx = i + j
                        if idx == VN
                            s[k, j] = dFdp[k]
                        elseif idx > VN
                            s[k, j] = dFdx[k, idx-VN]
                        else
                            s[k, j] = dFdx[k, idx]
                        end
                    end
                    s[k, VN] = -F[k]
                end
                break
            else
                continue
            end
        end

        gaussian_elimination!(s, e)

        # update error
        error = 0.0
        @inbounds for i in eachindex(e)
            vx[i] += e[i]
            error += e[i] * e[i]
        end
        error = sqrt(error)
        if isnan(error) || isinf(error)
            successful = false
            break
        end
    end

    for i in eachindex(x)
        if fix_num == i
            for j in eachindex(vx)
                idx = i + j
                if idx > length(x)
                    idx -= length(x)
                end
                x[idx] = vx[j]
            end
            break
        else
            continue
        end
    end
end


function new_curve!(p::Vector{Float64})
    count::Int = 1
    x::Vector{Float64} = zeros(VN)
    dx::Vector{Float64} = zeros(VN)

    real_part::Vector{Float64} = zeros(SN)
    imaginary_part::Vector{Float64} = zeros(SN)

    # file
    if !isdir("./Data")
        mkdir("./Data")
    else
        files::Vector{String} = readdir("./Data")
        for file in files
            rm("./Data/$file")
        end
    end
    FOUT1 = open("./Data/fp.dat", "w")  # file for fixed point
    FOUT2 = open("./Data/ev.dat", "w")  # file for eigenvalues

    # initial condition
    x[1:SN] = get_steady_state(p)
    x[end] = p[BP]  # x-axis

    direction::Bool = false  # <--- || --->

    # initial fixed
    fix_val::Float64 = x[end]
    fix_num::Int = VN
    x[fix_num] = fix_val

    # first Newton's method
    successful::Bool = true
    newtons_method!(x, real_part, imaginary_part, fix_num, p, successful)

    write(FOUT1, @sprintf("%d\t", count))
    for i in eachindex(x)
        write(FOUT1, @sprintf("%10.8e\t", x[i]))
    end
    write(FOUT1, @sprintf("%d\n", fix_num))
    write(FOUT2, @sprintf("%d\t", count))
    for i in 1:SN
        write(
            FOUT2, @sprintf(
                "%10.8e\t%10.8e\t", real_part[i], imaginary_part[i]
            )
        )
    end
    write(FOUT2, @sprintf("%10.8e\t%d\n", p[BP], fix_num))
    count += 1

    # keep optimums
    px::Vector{Float64} = copy(x)

    # variation
    fix_val += ifelse(direction, +IVAL, -IVAL)

    # same fixed variable
    x[fix_num] = fix_val

    while count <= MC && successful
        newtons_method!(x, real_part, imaginary_part, fix_num, p, successful)

        # maximum variation
        for (i, prev) in enumerate(px)
            @inbounds dx[i] = x[i] - prev
        end
        sum::Float64 = 0.0
        for i in eachindex(dx)
            @inbounds sum += dx[i] * dx[i]
        end
        ave::Float64 = sqrt(sum)
        for i in eachindex(dx)
            @inbounds dx[i] /= ave
        end
        px = copy(x)
        for (i, diff) in enumerate(dx)
            @inbounds x[i] += abs(RATE) * diff
        end

        # fix variable with maximum variation
        j::Int = 1
        for i in 2:length(dx)
            if abs(dx[j]) < abs(dx[i])
                j = i
            end
        end
        fix_num = j

        # Stop calc.
        if x[end] <= 0.0
            successful = false
        end

        write(FOUT1, @sprintf("%d\t", count))
        for i in eachindex(x)
            write(FOUT1, @sprintf("%10.8e\t", x[i]))
        end
        write(FOUT1, @sprintf("%d\n", fix_num))
        write(FOUT2, @sprintf("%d\t", count))
        for i in 1:SN
            write(
                FOUT2, @sprintf(
                    "%10.8e\t%10.8e\t", real_part[i], imaginary_part[i]
                )
            )
        end
        write(FOUT2, @sprintf("%10.8e\t%d\n", p[BP], fix_num))
        count += 1
    end

    close(FOUT1)
    close(FOUT2)
end


function bistable_regime(ev::Matrix{Float64})
    br::Vector{Int} = []

    for i in 1:size(ev, 1)
        if maximum(ev[i, [2j for j in 1:SN]]) > 0.0
            push!(br, i)
        end
    end

    return br
end