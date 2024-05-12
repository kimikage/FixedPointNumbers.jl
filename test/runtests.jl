using Pkg
Pkg.add(Pkg.PackageSpec(url="https://github.com/JuliaGraphics/Colors.jl", rev="release-0.12"))
Pkg.add(Pkg.PackageSpec(url="https://github.com/kimikage/ColorVectorSpace.jl", rev="cap_statistics"))
Pkg.test("ColorTypes")
Pkg.test("ColorVectorSpace")
Pkg.test("Colors")

#=
using FixedPointNumbers, Test, Aqua

Aqua.test_all(FixedPointNumbers)

if Sys.ARCH === :x86_64 || Sys.ARCH === :i686
    using Documenter
    doctest(FixedPointNumbers, manual = false)
end

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
