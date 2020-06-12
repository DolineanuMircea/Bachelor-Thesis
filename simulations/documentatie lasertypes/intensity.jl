using LaserTypes
using Unitful
using StaticArrays
using Makie
using MakieLayout
using LinearAlgebra

c = 137.035
q = -1
m = 1
λ = 15117.8089
w0 = 944863.062
τ0 = 744.144
t₀ = 0

i = 2
j = 2
p(k,l) = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=k, p=l)
# f(x,y,z) = 0.5*...TimeProfile?...*norm(E(Point3f0(x*10^6,y*10^6,z*10^6), 1, p(i-1,j-1)))^2

f(x,y,z) = 0.5*norm(E(Point3f0(x*10^6,y*10^6,z*10^6), 1, p(i-1,j-1)))^2

scene = Scene()
r = -5:0.1:5
volume!(
    scene,
    r, r, r,          # coordinates to plot on
    f,                # charge density (functions as colorant)
    algorithm = :mip  # maximum-intensity-projection
)

scene
