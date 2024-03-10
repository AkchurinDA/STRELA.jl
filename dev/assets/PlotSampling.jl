using Fortuna, Random
using CairoMakie, MathTeXEngine
CairoMakie.activate!(type = :svg)

Random.seed!(123)

# --------------------------------------------------
# HISTOGRAM
# --------------------------------------------------
X           = randomvariable("Gamma", "M", [10, 1.5])
XSamples    = rand(X, 10000, LHS())

begin
    F = Figure(size = 72 .* (8, 6), fonts = (; regular = texfont()), fontsize = 14)
    
    A = Axis(F[1, 1], 
            xminorticks = IntervalsBetween(5), yminorticks = IntervalsBetween(5),
            xminorticksvisible = true, yminorticksvisible = true,
            xminorgridvisible = true, yminorgridvisible = true,
            xlabel = L"$x$", ylabel = "PDF",
            limits = (nothing, nothing, 0, nothing),
            aspect = 4 / 3)

    hist!(XSamples,
        color = :steelblue,
        strokecolor = :black, strokewidth = 0.25,
        bins = 50, normalization = :pdf)
    
    display(F)
end

save("SampleRandomVariable.svg", F)

# --------------------------------------------------
# SCATTER (UNCORRELATED)
# --------------------------------------------------
X₁          = randomvariable("Gamma", "M", [10, 1.5])
X₂          = randomvariable("Gamma", "M", [15, 2.5])
X           = [X₁, X₂]
XSamples    = rand(X, 10000, LHS())

begin
    F = Figure(size = 72 .* (6, 6), fonts = (; regular = texfont()), fontsize = 14)

    A = Axis(F[1, 1], 
            xminorticks = IntervalsBetween(5), yminorticks = IntervalsBetween(5),
            xminorticksvisible = true, yminorticksvisible = true,
            xgridvisible = true, ygridvisible = true,
            xminorgridvisible = true, yminorgridvisible = true,
            xlabel = L"$x_{1}$", ylabel = L"$x_{2}$",
            limits = (0, 30, 0, 30),
            aspect = 1)

    scatter!(XSamples[1, :], XSamples[2, :],
        color = (:steelblue, 0.75),
        strokecolor = (:black, 0.75), strokewidth = 0.25,
        markersize = 6)
    
    display(F)
end

save("SampleUncorrelatedRandomVector.svg", F)

# --------------------------------------------------
# SCATTER (CORRELATED)
# --------------------------------------------------
X₁                              = randomvariable("Gamma", "M", [10, 1.5])
X₂                              = randomvariable("Gamma", "M", [15, 2.5])
X                               = [X₁, X₂]
ρˣ                              = [1 -0.75; -0.75 1]
TransformationObject            = NatafTransformation(X, ρˣ)
XSamples, ZSamples, USamples    = rand(TransformationObject, 10000, LHS())

begin
    F = Figure(size = 72 .* (6, 6), fonts = (; regular = texfont()), fontsize = 14)

    A = Axis(F[1, 1], 
            xminorticks = IntervalsBetween(5), yminorticks = IntervalsBetween(5),
            xminorticksvisible = true, yminorticksvisible = true,
            xgridvisible = true, ygridvisible = true,
            xminorgridvisible = true, yminorgridvisible = true,
            xlabel = L"$x_{1}$", ylabel = L"$x_{2}$",
            limits = (0, 30, 0, 30),
            aspect = 1)

    scatter!(XSamples[1, :], XSamples[2, :],
        color = (:steelblue, 0.75),
        strokecolor = (:black, 0.75), strokewidth = 0.25,
        markersize = 6)
    
    display(F)
end

save("SampleCorrelatedRandomVector.svg", F)