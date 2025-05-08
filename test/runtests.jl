using Pkg
Pkg.activate("fpn")
Pkg.develop(PackageSpec(path=joinpath(@__DIR__, "..")))

try
    Pkg.add("ColorTypes")
    Pkg.test("ColorTypes")
catch
end

try
    Pkg.add("Colors")
    Pkg.test("Colors")
catch
end

try
    Pkg.add("ColorVectorSpace")
    Pkg.test("ColorVectorSpace")
catch
end

try
    Pkg.add("ImageCore")
    Pkg.test("ImageCore")
catch
end

#=
using FixedPointNumbers, Test

@test isempty(detect_ambiguities(FixedPointNumbers, Base, Core))

@testset "normed" begin
    include("normed.jl")
end
@testset "fixed" begin
    include("fixed.jl")
end

@testset "traits" begin
    include("traits.jl")
end
=#
