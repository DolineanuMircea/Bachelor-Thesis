using Plots

# equation: dv/dt = -x; dx/dt = v

# explicit Euler
function Exp_Euler(N, Δt, icond)
    x = [icond[1]]
    v = [icond[2]]
    for i in 1:convert(Int64, N/Δt)
        push!(x, x[i] + v[i]*Δt)
        push!(v, v[i] - x[i]*Δt)
    end
    return [x, v]
end

# implicit Euler
function Imp_Euler(N, Δt, icond)
    x = [icond[1]]
    v = [icond[2]]
    for i in 1:convert(Int64, N/Δt)
        push!(x, (x[i] + v[i]*Δt)/(1 + Δt^2))
        push!(v, (v[i] - x[i]*Δt)/(1 + Δt^2))
    end
    return [x, v]
end

# semi-implicit Euler
function SImp_Euler(N, Δt, icond)
    x = [icond[1]]
    v = [icond[2]]
    for i in 1:convert(Int64, N/Δt)
        push!(v, v[i] - x[i]*Δt)
        push!(x, x[i] + v[i+1]*Δt)
    end
    return [x, v]
end

# trapezoid rule
function Trapezoid(N, Δt, icond)
    x = [icond[1]]
    v = [icond[2]]
    for i in 1:convert(Int64, N/Δt)
        push!(x, (x[i]*(1 - Δt^2/4) + v[i]*Δt)/(1 + Δt^2/4))
        push!(v, (v[i]*(1 - Δt^2/4) - x[i]*Δt)/(1 + Δt^2/4))
    end
    return [x, v]
end

# Störmer-Verlet method
function St_Ver(N, Δt, icond)
    x = [icond[1]]
    v = [icond[2]]
    for i in 1:convert(Int64, N/Δt)
        v1half = v[i] - x[i]*Δt/2
        push!(x, x[i] + v1half*Δt)
        push!(v, v1half - x[i+1]*Δt/2)
    end
    return [x, v]
end


function make_plots()
    # explicit Euler solution
    sol1 = Exp_Euler(N, Δt, icond)
    p1 = plot(sol1[1], sol1[2], seriestype = :scatter, title = "Explicit Euler")

    # implicit Euler solution
    sol2 = Imp_Euler(N, Δt, icond)
    p2 = plot(sol2[1], sol2[2], seriestype = :scatter, title = "Implicit Euler")

    # semi-implicit Euler solution
    sol3 = SImp_Euler(N, Δt, icond)
    p3 = plot(sol3[1], sol3[2], seriestype = :scatter,
    title = "Semi-implicit Euler")

    # trapezoid solution
    sol4 = Trapezoid(N, Δt, icond)
    p4 = plot(sol4[1], sol4[2], seriestype = :scatter, title = "Trapezoid")

    # Störmer-Verlet solution
    sol5 = St_Ver(N, Δt, icond)
    p5 = plot(sol5[1], sol5[2], seriestype = :scatter, title = "Störmer-Verlet")

    # real solution
    solrx = [sin(x) for x in 0:Δt:N]
    solrv = [cos(x) for x in 0:Δt:N]
    pr = plot(solrx, solrv, seriestype = :scatter, title = "Analytic solution")

    l = @layout [a b c; d e f]
    plot(pr,p1,p2,p3,p4,p5, layout = l, xticks = -2:2, xlims = (-2.5,2.5),
    ylims = (-2.5,2.5), xlabel = "x", ylabel = "v", legend = false)
    plot!(size = (750,500))
end

# initial conditions
icond = [0.0,1.0]
# number of periods and time-step
N = 15
Δt = 0.3

p = make_plots()

png(p, "stability_plots2")
