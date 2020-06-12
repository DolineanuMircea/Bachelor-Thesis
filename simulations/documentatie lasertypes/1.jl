using LaserTypes
using Unitful
using StaticArrays

p = GaussLaser()

x₀ = SVector{3}(0u"μm",0u"μm",0u"μm")
t₀ = 0u"s"

E(x₀, t₀, p)

c = 137.035
q = -1
m = 1
λ = 15117.8089
w0 = 944863.062
τ0 = 744.144
t₀ = 0
p = GaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0)

using Makie
using LinearAlgebra

f(x,y) = norm(E(Point3f0(x*10^6,y*10^6,p.z_F), 1, p))
surface(-5:0.1:5, -5:0.1:5, f)

p = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0)

p = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=2, p=0)

f(x,y) = norm(E(Point3f0(x*10^6,y*10^6,p.z_F), 1, p))
surface(-5:0.1:5, -5:0.1:5, f)
