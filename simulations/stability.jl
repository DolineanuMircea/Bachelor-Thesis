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

    # implicit Euler solution
    sol3 = Trapezoid(N, Δt, icond)
    p3 = plot(sol3[1], sol3[2], seriestype = :scatter, title = "Trapezoid")

    # implicit Euler solution
    sol4 = St_Ver(N, Δt, icond)
    p4 = plot(sol4[1], sol4[2], seriestype = :scatter, title = "Störmer-Verlet")

    # real solution
    solrx = [sin(x) for x in 0:Δt:N]
    solrv = [cos(x) for x in 0:Δt:N]
    pr = plot(solrx, solrv, seriestype = :scatter, title = "Analytic solution")

    l = @layout [[a b;c d] e]
    plot(pr,p1,p2,p3,p4, layout = l, xticks = -2:2, xlims = (-2,2),
    ylims = (-2,2), xlabel = "x", ylabel = "v", legend = false)
    plot!(size = (700,350))
end

# initial conditions
icond = [0.0,1.0]
# number of steps and time-step
N = 10
Δt = 0.2

make_plots()
