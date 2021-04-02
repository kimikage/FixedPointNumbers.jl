using FixedPointNumbers, Test

using InteractiveUtils

@code_native Float16(zero(N2f14))

@code_native Float16(0x0001 / BigFloat(16383))

@code_native Float16(1.0)

@code_native Float16(1.0f0)

@show Float16(big"16378"/16383)
@show Float16(big"16379"/16383)

@show Float64(big"16378"/16383)
@show Float64(big"16379"/16383)

@show Float16(0.9996948055911615)
@show Float16(0.9997558444729292)

N = N2f14
T = UInt16
for i = typemin(T):typemax(T)
    f_expected = Float16(i / BigFloat(FixedPointNumbers.rawone(N)))
    f_actual = Float16(reinterpret(N, i))
    f_actual === f_expected || error("$i, $f_actual, $f_expected")
end
#=
if VERSION >= v"1.6.0-DEV.816" # JuliaLang/julia #36962 # FIXME
    @test isempty(detect_ambiguities(FixedPointNumbers))
else
    @test isempty(detect_ambiguities(FixedPointNumbers, Base, Core))
end

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
