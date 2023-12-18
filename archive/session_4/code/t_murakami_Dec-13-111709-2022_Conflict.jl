# using GLMakie
import WGLMakie
# using MakieTeX
# using Makie

# import Makie

θ = Observable(0.0)
ytn = Observable(0.0)
π_0 = 0.0

p = (;
    ξ = 0.1,
    γ = 0.3,
    σ = 0.5,
    κ = 0.9
)

function simul(p; θ_0=0.0, ytn_0=0.0, T=100)
    (;ξ, γ, σ, κ) = p
    y_0 = θ_0
    π_0 = p.κ*(y_0 - ytn_0)
    sim_y = [y_0]
    sim_π = [π_0]
    for t=1:T
        ytn = 0.0
        θ = 0.0
        π_0 = sim_π[end]
        y_0 = sim_y[end]
        # π_1 = π_0 + κ*(y-ytn)
        π = π_0*1/(1+κ*σ*γ) + κ/(1+κ*σ*γ)*(θ-ytn)
        y = θ - σ*γ*π
        push!(sim_y, y)
        push!(sim_π, π)
    end
    return( [sim_y, sim_π])
end

sy, sp = simul(p; ytn_0=ytn[])

x = [range(-1, 1; length=100)...]



y_d = θ[]./p.γ .- x./p.γ
y_s = π_0 .+ p.κ.*(x .- ytn[])

f = Figure()
ax = Axis(f[1:2,1])
xlims!(ax,-1.0, 1.0)
ylims!(ax,-1.0, 1.0)
ax.xlabel[] = "y"
ax.ylabel[] = "pi"
l_ad =lines!(ax, x, y_d; label="AD")
l_as = lines!(ax, x, y_s; label="AS")
ax11 = Axis(f[1,2], title=L"Inflation: \pi")
lsim_p = lines!(sp)
ax12 = Axis(f[2,2], title=L"Production: y_t")
lsim_y = lines!(sy)
# vlines!(ax, 0.0)

# sl = SliderGrid(f[3,1],
#     (label=L"\theta_0", startvalue=0.0),
#     (label=L"y^{nt}_0", range = -0.5:0.01:0.5, startvalue=0.0),
# )

# f
sl_t = Makie.Slider(f[3,1],  range = -0.5:0.01:0.5, startvalue=0.0, label="\theta_0")
sl_y = Makie.Slider(f[3,2], range = -0.5:0.01:0.5, startvalue=0.0, label="y^{nt}_0")

f



function update()
    sy, sp = simul(p; θ_0=θ[], ytn_0=ytn[])
    lsim_p.input_args[1][] = sp
    lsim_y.input_args[1][] = sy
    y_d = θ[]./p.γ .- x./p.γ
    y_s = π_0 .+ p.κ.*(x .- ytn[])
    l_ad.input_args[2][] = y_d
    l_as.input_args[2][] = y_s
end

on(θ) do θ
    update()
end

on(ytn) do ytn
    update()
end
on(sl_t.value) do sl_t
    θ[] = sl_t[]
end
on(sl_y.value) do sl_y
    ytn[] = sl_y[]
end


f