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

p(i,j) = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=i, p=j)

scene, layout = layoutscene(30, resolution = (1200, 960))
xx = -5:0.1:5

for i in 1:1:3, j in 1:1:3
    a(i,j) = layout[i, j] = LScene(scene, camera = cam3d!, raw = false)
    f(x,y) = norm(E(Point3f0(x*10^6,y*10^6,p(i-1,j-1).z_F), 1, p(i-1,j-1)))
    surface!(a(i,j), xx, xx, f, colormap=:Spectral)
end

layout[0, 1] = LText(scene, "p=0", padding = (120.0f0, 120.0f0, 0.0f0, 0.0f0))
layout[1, 2] = LText(scene, "p=1", padding = (120.0f0, 120.0f0, 0.0f0, 0.0f0))
layout[1, 3] = LText(scene, "p=2", padding = (120.0f0, 120.0f0, 0.0f0, 0.0f0))
layout[2, 0] = LText(scene, "m=0", padding = (0.0f0, 0.0f0, 110.0f0, 110.0f0), rotation = pi/2)
layout[3, 1] = LText(scene, "m=1", padding = (0.0f0, 0.0f0, 110.0f0, 110.0f0), rotation = pi/2)
layout[4, 1] = LText(scene, "m=1", padding = (0.0f0, 0.0f0, 110.0f0, 110.0f0), rotation = pi/2)

scene
