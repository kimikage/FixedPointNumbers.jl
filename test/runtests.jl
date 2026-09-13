using FixedPointNumbers, Test#, Aqua
#=
Aqua.test_all(FixedPointNumbers)

if Sys.ARCH === :x86_64 || Sys.ARCH === :i686
    using Documenter
    doctest(FixedPointNumbers, manual = false)
end
=#
struct MyFixed <: FixedPoint{Int, 0} end
ns = rand(N0f8, 10^6)
qs = min.(rand(Q1f6, 10^6), 1Q1f6)

for f in (floor, ceil, trunc, round)
    println("Testing function: ", f)
    GC.gc()
    f.(ns); f.(Int, ns)
    @time f.(ns)
    @time f.(Int, ns)
    f.(qs); f.(Int, qs)
    @time f.(qs)
    @time f.(Int, qs)
    try
        f(Int, MyFixed())
    catch
        if Base.isdefined(Base,:current_exceptions)
            Base.display_error(stderr, current_exceptions())
        else
            display(stacktrace(catch_backtrace()))
        end
    end
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
