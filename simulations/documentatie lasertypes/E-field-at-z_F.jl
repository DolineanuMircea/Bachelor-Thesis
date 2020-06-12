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

# Gauss Profile
pg = GaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0)
# Laguerre-Gauss Profile m=p=0 same as Gauss
p00 = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0)
# Laguerre-Gauss Profile m=1 p=0
p10 = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=1, p=0)
# Laguerre-Gauss Profile m=2 p=0
p20 = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=2, p=0)
# Laguerre-Gauss Profile m=0 p=1 -> p=1 does not change much from p=0 (makes the peaks taller)
p01 = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=0, p=1)
# Laguerre-Gauss Profile m=0 p=2
p02 = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=0, p=2)
# Laguerre-Gauss Profile m=1 p=2
p12 = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=1, p=2)
# Laguerre-Gauss Profile m=2 p=2
p22 = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=2, p=2)
# Laguerre-Gauss Profile m=2 p=3 -> again, no shape change from m=2, p=2
p23 = LaguerreGaussLaser(c=c, q=q, m_q=m, λ=λ, w₀=w0, τ₀=τ0, m=2, p=3)

fg(x,y) = norm(E(Point3f0(x*10^6,y*10^6,pg.z_F), 1, pg))
f00(x,y) = norm(E(Point3f0(x*10^6,y*10^6,p00.z_F), 1, p00))
surface(-5:0.1:5, -5:0.1:5, f00)

scene, layout = layoutscene(resolution = (960, 540))

a1 = layout[1, 1] = LScene(scene, camera = cam3d!, raw = false)
layout[1, 1, Top()] = LText(scene, "Gauss")
a2 = layout[2, 1] = LScene(scene, camera = cam3d!, raw = false)
layout[2, 1, Top()] = LText(scene, "m=p=0")
# layout[3, 1] = LAxis(p10, title="m=1 p=0")
# layout[1, 2] = LAxis(p01, title="m=0 p=1")
# layout[2, 2] = LAxis(p02, title="m=0 p=2")
# layout[3, 2] = LAxis(p12, title="m=1 p=2")
# layout[1, 3] = LAxis(p20, title="m=2 p=0")
# layout[2, 3] = LAxis(p22, title="m=2 p=2")
# layout[3, 3] = LAxis(p23, title="m=2 p=3")

xx = -5:0.1:5

foreach(LScene, layout) do s
           surface!(s,xx,xx, fg, colormap=:Spectral);
           end

p1 = surface!(a1, xx, xx, fg)
p2 = surface!(a2, xx, xx, f00)

scene
