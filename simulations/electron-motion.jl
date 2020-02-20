using Plots

x(t; c, a₀, ω) = c*a₀/ω*(cos(ω*t)-1)
z(t; c, a₀, ω) = c*a₀^2/4*(t - sin(2*ω*t)/(2*ω))

function plot_electron_motion(c, a₀, ω)
    kwargs = (c = c, a₀ = a₀, ω = ω)

    t = 0:(2*6.14/ω)/1000:(2*6.14/ω)
    plot(z.(t; kwargs...), x.(t; kwargs...),xlabel="z", ylabel="x", legend=false)
end

plot_electron_motion(c, a₀, ω)

savefig("relativistic_electron_cont_pulse.png")

function plot_electron_finite_pulse(c, a₀, ω, τ₀)
    a(τ; a₀, τ₀, ω) = a₀*exp(-(τ/τ₀)^2)*sin(ω*τ)
    kwargs = (a₀ = a₀, τ₀ = τ₀, ω = ω)
    τ = 0
    dτ = 6.14/ω/1000
    x = 0
    z = 0
    trans = []
    long = []
    for t in τ:dτ:5*τ₀
        push!(trans,x)
        push!(long,z)
        x = x + c*a(t; kwargs...)*dτ
        z = z + c*a(t; kwargs...)*a(t; kwargs...)*dτ/2
    end
    plot(long, trans, xlabel="z", ylabel="x", legend=false)
end

c = 3*10^8
a₀ = 20
ω = 2*3.14*4*10^14
τ₀ = 30*10^(-15)

plot_electron_finite_pulse(c, a₀, ω, τ₀)

savefig("relativistic_electron_short_pulse.png")
