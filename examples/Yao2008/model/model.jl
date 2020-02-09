module Model

export C, V, f_params, get_derivatives, get_steady_state

using SteadyStateDiffEq
using Sundials

include("name2idx/name2idx.jl")
using .Name2Idx

include("param_const.jl")
include("param_derivative.jl")
include("steady_state.jl")

end # module