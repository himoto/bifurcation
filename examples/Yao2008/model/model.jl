module Model

export C, V, f_params, getDerivatives, getSteadyState

using SteadyStateDiffEq;
using Sundials;

include("name2idx/name2idx.jl");
using .Name2Idx

include("paramConst.jl");
include("paramDerivative.jl");
include("steadyState.jl");

end # module