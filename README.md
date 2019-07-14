# Bifurcation Analysis
#### A numerical study of the changes in the dynamics and stability of a system upon variations in its parameters
Rata *et al.*, *Curr. Biol.* (2018)
![Subp_1NMPP1](https://user-images.githubusercontent.com/31299606/57923783-39d76100-78de-11e9-9de2-95a385a06a13.png)
Signal-response curves for mitotic substrate phosphorylation in single cells as a function of inhibitor concentration. Steady-state substrate phosphorylation is high (red), low (blue), or intermediate (orange).

## Procedure for stability analysis at fixed points
1. Determine the fixed point vector, ***x***<sup>∗</sup>, solving ***F***(***x***<sup>∗</sup>) = **0**
1. Construct the Jacobian matrix, __*J*__(***x***) = *∂*__*F*__(***x***)/*∂*__*x*__
1. Compute eigenvalues of __*J*__(***x***<sup>∗</sup>): det |__*J*__(***x***<sup>∗</sup>) − *λ*__*E*__| = 0
1. Stability or instability of ***x***<sup>∗</sup> based on the real parts, Re(*λ*), of eigenvalues
    - All eigenvalues have real parts less than zero → ***x***<sup>∗</sup> is stable
    - At least one of the eigenvalues has a real part greater than zero
→ ***x***<sup>∗</sup> is unstable

## Requirements
- **[Julia 1.0+](https://julialang.org)**
    - [SteadyStateDiffEq](https://github.com/JuliaDiffEq/SteadyStateDiffEq.jl)
    - [Sundials](https://github.com/JuliaDiffEq/Sundials.jl)
    - [ForwardDiff](https://github.com/JuliaDiff/ForwardDiff.jl)
    - [PyPlot](https://github.com/JuliaPy/PyPlot.jl)

## Plotting bifurcation diagram
```julia
# Change directory to examples/XXX

include("main.jl")
using .Bifurcation

Bifurcation.analysis()
Bifurcation.diagram()
```

## Installation
    $ git clone https://github.com/himoto/bifurcation.git

## Acknowledgements
I would particularly like to thank Dr. Gouhei Tanaka (Graduate School of Engineering, The University of Tokyo) for valuable discussions.

## References
- Yao, G., Lee, T. J., Mori, S., Nevins, J. R. & You, L. A bistable Rb-E2F switch underlies the restriction point. *Nat. Cell Biol.* **10**, 476–482 (2008). https://doi.org/10.1038/ncb1711

- Barr, A. R., Heldt, F. S., Zhang, T., Bakal, C. & Novák, B. A Dynamical Framework for the All-or-None G1/S Transition. *Cell Syst.* **2**, 27–37 (2016). https://doi.org/10.1016/j.cels.2016.01.001

- Rata, S. *et al.* Two Interlinked Bistable Switches Govern Mitotic Control in Mammalian Cells. *Curr. Biol.* **28**, 3824-3832.e6 (2018). https://doi.org/10.1016/j.cub.2018.09.059

## License
[MIT](/LICENSE)