# Bifurcation
## Procedure for stability analysis at fixed points
1. Determine the fixed point vector, ***x***<sup>∗</sup>, solving ***F***(***x***<sup>∗</sup>) = **0**
1. Construct the Jacobian matrix, *J*(***x***) = *∂*__*F*__(***x***)/*∂*__*x*__
1. Compute eigenvalues of *J*(***x***<sup>∗</sup>): det |*J*(***x***<sup>∗</sup>) − *λ*__*E*__| = 0
1. Stability or instability of ***x***<sup>∗</sup> based on the real parts, Re(*λ*), of eigenvalues
    - All eigenvalues have real parts less than zero → ***x***<sup>∗</sup> is stable
    - At least one of the eigenvalues has a real part greater than zero
→ ***x***<sup>∗</sup> is unstable
## Requirements
- **[Julia 1.0+](https://julialang.org)**
  - Sundials
  - ForwardDiff
  - PyPlot
- **[Juno](http://junolab.org)**
## Installation
    $ git clone https://github.com/u360665a/Bifurcation.git
## Acknowledgements
I would particularly like to thank Dr. Gouhei Tanaka (Graduate School of Engineering, The University of Tokyo) for valuable discussions.
## References
- Yao, G., Lee, T. J., Mori, S., Nevins, J. R. & You, L. A bistable Rb-E2F switch underlies the restriction point. Nat. Cell Biol. 10, 476–482 (2008). https://doi.org/10.1038/ncb1711

- Barr, A. R., Heldt, F. S., Zhang, T., Bakal, C. & Novák, B. A Dynamical Framework for the All-or-None G1/S Transition. Cell Syst. 2, 27–37 (2016). https://doi.org/10.1016/j.cels.2016.01.001

- Rata, S. et al. Two Interlinked Bistable Switches Govern Mitotic Control in Mammalian Cells. Curr. Biol. 28, 3824-3832.e6 (2018). https://doi.org/10.1016/j.cub.2018.09.059
## License
MIT