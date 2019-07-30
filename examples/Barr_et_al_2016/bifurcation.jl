module Bifurcation

using PyPlot;

include("model/model.jl");
using .Model;
include("model/differentialEquation.jl");

include("../../continuation.jl");

include("analysis.jl");
include("diagram.jl");

end  # module