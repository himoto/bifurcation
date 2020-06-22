module Model

export C, V, param_values, get_derivatives, get_steady_state

using SteadyStateDiffEq
using Sundials

include("name2idx/parameters.jl")
include("name2idx/species.jl")
include("param_const.jl")
include("param_derivative.jl")
include("steady_state.jl")

end # module