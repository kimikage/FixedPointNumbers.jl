using FixedPointNumbers, Test, Aqua

@testset "Promotion within Normed" begin
    @test @inferred(promote(N0f8(0.2), N0f8(0.8))) ===
          (N0f8(0.2), N0f8(0.8))
    @test @inferred(promote(Normed{UInt16,3}(0.2), Normed{UInt8,3}(0.86))) ===
          (Normed{UInt16,3}(0.2), Normed{UInt16,3}(0.86))
    @test @inferred(promote(Normed{UInt8,7}(0.197), Normed{UInt8,4}(0.8))) ===
          (Normed{UInt16,7}(0.197), Normed{UInt16,7}(0.8))

    @test Normed{UInt16,16}(1) == Normed{UInt8,8}(1)
    @test Normed{UInt16,16}(0.2) == Normed{UInt8,8}(0.2)
    @test Normed{UInt16,8}(1) == Normed{UInt8,8}(1)
    @test Normed{UInt16,8}(0.2) == Normed{UInt8,8}(0.2)
    @test Normed{UInt16,16}(1) == Normed{UInt8,6}(1)
    @test Normed{UInt16,16}(0.20635) == Normed{UInt8,6}(0.20635)
    @test Normed{UInt16,4}(1) == Normed{UInt8,6}(1)
    @test Normed{UInt16,4}(0.2) == Normed{UInt8,6}(0.2)

    @test @inferred(promote_type(N0f8, Float64)) === Float64
    @test @inferred(promote_type(Float32, N8f24)) === Float64

    @test @inferred(promote_type(N0f8, Int8)) === Float32
    @test @inferred(promote_type(Int128, N8f24)) === Float64

    @test @inferred(promote_type(N0f16, Rational{Int8})) === Rational{Int8}

    @test @inferred(promote_type(N0f8, Float32, Int)) === Float32
    @test @inferred(promote_type(N0f8, Int, Float32)) === Float32
    @test @inferred(promote_type(Int, N0f8, Float32)) === Float32
    @test @inferred(promote_type(Int, Float32, N0f8)) === Float32
    @test @inferred(promote_type(Float32, Int, N0f8)) === Float32
    @test @inferred(promote_type(Float32, N0f8, Int)) === Float32

    if promote_type(Int, Float32, Complex{Int}, typeof(pi)) === ComplexF64
        # right-to-left
        @test @inferred(promote_type(N0f8, N1f7, N2f6, N3f5, N4f4, N5f3)) === Normed{UInt128,8}
    else
        # left-to-right
        @test @inferred(promote_type(N5f3, N4f4, N3f5, N2f6, N1f7, N0f8)) === Normed{UInt128,8}
    end

    @test @inferred(promote_type(N0f8, Q0f31)) === Float64
end

#=
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
