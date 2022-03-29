### A Pluto.jl notebook ###
# v0.18.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 24975543-a212-41eb-804a-3104ef0690f7
begin
	using Logging,HypertextLiteral,PlutoUI,LaTeXStrings, Latexify
	Logging.disable_logging(Logging.Info) # Disables printing on the (pluto) terminal
end

# ╔═╡ 2f36ece6-d7a2-4545-b45a-f437c1cf0c47
begin
	using Plots,Plots.PlotMeasures # To be able to use cm, mm, etc.
	latexticksize = 15
	default(legend=false,
			size=(250,225),
			tickfontsize=8,
			color=:black
	)
	function center_div(something)
		@htl "<div align='center'>$something</div>"
	end;
end

# ╔═╡ 36c32df0-a00e-11ec-1a33-8fbf1ea3ccbc
html"""
Notebook Size & Color Settings
<style> main {max-width: 925px; } </style>
<style> .rich_output {color: black;}</style>
"""

# ╔═╡ 256756d6-d809-4589-b994-5938c8f17675
# This allows to use the physics package of MathJax and it's LaTex macros. It's a LaTeX call ofc.
md"""$\require{physics}$"""

# ╔═╡ 54e7292e-823f-49a2-9463-a7e60c36589d
TableOfContents(title="Limits of Functions")

# ╔═╡ e280f46d-25f2-419b-a5eb-2de1f3bc427c
begin
	function circle(x_pos, y_pos, r)
		θ = range(start=0, stop=2π, length=75)
		x_pos .+ r*cos.(θ), y_pos .+ r*sin.(θ)
	end
	
	function arc(x_pos, y_pos, θ1, θ2, r)
		θ = range(start=θ1, stop=θ2, length=75)
		x_pos .+ r*cos.(θ), y_pos .+ r*sin.(θ)
	end

	function sector(x_pos, y_pos, θ1, θ2, r)
		θ1 = θ1%2π # Max input is 2π
		θ2 = θ2%2π
		θ = range(start=θ1, stop=θ2, length=50)
		shape = Plots.Shape(x_pos .+ r*cos.(θ), y_pos .+ r*sin.(θ)) # Shape automatically fills color
		append!(shape.x, 0) # appending origin to close the sector
		append!(shape.y, 0) # notice that "shape" is a mutable struct
		shape
	end
end

# ╔═╡ 421b0b0e-0455-4e7f-a14e-ad9a045934f0
md"""
# Useful Inequalities
## Triangle Inequality
Sean $a$ y $b$ dos números reales, entonces

$\begin{equation}
\boxed{|a+b| \leq |a|+ |b|}
\end{equation}$
- Si ambos $a$ y $b$ son ambos positivos o ambos negativos, se cumple la igualdad.
- Si tienen signos contrarios, ocurrirá una sustracción, la cual siempre será menor que la suma de los valores absolutos individuales. $\blacksquare$

Funciona también para valores absolutos con más de 2 términos (aplicándola sucesivamente).

$\begin{align}
|a+b+c| &\leq |a+b| + |c| \\
	&\leq |a| + |b| + |c|
\end{align}$
"""

# ╔═╡ 566c013f-84d8-4285-a2d9-215634878a4a
md"""
## Reverse Triangle Inequality
 Ahora, por *Triangle Inequality* tenemos que

$\begin{align}
|b| = |a+b-a| &\leq |a| + |b-a| \\
|b| - |a| &\leq |b-a|
\end{align}$

y

$\begin{align}
|a| = |b+a-b| &\leq |b| + |a-b| \\
|a| - |b| &\leq |a-b|
\end{align}$

Por definición del valor absoluto tenemos $|b-a| = |a-b|$ y además
$(y \leq x \land -y \leq x) \implies \lvert{y}\rvert \leq x$. Por lo tanto, sin pérdida de generalidad con respecto a cuál valor es el minuendo o sustraendo, tenemos que

$\begin{align}
\boxed{\abs{|a|-|b|} \leq |a-b|}
\end{align}$

"""

# ╔═╡ 036d2162-49a8-4631-8532-b44cd6b16068
md"""
# Definition and Properties
## ϵ-δ definition of a limit
Sea $x$ una variable, $f(x)$ una función y $x_0$ un valor particular de $x$, entonces un concepto intuitivo para el límite de una función es que, a medida que $x$ se aproxima a $x_0$, $f(x)$ se aproxima al valor límite $L$, i.e. $f(x_0) \approx L$. Sin embargo es necesaria una definición algebraica más rigurosa.
"""

# ╔═╡ 2a138e93-5d4b-4da1-9891-74bdcf9fc60e
let
	f(x) = x; x = Vector(1:100)
	a = 50; Δ = 10

	anim = @animate for i in 0:0.25:Δ
		plot(x, f.(x), color = "black", line=2,
			xticks=([50], ["\$ x_0 \$"]), yticks=([50], ["\$ L \$"]),
			tickfontsize=latexticksize) # Main function y=f(x)
		plot!([a,a],[0,f(a)], color=:black, line=:dash) # From here, other plots are added
		plot!([0,a],[a,f(a)], color=:black, line=:dash)
		plot!([a-Δ+i,a-Δ+i], [0,f(a-Δ+i)], color = "blue")
		plot!([a+Δ-i,a+Δ-i], [0,f(a+Δ-i)], color = "blue")
		plot!([0,a-Δ+i], [a-Δ+i,f(a-Δ+i)], color= "red")
		plot!([0,a+Δ-i], [a+Δ-i,f(a+Δ-i)], color= "red")
		scatter!([a], [a], markersize=6, color=:white, markerstrokecolor=:black)
	end every 1

	g = gif(anim, fps=30)
	center_div(g)
end

# ╔═╡ 07349c1f-e756-44c3-affe-47af6b83e16d
md"""
Las expresiones de proximidad $x \rightarrow x_0$ y $f(x) \rightarrow L$ pueden definirse matemáticamente como distancias sumamente pequeñas alrededor de $x_0$ y $L$ respectivamente: Sean $ϵ, δ$ números reales positivos sumamente pequeños (para evitar lidiar con "distancias negativas"), entonces las expresiones

$\begin{equation}
|x − x_0| < δ \qquad \land \qquad |f (x) − L| < ϵ
\end{equation}$

representan ambos conceptos de proximidad. En conjunto, estas expresiones forman un área rectangular en la que están delimitadas combinaciones $(x, f(x))$ muy cercanas al punto $(x_0, f(x_0))$. A medida que ambos valores $ϵ, δ$ se van reduciendo sin quebrantar la propiedad anterior, la aproximación va siendo cada vez mejor.

Notemos que si $δ$ fuese mayor, entonces $\textcolor{red}{|f(x) − L| < ϵ} \:$ podría no cumplirse para este caso particular (fig. derecha), de modo que tendríamos que elegir un valor $ϵ$ mayor, sin embargo ello implicaría reducir la precisión de la aproximación al límite.
"""

# ╔═╡ eb2ddf37-2196-413a-955c-7e84e82df760
let
	f(x) = x^3; x = Vector(-20:20); g(x) = x^4
	a = 0; Δ = 10
	
	anim = @animate for i in 10:0.20:20
		fig = plot(layout = grid(1,2), legend=false, size=(655,250), tickfontsize=latexticksize)
		for j in 1:2
			plot!(fig[j], x, f.(x), color = "black", line=2, 
				xticks=([0], ["\$ x_0 \$"]), yticks=([0], ["\$ L \$"]),
				right_margin=20mm, top_margin=5mm, bottom_margin=3mm) # Avoid annotation cut off → See above changes in size()
			vline!(fig[j], [-10, 10], color=:blue)
			hline!(fig[j], [-2500, 2500], color=:red)
			scatter!(fig[j], [0], [0], markersize=6, color=:white, markerstrokecolor=:black)
			annotate!(fig[j], 22, 2500, text("\$ L+\\epsilon \$", :red, :left))
			annotate!(fig[j], 22, -2500, text("\$ L-\\epsilon \$", :red, :left))
			annotate!(fig[j], 10, f(21), text("\$ x_0+\\delta \$", :blue, :bottom))
			annotate!(fig[j], -10, f(21), text("\$ x_0-\\delta \$", :blue,  :bottom))
		end
		vline!(fig[2], [i], color=:blue, line=:dash)
		vline!(fig[2], [-i], color=:blue, line=:dash)
	end every 1
	
	g = gif(anim, fps=30)
	center_div(g)
end

# ╔═╡ 759f4a8e-4fda-465c-a4bc-65f52af912ef
md"""Asumiendo que el límite existe y es $L$ (i.e. $\displaystyle\lim_{x \to x_0} f(x) = L$), el proceso de aproximación sería infinito ya que siempre podríamos encontrar una combinación de números $\epsilon$ y $\delta$ que delimiten válidamente los valores que $(x, f[x])$ pueda tomar sin llegar a ser exactamente $(x_0, f[x_0])$, lo que no sucede, por ejemplo, en funciones definidas por partes
"""


# ╔═╡ 07681221-bc0c-4545-b2d9-18f57cb072c8
let
	h(x) = x < 2 ? x^2 : x^2 + 5
	x3 = Vector(-1:0.01:3)
	replace!(x3, 2.0 => NaN) # To show jump discontinuity
	
	anim = @animate for i in 0:0.1:3
		plot(x3, h.(x3), color = "black", line=2, xticks=([2], ["\$ x_0 \$"]), 
			yticks=[], xlims=[-0.5, 3], label="f(x) by parts",
			framestyle=:origin, right_margin=12mm, tickfontsize=latexticksize)
		plot!([2,2],[0, h(2)], line=:dash, color="black")
		hline!([h(1.99)-3+i],  color=:red); hline!([h(2)+3-i],  color=:red) 
		vline!([1.5 + i/6],  color=:blue); vline!([2.5 - i/6],  color=:blue)
		scatter!([2, 2], [h(1.99), h(2)], markersize=6, color=:white, markerstrokecolor=:black, label=false)
	end
	
	g = gif(anim, fps=30)
	#center_div(g)

	text = md"""Hay una restricción para el valor $\epsilon$. Al sobrepasarla,\
	encontramos valores que no pertenecen al rango de $f(x)$"""
	
	@htl("""
	<style>
		.child{
			padding-left: 1rem;
			padding-right: 1rem;
		}
		.inline-block-child{
			display: inline-block;
		}
		.text-1{
			transform: translateY(-150%)
		}
	</style>
	
	<div align='center'>
		<div class='child inline-block-child'>$g</div>
		<div class='child inline-block-child text-1' align='left'>$text</div>
	</div>
	""")
end

# ╔═╡ b63fe541-5cf7-4d3d-9a6d-35a3f24f9788
md"""
Es por ello que se considera condición fundamental para la existencia del límite que, dado cualquier valor $\epsilon >0$, siempre pueda hallarse otro valor $\delta >0$ tal que

$\begin{equation}
\lvert{x − x_0}\rvert < δ \implies |f (x) − L| < ϵ 
\end{equation}$

Es decir, tal que *"la existencia del primer intervalo implique necesariamente la existencia del segundo"*, o por contraposición, *"si no existe el segundo intervalo, entonces tampoco existe el primero"*  ($\lnot Q \implies \lnot P$).

Además, es necesario que $x \neq x_0$ porque $f(x_0)$ podría no estar definido ($x_0$ podría no estar en el dominio de $f(x)$). Entonces, formalmente

$\begin{equation}
\boxed{\lim_{x \to x_0} f(x) = L \iff ∀ϵ > 0, ∃δ > 0 : 0 < |x − x_0| < δ \implies |f(x) − L| < ϵ}
\end{equation}$

A partir de ahora consideraremos implícito, pero no trivial, que lo anterior se cumple
$∀x ∈ Dom[f(x)]$.

### Ex. 1
Sea $f(x)=3x^2 + 2x + 1$, se desea demostrar que $\displaystyle \lim_{x \to 2}f(x)=17$. Hallar un valor $\delta$ para un $\epsilon = 0.5$, es decir, para que $\lvert(f(x) - 17)\rvert < 0.5$ 
"""

# ╔═╡ b6005254-921d-40bf-a64a-8841d32154db
let f(x) = 3*x^2 + 2*x + 1
	x = Vector(0:0.1:2.5)
	p = plot(x, f.(x), color="black", line=2, xticks=[1, 2], yticks=[10, 17], ylims=[0,19])
	hline!([16.5, 17.5], color=:red); vline!([2 - 0.0354, 2 + 0.0354], color=:blue)
	center_div(p)
end

# ╔═╡ 40d0c591-3b51-4cee-a504-5724334ab0ba
md"""
Para demostrar que el límite es $17$ teniendo $\epsilon=0.5$, es necesario hallar un valor $\delta$ tal que $|x-2| < \delta \implies |f(x)-17|<0.5$. Las condiciones establecidas en el enunciado nos dan la siguiente inecuación equivalente

$\begin{align}
\lvert{3x^2 + 2x + 1 - 17}\rvert < 0.5 & \longleftarrow |f(x) - L| < 0.5\\
\lvert{3x^2 + 2x - 16 }\rvert < 0.5\\
\lvert{3x + 8}\rvert\lvert{x - 2}\rvert< 0.5
\end{align}$

Ahora, queremos que $|x-2| < \delta$, a partir de ello podemos concluir que

$\begin{align}
|x - 2| < \delta &\implies -\delta < x - 2 < \delta \\
				& \implies -3\delta < 3x - 6 < 3\delta\\
				& \implies -3\delta + 14 < 3x + 8 < 3\delta + 14\\
				& \implies -3\delta - 14 < 3x + 8 < 3\delta + 14\\
				& \implies |3x+8| < 3\delta + 14	
\end{align}$
Ya que hasta este punto $\delta$ es un valor incógnito y variable, podemos proceder de la siguiente manera

$\begin{align}
|3x+8||x-2| &< (3\delta + 14)(\delta) < 0.5 \\
	&\implies 3\delta^2 + 14\delta - 0.5 < 0 \\
	&\implies -4.702111 < \delta < 0.035445 \text{ (approx.)}
\end{align}$

Pero ya que $\delta$ debe ser positivo, obtenemos finalmente $0 < \delta < 0.035445$, lo que implica que: $x_0 - \delta < x < x_0 + \delta$
"""

# ╔═╡ 051e6321-ed9c-4ec8-9e0f-80b43bb4c300
let
	struct MySlider 
	    range::AbstractRange
	    default::Number
	end
	function Base.show(io::IO, ::MIME"text/html", slider::MySlider)
	    print(io, """
			<input type="range" 
			min="$(first(slider.range))" 
			step="$(step(slider.range))"
			max="$(last(slider.range))"
			value="$(slider.default)"
			oninput="this.nextElementSibling.value=this.value">
			<output>$(slider.default)</output>""")
	end

	md = md"x $\in$ [2 - δ, 2 + δ]: $(@bind x1 MySlider(range(
	start = 2 - 0.035445,
	step = 0.000001,
	stop = 2 + 0.035445),
	2))"

	@htl("""<div align='center'>$md</div>""")
end

# ╔═╡ bf756de3-180e-4f7d-af07-800f6742163f
let f(x) = 3*x^2 + 2*x + 1
	p = Print("|f($x1) - 17| = ", abs(f(x1)-17))
	@htl("""<div align='center'>$p</div>""")
end

# ╔═╡ 0774fec9-eb5a-47e5-8962-a7c23381fcbb
md"""
!!! importante
	- El valor $|f(x+\delta)-17|$ no llega a ser exactamente $0.5$ debido a que $\delta$ ha sido redondeado.
	- Notemos además que $|f(x-\delta)-17| \approx 0.49246$ (muchos decimales por debajo de $0.5$). Esta asimetría se debe que $f(x)$ no es lineal.
	- De todos modos es **suficiente** que $0 < \delta < 0.035445$ para satisfacer $|f(x)-17|<0.5$
"""

# ╔═╡ 42091779-4db6-487c-98d0-7e942bceeca4
md"""
### Ex. 2
¿Cómo podríamos proceder si no tenemos inicialmente un valor $\epsilon$ específico?\
Uno de los métodos comunes incluye
- Limitar el análisis a un intervalo simétrico inicial que incluya -por supuesto- al punto de interés $(x_0, f(x_0))$
- Digamos que el intervalo es $I = [x_0 - k$, $x_0 + k]$. Dentro de $I$, $f(x)$ tiene valores máximos y mínimos como los que se muestran en el gráfico
"""

# ╔═╡ ce81de85-4dd4-4dfa-848b-0848364ee3b9
let f(x) = (x-2)^3 + 2*(x-2)^2 + 0.5
	x0_lδ = 0.85; x0_rδ=2
	x0 =(x0_lδ+x0_rδ)/2
	x = Vector(-0.05:0.05:2.5); x2 = Vector(x0_lδ:0.05:x0_rδ)	
	y1 = [f(x0_lδ) for i in x2]; y2 = [f(x0_rδ) for i in x2]
	p = plot(x, f.(x), color=:black, line=2, framestyle=:origin, size=(500, 300),
		xticks=([x0_lδ, x0, x0_rδ],["\$ x_0-k \$", "","\$ x_0+k\$"]),
		yticks=([f(0.85), f(x0), f(x0_rδ)],["\$f(x_0-k)\$", "\$ L \$", "\$f(x_0+k)\$"]), tickfontsize=15)
	annotate!(x0, 0.15, text("\$x_0\$",  :botom)) 
	plot!(x2, y1, fillrange=y2, fillalpha=0.40, c=:green)
	scatter!([x0], [f(x0)], markersize=6, color=:white, markerstrokecolor=:black)
	scatter!([x0_lδ, x0_rδ], [f(x0_lδ), f(x0_rδ)], markersize=4, color=:red, markerstrokecolor=:red)
	plot!([x0_lδ-0.1, x0_lδ-0.1], [f(x0), f(x0_lδ)], line=1.5, color=:red,
		annotations=(x0_lδ-0.1, (f(x0) + f(x0_lδ))/2, text("\$ \\epsilon^* \$", :red, :right)))
	center_div(p)
end

# ╔═╡ 684d7619-61f1-47b2-b707-a53168e33c87
md"""
- Sea $\epsilon^{*}$ el máximo valor que $\epsilon$ puede tomar en $I$.
- Si escogemos un $\epsilon \geq \epsilon^{*}$, es suficiente que $\delta = k$ para que $|x-x_0|<\delta \implies |f(x) - L| < \epsilon$
- Por otro lado, si $\epsilon < \epsilon^{*}$, entonces escoger $\delta = k$ no garantiza que $|f(x) - L| < \epsilon$. De modo que debemos encontrar una expresión genérica para hallar un valor $\delta$ en función de $\epsilon$ para este caso
- Lo primero es expresar $|f(x)-L|$ en términos que incluyan $|x-x_0|$ para luego poder utilizar algún artificio. Digamos que dicha expresión es
$\begin{align}
g(x)|x-x_0|
\end{align}$
- Sea $x^*$ el valor que maximiza $g(x)$ en $I$ (generalmente es $x_0 - k\:$ o $\:x_0 + k$ )
- Si hacemos que $\delta=g(x^*)^{-1}\epsilon$, entonces $|x-x_0|$ estará siempre por debajo de ese valor. Además, los valores de $g(x)$ estarán siempre por debajo de $g(x^*)$, es decir
$\begin{align}
	g(x)|x-x_0| &< g(x^*)g(x^*)^{-1}\epsilon \\
	|f(x)-L| &< \epsilon
\end{align}$
- Entonces, es suficiente que $\delta = \min(k, \: g(x^*)^{-1}\epsilon)$ para que se cumpla $|x-x_0|<\delta \implies |f(x)-L| < \epsilon$
- Sin embargo, un $\delta$ incluso menor también garantiza que se cumpla la condicional, es decir
$\begin{align}
	\delta \leq \min(k, \: g(x^*)^{-1}\epsilon)
\end{align}$
"""

# ╔═╡ 1989b181-071b-4884-accb-5fd028019d76
md"""
### Ex. 3
Sea $f(x) = \displaystyle{\sqrt{x^2+5}}$. Demostrar que $\displaystyle{\lim_{x \to -2}f(x)=3}$. Expresar $\delta$ en función de $\epsilon$.\

Empezaremos con expresar $|f(x)-L|$ en términos que incluyan $\textcolor{blue}{|x-x_0|=|x-(-2)|}$

$\begin{align}
|f(x)-L| &= \abs{\sqrt{x^2+5} - 3}\\
	&= \abs{\sqrt{x^2+5} - 3}
		\frac{\abs{\sqrt{x^2+5} + 3}}{\abs{\sqrt{x^2+5} + 3}}\\
	&= \frac{|x^2-4|}{\abs{\sqrt{x^2+5} + 3}}\\
	&= \frac{|x-2|}{\abs{\sqrt{x^2+5} + 3}}\textcolor{blue}{|x+2|} 🚀
\end{align}$

Restringiendo $\delta = |x+2|$ a tener como valor máximo $1$, obtenemos

$\begin{align}
 |x+2|<1 \implies -3 < x < -1
\end{align}$

Para los $x\in [-3,-1]$, la fracción a la izquierda de $|x+2|$ en 🚀 será siempre menor que $\frac{5}{\sqrt{14}+3}$ (valor máx., cuando $x=-3$).

Ahora, necesitamos que $|f(x)-L|<\epsilon$. Ello se logrará si se cumplen simultáneamente $|x+2|<1\;$ y 
$\;|x+2| < \frac{\sqrt{14}+3}{5}\epsilon \;$, ya que así

$\begin{align}
|f(x)-L| = \frac{|x-2|}{\abs{\sqrt{x^2+5} + 3}}|x+2| < 
\frac{5}{\sqrt{14}+3}\left(\frac{\sqrt{14}+3}{5}\right)\epsilon = 
\epsilon
\end{align}$

Por lo tanto, es suficiente que $\delta \leq \min\left(1,\frac{(\sqrt{14}+3)\epsilon}{5}\right)$ para que se cumpla $|x-x_0|<\delta \implies |f(x)-L|<\epsilon$.
"""

# ╔═╡ 52c206cb-d20c-4483-8e1c-b5bc5aebb7df
let
	md = md"ϵ: $(@bind ex3_ϵ1 MySlider(range(
	start = 0,
	step = 0.01,
	stop = 1.5),
	0.74))"

	center_div(md)
end

# ╔═╡ cbcae415-33d5-49eb-b018-b8a9d1ebbc08
let f(x) = sqrt(x^2 + 5)
	pick_delta(e) = minimum([e*(sqrt(14)+3)/5, 1])
	δ = round(pick_delta(ex3_ϵ1), digits=4)
	p = Print("δ = ", δ, " ⟹ |f(2 - δ) - 3| = ", round(abs(f(2-δ)-3), digits=4), 
		", |f(2 + δ) - 3| = ", round(abs(f(2+δ)-3), digits=4))
	center_div(p)
end

# ╔═╡ 1229263d-4217-4b7b-997f-48f9146df094
md"""
### Ex. 4
"""

# ╔═╡ 25d559c7-124f-468e-af85-9754036d6786
md"""
Sea $f(x)=|x^3|$. Demostrar que $\displaystyle \lim_{x \to -1}f(x)=1$, Expresar $\delta$ en función de $\epsilon$

Notemos que $|x^3|=|x|^3$. Además, por diferenia de cubos $\;a^3 - b^3 = (a-b)(a^2+ab+b^2)$ se obtiene

$\begin{align}
|f(x)-L| &= \left||x|^3 - 1\right| \\
	&= \frac{\left||x|^3 - 1\right|}{\left||x| - 1\right|}\left||x| - 1\right|\\
	&= \left| |x|^2 + |x| + 1 \right| \times \left||x| - 1\right|
\end{align}$

Y por [Reverse Triangle Inequality] 
(https://en.wikipedia.org/wiki/Triangle_inequality#Reverse_triangle_inequality) $\;\abs{|a| − |b|} \leq |a − b|\;$ tenemos

$\begin{align}
\abs{|x|-|-1|} &\leq \abs{x-(-1)} \\
\abs{|x| - 1} &\leq |x+1|
\end{align}$

Restrinjamos $|x-x_0| < 1 \implies |x-(-1)|<1 \implies -2 < x < 0$, por lo tanto

$\begin{align}
|f(x)-L| &= \left| |x|^2 + |x| + 1 \right| \times \left||x| - 1\right| \\
|f(x)-L| &< \abs{4+2+1}|x+1|
\end{align}$

Finalmente, es suficiente que $\delta \leq \min\left(1, \frac{\epsilon}{7}\right)$ para concluir la demostración.
"""

# ╔═╡ 0f374503-9eee-4ed5-a5ed-dbec6a67ef47
md"""
## Infinite limit at infinity
!!! warning
	- Si un límite es igual a $\infty$, entonces en realidad no existe. Es válido, sin embargo, expresarlo utilizando la notación de límites.
	- [Algunos comentarios](https://math.stackexchange.com/questions/127689/why-does-an-infinite-limit-not-exist)
Ejemplos:
"""

# ╔═╡ c8fc7960-689a-40d7-b006-cc5b7ebc32bc
let fig = plot(layout = grid(2,2), legend=false, size=(600,400), xticks=[], yticks=[],
	tickfontsize=latexticksize, bottom_margin=10mm)
	f(x) = x^2
	x1 = Vector(0:0.1:3.5)
	plot!(fig[1], x1, f.(x1), line=2, framestyle=:origin, right_margin=20mm)
	plot!(fig[2], x1, -f.(x1), line=2, framestyle=:origin)
	plot!(fig[3], -x1, f.(x1), line=2, framestyle=:origin, top_margin=5mm)
	plot!(fig[4], -x1, -f.(x1), line=2, framestyle=:origin)
	N = 3
	M = 3^2
	lines = [[N,M], [N,-M], [-N,M], [-N,-M]]
	position_N = [[N,0], [N,0], [-N,0], [-N,0]]
	position_M = [[0,M], [0,-M], [0,M], [0,-M]]
	align_N = repeat([:top, :bottom],2) # Strangely, it works the other way around
	align_M = [:right, :right, :left, :left,] # IDEM
	for i in 1:4
		plot!(fig[i], [lines[i][1], lines[i][1]], [0, lines[i][2]], color=:blue)
		plot!(fig[i], [0, lines[i][1]], [lines[i][2], lines[i][2]], color=:red)
		annotate!(fig[i], position_N[i][1], position_N[i][2],
			text("\$ N \$", :blue, align_N[i]))
		annotate!(fig[i], position_M[i][1], position_M[i][2],
			text("\$ M \$", :red, align_M[i]))
	end

	center_div(fig)
end

# ╔═╡ fe6fd0ed-3543-4616-af2c-ae843e4aff7f
md"""
$\begin{align}
\lim_{x \to \infty}f(x) = \infty &\iff \forall M>0, \exists N>0: x > N \implies f(x) > M \\
\lim_{x \to \infty}f(x) = -\infty &\iff \forall M<0, \exists N>0: x > N \implies f(x) < M \\
\lim_{x \to -\infty}f(x) = \infty &\iff \forall M>0, \exists N<0: x < N \implies f(x) > M \\
\lim_{x \to -\infty}f(x) = -\infty &\iff \forall M<0, \exists N<0: x < N \implies f(x) < M
\end{align}$
"""

# ╔═╡ 103dcdca-d8b3-4d1b-bdd9-cf9fd9394cd0
md"""
## Infinite limit for finite x
Ejemplo:
"""

# ╔═╡ 20c263e1-13f7-47ae-b871-00531e577a0b
let
	f(x) = 1/((x-1)^2)
	x = Vector(-1:0.01:3)
	p = plot(x, f.(x), framestyle=:origin, line=2, xticks=([1], ["\$x_0\$"]), yticks=[],
		tickfontsize=latexticksize, xlims=[], ylims=[0, 10])
	vline!([1], line=(:dash))
	δ = 0.30
	for i in [1-δ, 1+δ] plot!([i,i],[0,7], color=:blue, line=1.1) end
	hline!([7], line=(:red))
	annotate!(-1, 8, text("\$M\$", :red))
	annotate!(1-δ, 0, text("\$x_0-\\delta\$", :blue, :right, :top, :11))
	annotate!(1+δ, 0, text("\$x_0+\\delta\$", :blue, :left, :top, :11))

	center_div(p)
end

# ╔═╡ 1cc6fc2e-b397-42f3-b77d-fd29022ef27b
md"""
$\begin{align}
\lim_{x \to x_0}f(x) = \infty \iff \forall M >0, \exists \delta > 0 : 0 < |x-x_0| < \delta \implies f(x) > M
\end{align}$
"""

# ╔═╡ 6caa763d-0eaa-472e-bae4-f24bcc0cdfb7
md"""
## Finite limit at infinity
Ejemplo:
"""

# ╔═╡ 9d686422-85d6-4e66-bcfa-19c869434305
let f(x) = 1/(1+100^(-x))
	x = Vector(-0.5:0.1:2)
	p = plot(x, f.(x), framestyle=:origin, size=(350, 210), line=:2,
		xticks=[], yticks=([1], ["\$L\$"]), tickfontsize=latexticksize,
		ylims=[0,1.5], bottom_margin=3mm)
	hline!([1], line=:dash, alpha=0.8)
	for i in [0.8, 1.2] hline!([i], line=1.4, color=:blue) end
	plot!([0.5,0.5],[0,1.2], line=(1.5, :red))
	annotate!(-0.5, 1.25, text("\$L+\\epsilon\$", :blue, :bottom))
	annotate!(-0.5, 0.8, text("\$L+\\epsilon\$", :blue, :top))
	annotate!(0.5, 0, text("\$N\$", :red, :top))

	center_div(p)
end

# ╔═╡ 94de02d8-749b-4f8a-a907-07a21d71ee12
md"""
$\begin{align}
\lim_{x \to \infty}f(x)=L \iff \forall \epsilon >0, \exists N > 0: x > N \implies |f(x)-L|<\epsilon
\end{align}$
"""

# ╔═╡ a5c21756-09e4-4aad-b42b-682326ccfa99
md"""
# Limit Laws
## Sum Law
Sean los límites $\displaystyle\lim_{x \to x_0}f(x)=L_1$ y $\displaystyle\lim_{x \to x_0}g(x)=L_2$, entonces

$\begin{align}
\boxed{\lim_{x \to x_0}[f(x)+g(x)] = \lim_{x \to x_0}f(x) + \lim_{x \to x_0}g(x)}
\end{align}$

si y solo si $\forall \epsilon>0, \exists \delta >0$ tal que

$\begin{align}
0 < |x-x_0|<\delta \implies \Big|[f(x)+g(x)] - (L_1+L_2)\Big| < \epsilon
\end{align}$

**Demostración**\
Ya que $L_1$ y $L_2$ existen, entonces también existen valores $\epsilon_1, \delta_1$ y $\epsilon_2, \delta_2$ que satisfacen la definición formal de ambos límites. Ahora, hagamos que $\epsilon_1 + \epsilon_2 = \epsilon$, se cumple entonces

$\begin{align}
\forall \epsilon_1 > 0, \exists \delta_1 > 0 : 0 < |x-x_0| < \delta_1 \implies
\big|f(x)-L_1\big| < \epsilon_1 \\
\forall \epsilon_2 > 0, \exists \delta_2 > 0 : 0 < |x-x_0| < \delta_2 \implies
\big|f(x)-L_2\big| < \epsilon_2 
\end{align}$

Sea $\delta=\min(\delta_1, \delta_2)$, entonces $\delta>0$ y por lo tanto

$\begin{align}
0 < |x-x_0|<\delta \implies |f(x)-L_1| < \epsilon_1 \quad \land \quad |g(x)-L_2| < \epsilon_2
\end{align}$

!!! importante
	Ya que el antecedente y ambos consecuentes son verdaderos, es válido derivar nuevas conclusiones con estos últimos, e.g.
	-  $x<3 \implies x+2 < 5 \: \land \: x^2 < 9$
	-  $x<3 \implies x^2 + x+2 < 14$

La conclusión anterior también puede comprobarse visualmente. Digamos que $g(x)$ es la función azul. Observa cómo $|g(x)-L_2|$ es cada vez menor que $\epsilon_2$
"""

# ╔═╡ ecaadb4d-8f09-4aca-9845-c629b6c41372
let
	f(x) = 3*x^3 + 2*x^2 + 1
	g(x) = 2*x^2 + 0.65
	x = Vector(-0.5:0.01:0.5)
	x0 = 0

	anim = @animate for i in (0:0.0025:0.135)
		plot(x, f.(x), color=:red, line=2, ylims=[0, 1.8], size=(350, 300), top_margin=5mm,
			xticks=([x0],["\$x_0\$"]), yticks=([f(x0),g(x0)],["\$L_1\$", "\$L_2\$"]),
			tickfontsize=latexticksize)
		plot!(x, g.(x), color=:blue, line=2)
		scatter!([x0, x0], [f(x0), g(x0)], markersize=5, color=:white, markerstrokecolor=:black)
		# Intervals: Red function
		ϵ1 = 0.20
		δ1 = min(0.5,ϵ1/1.75)
		for v1 in [x0-δ1, x0+δ1] vline!([v1], color=:red, line=(:dot, :1.5)) end
		for h1 in [f(x0)-ϵ1, f(x0)+ϵ1] hline!([h1], color=:red, line=(:dot, :1.5)) end
		# Intervals: Blue function
		ϵ2 = 0.25
		δ2 = min(0.5,ϵ2)
		for v2 in [x0-δ2+i, x0+δ2-i] vline!([v2], color=:blue, line=:dash) end
		for h2 in [g(x0)-ϵ2, g(x0)+ϵ2] hline!([h2], color=:blue, line=:dash) end
		# Annotations
		annotate!(δ1, 2, text("\$ x_0 + \\min(\\delta_1, \\delta_2) \$", :left, :red, :10))
		annotate!(-δ1, 2, text("\$ x_0 - \\min(\\delta_1, \\delta_2) \$", :right, :red, :10))
	end

	center_div(gif(anim, fps=30))
end

# ╔═╡ 34c2aef1-93d7-4ce0-bede-fed0fbe96830
md"""
Sumando las inecuaciones (ambos consecuentes) tenemos

$\begin{align}
0 < |x - x_0| < \delta &\implies |f(x)-L_1| + |g(x)-L_2| < \epsilon_1 + \epsilon_2 = \epsilon &\\
0 < |x - x_0| < \delta &\implies |f(x)-L_1 + g(x)-L_2| < \epsilon &&\text{(Triang. Ineq.)} \\
0 < |x - x_0| < \delta &\implies \Big|[f(x) + g(x)]- (L_1 + L_2)\Big| < \epsilon && \blacksquare
\end{align}$
"""

# ╔═╡ f5d6c493-0b90-4e8d-8ce9-1934fa8bdf78
md"""
## Scalar Multiple Law
Sea $k$ un número real y $\displaystyle\lim_{x \to x_0}f(x)=L$, entonces

$\begin{equation}
\boxed{
\lim_{x \to x_0}kf(x) = k\lim_{x \to x_0}f(x)} 
\end{equation}$

si y solo si $\forall \epsilon > 0, \exists \delta>0$ tal que

$\begin{align}
0<|x-x_0|<\delta \implies \big|kf(x)-kL\big| < \epsilon
\end{align}$

**Demostración**\
Asumamos que tenemos un valor $\epsilon > 0$
- Si $k=0$, entonces la demostración es trivial ya que $|0-0|<\epsilon$.
- Si $k \neq 0$, entonces definamos $\epsilon_2 = \displaystyle \frac{\epsilon}{|k|} > 0$. $\epsilon_2$ podría ser mayor o menor que $\epsilon$, dependiendo del valor de $k$.

Ahora, si $L$ existe, entonces podemos hacer que $\forall \epsilon_2>0, \exists \delta > 0$ tal que

$\begin{align}
0<|x-x_0|<\delta  &\implies |f(x)-L| < \epsilon_2 = \frac{\epsilon}{|k|} &\\
	& \implies |k||f(x)-L| < \epsilon &\\
	& \implies |kf(x)-kL| < \epsilon  &\blacksquare
\end{align}$
"""

# ╔═╡ 8807d000-a3e7-4c42-a633-74b650554990
md"""
## Difference Law
Asumiendo que los límites existen, entonces

$\begin{equation}
\lim_{x \to 0}f(x)-g(x) = \lim_{x \to 0}f(x)+(-1)g(x)
\end{equation}$

Utilizando *Sum Law* & *Scalar Multiple Law*

$\begin{equation}
\lim_{x \to 0}f(x)-g(x) = \lim_{x \to 0}f(x)+\lim_{x \to 0}(-1)g(x)
\end{equation}$
$\begin{equation}
\boxed{\lim_{x \to 0}f(x)-g(x) = \lim_{x \to 0}f(x)-\lim_{x \to 0}g(x)} \qquad \blacksquare
\end{equation}$
"""

# ╔═╡ 4cfe9484-a471-49e5-9825-f88fc4c0785c
md"""
## Product Law
Sean los límites $\displaystyle\lim_{x \to x_0}f(x)=L_1$ y $\displaystyle\lim_{x \to x_0}g(x)=L_2$, entonces

$\begin{align}
\boxed{\lim_{x \to x_0}[f(x)g(x)] = \lim_{x \to x_0}f(x) \times \lim_{x \to x_0}g(x)}
\end{align}$

si y solo si $\forall\epsilon>0,\exists\delta>0$ tal que

$\begin{align}
0 < |x - x_0| < \delta \implies |f(x)g(x)-L_{1}L_{2}|<\epsilon
\end{align}$

**Demostración**\
Son necesarios dos artificios. Primero notemos que

$\begin{align}
f(x)g(x)-L_{1}L_{2} &= 
	f(x)g(x) - L_{1}L_{2} + L_{1}g(x) - L_{1}g(x) + L_{2}f(x) - L_{2}f(x) + L_{1}L_{2} - L_{1}L_{2} \\
	&= L_{1}g(x) - L_{1}L_{2} + L_{2}f(x) - L_{2}L_{1} + f(x)g(x) - L_{2}f(x) - L_{1}g(x) + L_{1}L_{2} \\
	&= L_{1}(g(x)-L_{2}) + L_{2}(f(x)-L_{1}) + (f(x)-L_{1})(g(x)-L_{2})
\end{align}$

Ya que la última línea del artificio anterior tiene 3 términos, será necesario definir cada uno de ellos en función de $\epsilon$ para poder despejarlos. Segundo, definamos

$\begin{align}
\epsilon_{4}=\frac{\epsilon}{3(1+|L_{1}|)}, \quad 
	\epsilon_{3} = \frac{\epsilon}{3(1+|L_{2}|)} \quad y \quad 
	\epsilon_{2} = \sqrt{\frac{\epsilon}{3}}
\end{align}$

Los números 3 presentes en cada denominador ayudarán a restringir la variación de cada término al final del primer artificio a $\frac{1}{3}$ del valor del $\epsilon$ original. Los detalles tomarán sentido más adelante.

Asumamos que se nos provee un $\epsilon>0$, entonces $\epsilon_{2},\epsilon_{3},\epsilon_{4}>0$. Sabiendo además que $L_{1}$ y $L_{2}$ existen, es posible hacer que

$\begin{align}
\forall\epsilon_{2},\exists\delta_{1}>0:0<|x-x_{0}|<\delta_{1} \implies |f(x)-L_{1}|<\epsilon_{2} \\
\forall\epsilon_{3},\exists\delta_{3}>0:0<|x-x_{0}|<\delta_{3} \implies |f(x)-L_{1}|<\epsilon_{3} \\
\forall\epsilon_{2},\exists\delta_{2}>0:0<|x-x_{0}|<\delta_{2} \implies |f(x)-L_{2}|<\epsilon_{2} \\
\forall\epsilon_{4},\exists\delta_{4}>0:0<|x-x_{0}|<\delta_{4} \implies |f(x)-L_{2}|<\epsilon_{4}
\end{align}$

Ahora, sea $\delta=\min(\delta_{1},\delta_{2},\delta_{3},\delta_{4})$, entonces $\delta>0$ y por lo tanto $0<|x-x_{0}|<\delta$ implica los consecuentes de las últimas 4 condicionales.

Aplicando *Triangle Inequality* en la última línea del primer artificio, tenemos que

$\begin{align}
|f(x)g(x)-L_{1}L_{2}| &\leq |L_1||g(x)-L_2| + |L_2||f(x)-L_1| + |f(x)-L_1||g(x)-L_2| \\
	&< |L_1|\epsilon_{4} + |L_2|\epsilon_{3} + \epsilon_{2}\epsilon_{2} \\
	&< |L_1|\frac{\epsilon}{3(1+|L_1|)} + |L_2|\frac{\epsilon}{3(1+|L_2|)} + 
		\sqrt{\frac{\epsilon}{3}}\sqrt{\frac{\epsilon}{3}}
\end{align}$

Y ya que siempre se cumple $\frac{a}{1+a}<1$ (para $a>0$), finalmente obtenemos

$\begin{align}
|f(x)g(x)-L_{1}L_{2}| < \frac{\epsilon}{3} + \frac{\epsilon}{3} + \frac{\epsilon}{3} = \epsilon \quad\quad \blacksquare
\end{align}$
"""

# ╔═╡ e8b0c960-e0e9-4d0b-8e09-86d016047f8f
md"""
## Reciprocal Law
Sean el límite $\displaystyle\lim_{x \to x_0}f(x)=L$, entonces

$\begin{align}
\boxed{\lim_{x \to x_0}\frac{1}{f(x)} = \frac{1}{\displaystyle\lim_{x \to x_0}f(x)}}
\end{align}$

si y solo si $\forall\epsilon>0,\exists\delta>0$ tal que

$\begin{align}
0 < |x - x_0| < \delta \implies \abs{\frac{1}{f(x)} - \frac{1}{L}}<\epsilon
\end{align}$

**Demostración**\
Definamos

$\begin{align}
\epsilon_{2} = \frac{|L|}{2} \quad y \quad \epsilon_{3} = \frac{L^{2}\epsilon}{2}
\end{align}$

Asumiendo que se provee un $\epsilon>0$, entonces $\epsilon_{2},\epsilon_{3}>0$, y sabiendo que $L$ existe, podemos hacer que

$\begin{align}
\forall\epsilon_{2}, \exists\delta_{2} : 0 < |x-x_0|<\delta_2 \implies |f(x)-L|<\epsilon_{2} \\
\forall\epsilon_{3}, \exists\delta_{3} : 0 < |x-x_0|<\delta_3 \implies |f(x)-L|<\epsilon_{3}
\end{align}$

Sea $\delta=\min(\delta_2,\delta_3) \implies \delta>0$, y por lo tanto $0<|x-x_0|<\delta$ implica los consecuentes de las 2 condicioneales anteriores. Ahora, por *Reverse Triangle Inequality* tenemos

$\begin{align}
0 &< \big||f(x)|-|L|\big| \leq |f(x)-L| \\
0 &< \big||f(x)|-|L|\big| < \epsilon_2 = \frac{|L|}{2} \\
-\frac{|L|}{2} &< |f(x)|-|L| < \frac{L}{2} \\
\frac{|L|}{2} &< |f(x)|< 3\frac{L}{2}
\end{align}$

Tomando los valores recíprocos del 1er y 2do término de la última inecuación tenemos

$\begin{align}
\frac{1}{f(x)} < \frac{2}{|L|}
\end{align}$

Ahora, notemos que

$\begin{align}
\frac{1}{f(x)} - \frac{1}{L} &= \frac{1}{f(x)}\frac{1}{L}(L-f(x)) \\
\abs{\frac{1}{f(x)} - \frac{1}{L}} &= \frac{1}{|f(x)|}\frac{1}{|L|}|L-f(x)| \\
	&= \frac{1}{|f(x)|}\frac{1}{|L|}|f(x)-L| \\
	&< \frac{2}{|L|}\frac{1}{|L|}\epsilon_3 = \frac{2}{|L|}\frac{1}{|L|}\frac{L^{2}\epsilon}{2} = \epsilon \quad\quad \blacksquare
\end{align}$
"""

# ╔═╡ 6e8c04e9-d8ec-48aa-a15f-2bcebd938541
md"""
## Quotient Law

Sean los límites $\displaystyle\lim_{x \to x_0}f(x)=L_1$ y $\displaystyle\lim_{x \to x_0}g(x)=L_2$, entonces

$\begin{align}
\lim_{x \to x_0}\frac{f(x)}{g(x)} = \lim_{x \to x_0}f(x)\frac{1}{g(x)}
\end{align}$

Aplicando *Product Law* y *Reciprocal Law*

$\begin{align}
\lim_{x \to x_0}\frac{f(x)}{g(x)} = \lim_{x \to x_0}f(x)\lim_{x \to x_0}\frac{1}{g(x)} \\
\boxed{\lim_{x \to x_0}\frac{f(x)}{g(x)} = \frac{\displaystyle\lim_{x \to x_0}f(x)}
	{\displaystyle\lim_{x \to x_0}g(x)}} \quad\quad \blacksquare
\end{align}$
"""

# ╔═╡ e7acf793-29a8-4bd6-a01d-ff7f47572036
md"""
## Squeeze Theorem
"""

# ╔═╡ 98121e66-e9a1-4e2c-aef1-ac31b8ef5ed1
let
	f(x) = x^2
	g(x) = (x^2)*sin(10/x)
	h(x) = -(1.5x^2)
	x = Vector(-1:0.001:1)
	x2 = Vector(-0.25:0.001:0.25)
	replace!(x, 0 => NaN)
	replace!(x2, 0 => NaN)
	
	fig = plot(layout=grid(1,2), size=(600, 225), framestyle=:none, xticks=[0], yticks=[])
	# Left
	plot!(fig[1], x, g.(x), framestyle=:origin, line=(1.5, :red))
	plot!(fig[1], x, f.(x), line=(1.5, :blue))
	plot!(fig[1], x, h.(x), line=(1.5, :green))
	annotate!(fig[1], 0,-0.20,text("\$ x_0 \$"))
	# Right
	plot!(fig[2], x2, g.(x2), line=(1, :red))
	plot!(fig[2], x2, f.(x2), line=(1.5, :blue))
	plot!(fig[2], x2, h.(x2), line=(1.5, :green))
	hline!(fig[2], [-0.02, 0.02], line=(1, :black, :dash))
	vline!(fig[2], [-0.1414, 0.1414], line=(1, :blue, :dash))
	vline!(fig[2], [-0.1155, 0.1155], line=(1, :green, :dash))

	center_div(fig)
end

# ╔═╡ 9b7414a7-91bb-4f10-8d49-bb4ca11540b8
md"""
Sean $f(x), g(x), h(x)$ funciones definidas en un intervalo $I$, exceptuando quizá en un punto $x_0$. Para todo $x\in I : x \neq x_0$ se cumple

$\begin{align}
\boxed{f(x)\leq g(x) \leq h(x) \; \land \; \lim_{x \to x_0}f(x) = \lim_{x \to x_0}h(x) = L \implies \lim_{x \to x_0}g(x) = L}
\end{align}$

**Demostración**\
Como los límites de $f(x)$ y $h(x)$ existen, entonces también existen valores $\epsilon_1, \delta_1, \epsilon_2, \delta_2$ que satisfacen sus definiciones formales. Haciendo que $\epsilon=\epsilon_1=\epsilon_2$ y $\delta=\min(\delta_1, \delta_2)$, podemos concluir que $\forall\epsilon>0,\exists\delta>0$ tal que

$\begin{align}
\forall x \in I, 0 < |x-x_0|<\delta &\implies |f(x)-L|<\epsilon \land |h(x)-L|<\epsilon \\
	&\implies -\epsilon + L < f(x) \leq g(x) \leq h(x) < \epsilon + L \\
	&\implies -\epsilon < g(x) - L < \epsilon \\
	&\implies |g(x) - L| < \epsilon \quad\quad \blacksquare
\end{align}$

i.e. el límite para $g(x)$ existe y es $L$.
"""

# ╔═╡ 4e6f285e-9487-4487-99e9-ee0738f8bdad
md"""
### Ex. 1
Demostrar que $\displaystyle\lim_{x \to 0}\sin(x)=0$
"""

# ╔═╡ 3cfbb2da-841f-49c6-901a-a3dee69bc5f6
let
	α = π/6
	pix = 40 # right offset
	p = plot(circle(0,0,1), size=(250+pix,250), framestyle=:origin, 
		xticks=[], yticks=[], right_margin=(pix)px)
	plot!([0,cos(α)], [0,sin(α)], line=1.5)
	plot!([0,cos(α)], [0,-sin(α)], line=1.5)
	plot!([cos(α),cos(α)], [0,sin(α)], line=(1.5, :blue))
	plot!(arc(0,0,0,α,1), line=(1.5, :red))
	annotate!(cos(α),0.2, text("\$ \\sin(x) \$", :right, :12, :blue))
	annotate!(1,0.4, text("\$ x \$", :left, :12, :red))

	math = md"""
	**Por Squeeze Theorem:**\
	($x$ está en radianes)\
	$\begin{align}
	|\sin(x)| \leq |x| &\implies -|x| \leq \sin(x) \leq |x| \\
	\lim_{x \to 0}-|x|=\lim_{x \to 0}|x|=0 &\implies \lim_{x \to 0}\sin(x)=0
	\end{align}$
	"""
	
	@htl("""
	<style>
		.child{
			padding-left: 1rem;
			padding-right: 1rem;
		}
		.inline-block-child{
			display: inline-block;
		}
		.math-1{
			transform: translateY(-50%)
		}
	</style>
	
	<div align='center'>
		<div class='child inline-block-child'>$p</div>
		<div class='child inline-block-child math-1' align='left'>$math</div>
	</div>
	""")
end

# ╔═╡ 60631ec6-c73d-40ea-a522-d0d4340e0fdf
md"""
### Ex. 2
Demostrar que $\displaystyle\lim_{x \to 0}\cos(x)=1$
"""

# ╔═╡ 5ba353b4-cede-4473-9224-ee0419d8cb79
let
	α = π/6
	pix = 40 # right offset
	p = plot(circle(0,0,1), size=(250+pix,250), framestyle=:origin, xticks=[], yticks=[], right_margin=(pix)px)
	plot!([0,cos(α)], [0,sin(α)], line=1.5)
	plot!([0,cos(α)], [0,-sin(α)], line=1.5)
	plot!([cos(α),cos(α)], [0,sin(α)], line=(1, :blue))
	plot!([0,cos(α)], [0,0], line=(1.5, :blue))
	annotate!(cos(α),-0.1, text("\$ \\cos(x) \$", :right, :12, :blue))
	
	math = md"""	
	Se sabe que $-1 \leq \cos(x) \leq 1 \; \land \; 1-\cos^{2}(x)=\sin^{2}(x)$, entonces
	
	$\begin{align}
	x \to 0 &\implies 0 \leq \cos(x) \leq 1 \\
		&\implies 0 \leq 1 - \cos(x) = \frac{1 - \cos^{2}(x)}{1+\cos(x)} \leq 1 - \cos^{2}(x) \\
		&\implies 0 \leq 1 - \cos(x) \leq \sin^{2}(x)
	\end{align}$

	Además, $\displaystyle\lim_{x \to 0}0 = \lim_{x \to 0}\sin(x)=0 \implies \lim_{x \to 0}\sin^{2}(x)=0$

	$\begin{align}
		&\implies \lim_{x \to 0}1-\cos(x) = 0 \\
		&\implies \lim_{x \to 0}1 = \lim_{x \to 0}\cos(x) \\
		&\implies \lim_{x \to 0}\cos(x) = 1
	\end{align}$
	"""
	
	@htl("""
	<style>
		.child{
			padding-left: 1rem;
			padding-right: 1rem;
		}
		.inline-block-child{
			display: inline-block;
		}
	</style>
	
	<div align='center'>
		<div class='child inline-block-child'>$p</div>
		<div class='child inline-block-child' align='left'>$math</div>
	</div>
	""")
end

# ╔═╡ 7ac5267f-db3f-43ae-a970-c84a7bc73458
md"""
### Ex. 3
Demostrar que $\displaystyle\lim_{x \to a}\sin(x)=\sin(a)$

$\begin{align}
|f(x) - L| &= |\sin(x)-\sin(a)| \\
	&= \abs{2\sin\left(\frac{x-a}{2}\right) \cos\left(\frac{x+a}{2}\right)} \\
	&\leq 2\abs{\frac{x-a}{2}}(1) \quad (\text{ya que} |\sin(x)| \leq |x| \land \cos(\theta) \leq 1) \\
	&\leq |x - a|
\end{align}$

Entonces es suficiente que $|x-a|<\delta=\epsilon$ para que $|\sin(x)-\sin(a)| < \epsilon$
"""

# ╔═╡ ba441314-8209-43e4-80a2-1d6edbe215ba
md"""
### Ex. 4
Demostrar que $\displaystyle\lim_{x \to a}\cos(x)=\cos(a)$

$\begin{align}
|f(x) - L| &= |\cos(x)-\cos(a)| \\
	&= \abs{-2\sin\left(\frac{x+a}{2}\right) \sin\left(\frac{x-a}{2}\right)} \\
	&\leq 2(1)\abs{\frac{x-a}{2}} \quad (\text{ya que} |\sin(x)| \leq |x| \land \sin(\theta) \leq 1) \\
	&\leq |x - a|
\end{align}$

Entonces es suficiente que $|x-a|<\delta=\epsilon$ para que $|\cos(x)-\cos(a)| < \epsilon$
"""

# ╔═╡ 3fd3102d-f27a-4a65-a540-f2f19c6804c9
md"""
### Ex. 5
Hallar $\displaystyle\lim_{x \to 0}\frac{\sin(x)}{x}$
"""

# ╔═╡ 366553b0-0f28-4e3c-a533-5a73a3a23d79
let
	x = Vector(-20:0.1:20)
	replace!(x, 0 => NaN)
	f(x) = sin(x)/x
	
	fig = plot(layout = grid(1,2), size=(550, 200),xticks=[], yticks=[])
	# Left
	plot!(fig[1], x, f.(x), line=2, 
		framestyle=:origin, xticks=[i for i in -20:10:20], yticks=([1]), ylims=[-1,2])
	# Right
	α = π/4.5
	plot!(fig[2], arc(0,0,0,π,1), framestyle=:origin, ylims=[-0.25,1.25])
	plot!(fig[2], [cos(α),cos(α)], [0,sin(α)], line=(1.5, :blue))
	plot!(fig[2], [0,1], [0,tan(α)])
	plot!(fig[2], [1,1], [0,tan(α)], line=(1.5, :blue))
	plot!(fig[2], arc(0,0,0,α,1), line=(2, :red))
	plot!(fig[2], arc(0,0,0,α,0.25), line=(2, :red))
	annotate!(fig[2], 0, 0, text("\$O\$", :top))
	annotate!(fig[2], cos(α), 0, text("\$B\$", :top, :blue))
	annotate!(fig[2], 1, 0, text("\$A\$", :top, :blue))
	annotate!(fig[2], cos(α) - 0.1, sin(α) + 0.04, text("\$C\$", :right, :blue))
	annotate!(fig[2], 1, tan(α), text("\$D\$", :bottom, :blue))
	annotate!(fig[2], 0.3, 0.05, text("\$x\$", :bottom, :left, :red))
	
	center_div(fig)
end

# ╔═╡ 9497f822-c6bd-479e-a1ec-8f4c0261a271
md"""
De la gráfica podemos notar que el límite parece ser $L=1$. Notemos además que Área[OAD] > Área[OAC] > Área[ABC]

$\begin{align}
\text{Área[OAD]} &= \frac{1}{2}(\overline{OA})(\overline{AD}) = \frac{1}{2}(1)|\tan(x)| \\
x \to 0 \implies \text{Área[OAC]} &\approx \frac{1}{2}(1)|x| \\
\text{Área[OBC]} &= \frac{1}{2}|\sin(x)||\cos(x)|
\end{align}$

Dividiendo cada expresión entre $\sin(x)$ y aplicando límites obtenemos

$\begin{align}
\lim_{x \to 0}\frac{1}{\cos(x)} 
\geq \lim_{x \to 0}\abs{\frac{x}{\sin(x)}}
\geq \lim_{x \to 0}\cos(x)
\end{align}$

(utilizamos $\geq$ porque a medida que $x \to 0$, los límites podrían ser iguales). Ahora, sabemos que $\displaystyle\lim_{x \to 0}\cos(x)=1$, entonces por *Squeeze Theorem* y *Quotient Law* tenemos

$\begin{align}
1 \geq \lim_{x \to 0}\abs{\frac{x}{\sin(x)}} \geq 1 &\implies \lim_{x \to 0}\abs{\frac{x}{\sin(x)}} = 1 \\
	&\implies \lim_{x \to 0}|x| = \lim_{x \to 0}|\sin(x)| \\
	&\implies \lim_{x \to 0}\abs{\frac{\sin(x)}{x}} = 1
\end{align}$

Pero cuando $x \to 0$, tanto $x$ como $\sin(x)$ tienen el mismo sigo, de modo que se cumple finalmente

$\begin{align}
\lim_{x \to 0}\frac{\sin(x)}{x} = 1
\end{align}$
"""

# ╔═╡ 944b2cbc-c2af-44be-9244-3162fa3dbfb5
md"""
### Ex. 6
Considera una torta circular de radio R. Una porción con ángulo central $\theta$ es cortada y ubicada en un plato circular de diámetro $D$ (diámetro mínimo para contener la porción en su totalidad). Demostrar que $D$ varía con respecto a $\theta$ de la siguiente forma:

$D\left( \theta \right) = 
\begin{cases}
0 & \theta = 0 \\
R\sec(\frac{\theta}{2}) & 0 < \theta \leq \frac{\pi}{2} \\
2R\sin(\frac{\theta}{2}) & \frac{\pi}{2} < \theta \leq \pi \\
2R & \pi < \theta \leq 2\pi 
\end{cases}$

Demostrar además que $\displaystyle\lim_{\theta \to 0}R\sec\left(\frac{\theta}{2}\right) = R$.

**Cuadrante I**\
El área circular mínima para el plato se obtiene al circunscribir la porción de torta tomando 3 puntos tangeciales: primer corte, segundo corte y origen. Para comprobar esto hay que observar que si redujéramos la circunferencia propuesta, alguno de los puntos tangenciales quedaría fuera
"""

# ╔═╡ aa252a99-a6d7-4591-a3b0-480b98c76832
let
	R = 1
	θ = [π/6, π/3, π/2]
	fig = plot(layout=grid(1,3), size=(750, 250), framestyle=:origin, xticks=[], yticks=[], 
		xlims=[-R,R+0.2], ylims=[-R,R+0.2])
	
	for i in 1:3
		plot!(fig[i], circle(0,0,R), line=1.25) # Pie
		plot!(fig[i], [0,R*cos(θ[i])], [0, R*sin(θ[i])], line=(:tomato, 1.5)) # 2nd cut
		plot!(fig[i], circle(R/2, R*tan(θ[i]/2)/2, R*sec(θ[i]/2)/2), line=(1.5, :red)) # Plate
		plot!(fig[i], sector(0,0,0,θ[i],R), line=0.2, c=:red, fillalpha=0.30) # Portion
		plot!(fig[i], [0, R], [0, R*tan(θ[i]/2)], line=(1.25, :dash, :red)) # θ/2 projection
		plot!(fig[i], [R, R], [0, R*tan(θ[i]/2)], line=(1.5, :blue)) # Tangent of θ/2
	end

	center_div(fig)
end

# ╔═╡ 89d33617-4ecf-4721-b8a1-c4d9631ba874
md"""
La proyección de la línea que divide a la porción en 2 mitades representa el diámetro del plato, ello porque su circunferencia es creada a partir de una simetría (ver *posición del plato* abajo). La línea vertical azul es $R\tan(\frac{\theta}{2})$. Este diámetro $D$ es entonces

$\begin{align}
D(\theta) &= \sqrt{R^2 + \left( R\tan\left(\frac{\theta}{2}\right)\right)^2} 
	= R\sqrt{1 + \tan^{2}\left(\frac{\theta}{2}\right)} \\
	&= R\sqrt{\frac{\cos^{2}(\frac{\theta}{2})}{\cos^{2}(\frac{\theta}{2})} 
		+ \frac{\sin^{2}(\frac{\theta}{2})}{\cos^{2}(\frac{\theta}{2})}} 
		= R\frac{1}{\cos(\frac{\theta}{2})} = R\sec\left(\frac{\theta}{2}\right)
\end{align}$

**Posición del plato**
"""

# ╔═╡ 9b43eba7-9823-48b1-904e-d8051a5414af
let
	R = 1
	θ = π/3
	p = plot(arc(0,0,0,π/2,R), framestyle=:origin, size=(200, 220), xticks=[], yticks=[]) # Pie Q=I
	R_plate = R*sec(θ/2)/2
	plot!(circle(R/2, R*tan(θ/2)/2, R_plate), line=(1.5, :red)) # Plate
	plot!([0, R*cos(θ)], [0, R*sin(θ)], line=(:tomato, 1.5)) # 2nd cut
	plot!(sector(0,0,0,θ,R), c=:red, fillalpha=0.2, line=0.2) # Portion
	plot!([0, R], [0, R*tan(θ/2)], line=(1.25, :dash, :red)) # θ/2 projection
	x_left = R/2-R_plate
	Δy = R*tan(θ/2)/2
	plot!([x_left,x_left+2*R_plate], [Δy,Δy], line=:red)
	plot!([R/2,R/2], [0,Δy], line=:red)
	annotate!(R/2+0.05, 0.15, text("\$ \\Delta y\$", 11, :red, :left))
	annotate!(0.20, 0.23, text("\$ k \$", 11, :red, :left))

	math = md"""
	Tanto el punto tangencial de la izquierda cuanto el de la derecha\
	son constantes en este cuadrante, por lo tanto, la posición en $x$ \
	está determinada por $\frac{R}{2}$. En $y$ hay que notar

	$\begin{align}
	k\cos\left(\frac{\theta}{2}\right) = \frac{R}{2} &\implies k = \frac{R}{2\cos(\frac{\theta}{2})} \\
	\Delta y = k\sin\left(\frac{\theta}{2}\right)
		&\implies \Delta y = \frac{R}{2}\tan\left(\frac{\theta}{2}\right)
	\end{align}$
	"""
	
	@htl("""
	<style>
		.child{
			padding-left: 1rem;
			padding-right: 1rem;
		}
		.inline-block-child{
			display: inline-block;
		}
	</style>
	
	<div align='center'>
		<div class='child inline-block-child'>$p</div>
		<div class='child inline-block-child' align='left'>$math</div>
	</div>
	""")
	
end

# ╔═╡ 153abed0-5370-4246-9f3a-23c491f7271f
md"""
**Cuadrante II**\
Notemos que ahora el origen $O$ deja de ser un punto tangencial, y que el diámetro mínimo del plato estará determinado por ambos puntos de corte.
"""

# ╔═╡ f87e088b-44ab-447a-b7c8-4d1d791eefc5
let
	R = 1
	θ = [4π/6, 5π/6, π]
	fig = plot(layout=grid(1,3), size=(740, 250), framestyle=:origin, xticks=[], yticks=[], 
		xlims=[-R,R+0.2], ylims=[-R,R+0.25])
	
	for i in 1:3
		plot!(fig[i], circle(0,0,R), line=1.25) # Pie
		plot!(fig[i], [0,R*cos(θ[i])], [0, R*sin(θ[i])], line=(:tomato, 1.5)) # 2nd cut
		plot!(fig[i], circle((R*cos(θ[i]) + R)/2, R*sin(θ[i])/2, 2*R*sin(θ[i]/2)/2), line=(1.5, :red)) # Plate
		plot!(fig[i], sector(0,0,0,θ[i],R), line=0.2, c=:red, fillalpha=0.30) # Portion
		plot!(fig[i], [0, R*cos(θ[i]/2)], [0, R*sin(θ[i]/2)], line=(1.25, :dash)) # θ/2 projection
		plot!(fig[i], [R,R*cos(θ[i])], [0,R*sin(θ[i])], line=(1.25, :red, :dash))
	end

	center_div(fig)
end

# ╔═╡ 2fe7bbdf-2fb3-4544-987e-f74c99ea938d
md"""
$\begin{align}
D^2 &= (-R\cos(\theta) + R)^2 + (R\sin(\theta))^2 \\
	&= (R(1-cos(\theta)))^2 + R^2\sin^{2}(\theta) \\
	&= R^2 - 2R^2\cos(\theta) + R^2\cos^2(\theta) + R^2\sin^2(\theta) \\
	&= 2R^2(1-\cos(\theta)) \\
	&= 4R^2\frac{(1-\cos(\theta))}{2}, \quad \text{pero} \quad \sin^2(x)=\frac{1-\cos(2x)}{2} \\
	&= 4R^2\sin^2\left(\frac{\theta}{2}\right) \\
D &= 2R\sin\left(\frac{\theta}{2}\right)
\end{align}$

**Posición del plato**
"""

# ╔═╡ a2019faf-6fdf-4924-a0da-982892cde04b
let
	R = 1
	θ = 4π/6
	p = plot(circle(0,0,R), framestyle=:origin, size=(260, 270), xticks=[], yticks=[]) # Pie
	R_plate = 2*R*sin(θ/2)/2
	plot!(circle((R*cos(θ) + R)/2, R*sin(θ)/2, R_plate), line=(1.5, :red)) # Plate
	plot!([0, R*cos(θ)], [0, R*sin(θ)], line=(:tomato, 1.5)) # 2nd cut
	plot!(sector(0,0,0,θ,R), c=:red, fillalpha=0.2, line=0.2) # Portion
	plot!([0, R*cos(θ/2)], [0, R*sin(θ/2)], line=(1.25, :dash)) # θ/2 projection
	x_left = R/2-R_plate
	Δy = R*sin(θ)/2
	Δx = R*cos(θ/2)*cos(θ/2)
	plot!([R,R*cos(θ)], [0,sin(θ)], line=(:red, :dash)) # Half of plate 1
	plot!([-(R_plate-Δx),(R_plate+Δx)], [Δy,Δy], line=(:red)) # Half of plate 2
	plot!([Δx,Δx],[0,Δy], line=:red) # Δy
	annotate!(0.40, 0.20, text("\$ \\Delta y\$", 10, :red))
	annotate!(0.08, 0.35, text("\$ k \$", 11, :red))
	annotate!(0.65, 0.35, text("\$ l \$", 11, :red))
	annotate!(0.17, -0.10, text("\$ \\Delta x \$", 10, :red))
	annotate!(0.50, -0.15, text("\$ R \$", 10))

	math = md"""
	$\begin{align}
	R &= k.\cos\left(\frac{\theta}{2}\right) + 
		l.\cos\left(90 - \frac{\theta}{2}\right) \\
	R &= k.\cos\left(\frac{\theta}{2}\right) + 
		R\sin\left(\frac{\theta}{2}\right)\cos\left(90 - \frac{\theta}{2}\right) \\
	R &= k.\cos\left(\frac{\theta}{2}\right) + 
		R\sin\left(\frac{\theta}{2}\right)\sin\left(\frac{\theta}{2}\right)\\
	R\cos^2\left(\frac{\theta}{2}\right) &= k.\cos\left(\frac{\theta}{2}\right) \implies 
		k = R\cos\left(\frac{\theta}{2}\right) \\
	\Delta x &= R\cos\left(\frac{\theta}{2}\right)\cos\left(\frac{\theta}{2}\right) \\
	\Delta y &= R\cos\left(\frac{\theta}{2}\right)\sin\left(\frac{\theta}{2}\right) =
		R\frac{\sin(\theta)}{2}
	\end{align}$
	
	La última igualdad es resultado de la identidad $\sin(2x)=2\sin(x)\cos(x)$
	"""
	
	@htl("""
	<style>
		.child{
			padding-left: 1rem;
			padding-right: 1rem;
		}
		.inline-block-child{
			display: inline-block;
		}
	</style>
	
	<div align='center'>
		<div class='child inline-block-child'>$p</div>
		<div class='child inline-block-child' align='left'>$math</div>
	</div>
	""")
	
end

# ╔═╡ 258c0007-0600-405d-a6fd-150ec2ea2542
md"""
**Cuadrantes III y IV**\
El diámetro y la posición del plato son los mismos que cuando $\theta = \pi$ en el último cuadrante, y son constantes hasta $\theta = 2\pi$.

**Límite:**

$\begin{align}
\lim_{\theta \to 0}R\sec\left(\frac{\theta}{2}\right) 
	&= R\lim_{\theta \to 0}\sec\left(\frac{\theta}{2}\right) \\
	&= R\frac{1}{\displaystyle\lim_{\theta \to 0}\cos\left(\frac{\theta}{2}\right)} \\
	&= R\frac{1}{\cos(0)} = R
\end{align}$

"""

# ╔═╡ dad86c6c-c59b-49b4-ad99-83bdfb88abe0
md"""
## 🔨 Composition Law
Sean los límites $\displaystyle\lim_{x \to c}g(x) = M$ y $\displaystyle\lim_{u \to M}f(u)=f(M)$ (se utiliza $u$ para distinguir que es el input de $f$ ), entonces

$\begin{align}
\boxed{\lim_{x \to c}f(g(x)) = f(M)}
\end{align}$

o equivalentemente

$\begin{align}
\boxed{\lim_{x \to c}f(g(x)) = f(\lim_{x \to c}g(x))}
\end{align}$

si y solo si $\forall\epsilon>0, \exists\delta>0$ tal que

$\begin{align}
0 < |x - c| < \delta \implies |f(g(x)) - f(M)| < \epsilon
\end{align}$

**Demostración**\
Ya que $\displaystyle\lim_{u \to M}f(u)=f(M)$ (i.e. la función es continua en $M$), entonces $\forall  \epsilon>0, \exists \delta_1>0$ tal que

$\begin{align}
0 < |u - M| < \delta_1 \implies |f(u) - f(M)| < \epsilon
\end{align}$

Sin embargo, notemos que cuando $u=M \implies f(u) = f(M) \implies |f(u) - f(M)|=0$, de modo que el antecedente de la implicación anterior varía para incluir al cero

$\begin{align}
0 \leq |u - M| < \delta_1 \implies |f(u) - f(M)| < \epsilon
\end{align}$

Ahora definamos $\epsilon_{2}=\delta_{1}$. Ya que $\displaystyle\lim_{x \to c}g(x) = M$ entonces $\forall\epsilon_2, \exists\delta$ tal que

$\begin{align}
0 < |x - c| < \delta \implies |g(x) - M| < \epsilon_2
\end{align}$

Definamos además $u=g(x)$. Obtenemos finalmente 

$\begin{align}
0 < |x - c| < \delta \implies 0 \leq |u - M| < \delta_1 \implies |f(g(x)) - f(M)| < \epsilon
\end{align}$
"""

# ╔═╡ 48abcbab-bc05-4f45-88a2-9637a2d1e7c7
md"""
## 🔨 Inverse Law
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Latexify = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.3"
LaTeXStrings = "~1.3.0"
Latexify = "~0.15.13"
Plots = "~1.26.0"
PlutoUI = "~0.7.37"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c9a6160317d1abe9c44b3beb367fd448117679ca"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.13.0"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "12fc73e5e0af68ad3137b886e3f7c1eacfca2640"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.17.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "96b0bc6c52df76506efc8a441c6cf1adcb1babc4"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.42.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ae13fcbc7ab8f16b0856729b050ef0c446aa3492"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.4+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "51d2dfe8e590fbd74e7a842cf6d13d8a2f45dc01"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.6+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "9f836fb62492f4b0f0d3b06f55983f2704ed0883"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.0"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a6c850d77ad5118ad3be4bd188919ce97fffac47"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.64.0+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "83ea630384a13fc4f002b77690bc0afeb4255ac9"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.2"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "a32d672ac2c967f3deb8a81d828afc739c838a06"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "91b5dcf362c5add98049e6c29ee756910b03051d"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.3"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "4f00cc36fede3c04b8acf9b2e2763decfdcecfa6"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.13"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "c9551dd26e31ab17b86cbd00c2ede019c08758eb"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "3f7cb7157ef860c637f3f4929c8ed5d9716933c6"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.7"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
git-tree-sha1 = "b086b7ea07f8e38cf122f5016af580881ac914fe"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.7"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "648107615c15d4e09f7eca16307bc821c1f718d8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.13+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "6f1b25e8ea06279b5689263cc538f51331d7ca17"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.1.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "23d109aad5d225e945c813c6ebef79104beda955"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.26.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "de893592a221142f3db370f48290e3a2ef39998f"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.4"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "995a812c6f7edea7527bb570f0ac39d0fb15663c"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.1"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "74fb527333e72ada2dd9ef77d98e4991fb185f04"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.1"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c3d8ba7f3fa0625b062b82853a7d5229cb728b6b"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.1"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8977b17906b0a1cc74ab2e3a05faa16cf08a8291"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.16"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "57617b34fa34f91d536eb265df67c2d4519b8b98"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.5"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─36c32df0-a00e-11ec-1a33-8fbf1ea3ccbc
# ╟─24975543-a212-41eb-804a-3104ef0690f7
# ╟─256756d6-d809-4589-b994-5938c8f17675
# ╟─2f36ece6-d7a2-4545-b45a-f437c1cf0c47
# ╠═54e7292e-823f-49a2-9463-a7e60c36589d
# ╟─e280f46d-25f2-419b-a5eb-2de1f3bc427c
# ╟─421b0b0e-0455-4e7f-a14e-ad9a045934f0
# ╟─566c013f-84d8-4285-a2d9-215634878a4a
# ╟─036d2162-49a8-4631-8532-b44cd6b16068
# ╟─2a138e93-5d4b-4da1-9891-74bdcf9fc60e
# ╟─07349c1f-e756-44c3-affe-47af6b83e16d
# ╟─eb2ddf37-2196-413a-955c-7e84e82df760
# ╟─759f4a8e-4fda-465c-a4bc-65f52af912ef
# ╟─07681221-bc0c-4545-b2d9-18f57cb072c8
# ╟─b63fe541-5cf7-4d3d-9a6d-35a3f24f9788
# ╟─b6005254-921d-40bf-a64a-8841d32154db
# ╟─40d0c591-3b51-4cee-a504-5724334ab0ba
# ╟─051e6321-ed9c-4ec8-9e0f-80b43bb4c300
# ╟─bf756de3-180e-4f7d-af07-800f6742163f
# ╟─0774fec9-eb5a-47e5-8962-a7c23381fcbb
# ╟─42091779-4db6-487c-98d0-7e942bceeca4
# ╟─ce81de85-4dd4-4dfa-848b-0848364ee3b9
# ╟─684d7619-61f1-47b2-b707-a53168e33c87
# ╟─1989b181-071b-4884-accb-5fd028019d76
# ╟─52c206cb-d20c-4483-8e1c-b5bc5aebb7df
# ╟─cbcae415-33d5-49eb-b018-b8a9d1ebbc08
# ╟─1229263d-4217-4b7b-997f-48f9146df094
# ╟─25d559c7-124f-468e-af85-9754036d6786
# ╟─0f374503-9eee-4ed5-a5ed-dbec6a67ef47
# ╟─c8fc7960-689a-40d7-b006-cc5b7ebc32bc
# ╟─fe6fd0ed-3543-4616-af2c-ae843e4aff7f
# ╟─103dcdca-d8b3-4d1b-bdd9-cf9fd9394cd0
# ╟─20c263e1-13f7-47ae-b871-00531e577a0b
# ╟─1cc6fc2e-b397-42f3-b77d-fd29022ef27b
# ╟─6caa763d-0eaa-472e-bae4-f24bcc0cdfb7
# ╟─9d686422-85d6-4e66-bcfa-19c869434305
# ╟─94de02d8-749b-4f8a-a907-07a21d71ee12
# ╟─a5c21756-09e4-4aad-b42b-682326ccfa99
# ╟─ecaadb4d-8f09-4aca-9845-c629b6c41372
# ╟─34c2aef1-93d7-4ce0-bede-fed0fbe96830
# ╟─f5d6c493-0b90-4e8d-8ce9-1934fa8bdf78
# ╟─8807d000-a3e7-4c42-a633-74b650554990
# ╟─4cfe9484-a471-49e5-9825-f88fc4c0785c
# ╟─e8b0c960-e0e9-4d0b-8e09-86d016047f8f
# ╟─6e8c04e9-d8ec-48aa-a15f-2bcebd938541
# ╟─e7acf793-29a8-4bd6-a01d-ff7f47572036
# ╟─98121e66-e9a1-4e2c-aef1-ac31b8ef5ed1
# ╟─9b7414a7-91bb-4f10-8d49-bb4ca11540b8
# ╟─4e6f285e-9487-4487-99e9-ee0738f8bdad
# ╟─3cfbb2da-841f-49c6-901a-a3dee69bc5f6
# ╟─60631ec6-c73d-40ea-a522-d0d4340e0fdf
# ╟─5ba353b4-cede-4473-9224-ee0419d8cb79
# ╟─7ac5267f-db3f-43ae-a970-c84a7bc73458
# ╟─ba441314-8209-43e4-80a2-1d6edbe215ba
# ╟─3fd3102d-f27a-4a65-a540-f2f19c6804c9
# ╟─366553b0-0f28-4e3c-a533-5a73a3a23d79
# ╟─9497f822-c6bd-479e-a1ec-8f4c0261a271
# ╟─944b2cbc-c2af-44be-9244-3162fa3dbfb5
# ╟─aa252a99-a6d7-4591-a3b0-480b98c76832
# ╟─89d33617-4ecf-4721-b8a1-c4d9631ba874
# ╟─9b43eba7-9823-48b1-904e-d8051a5414af
# ╟─153abed0-5370-4246-9f3a-23c491f7271f
# ╟─f87e088b-44ab-447a-b7c8-4d1d791eefc5
# ╟─2fe7bbdf-2fb3-4544-987e-f74c99ea938d
# ╟─a2019faf-6fdf-4924-a0da-982892cde04b
# ╟─258c0007-0600-405d-a6fd-150ec2ea2542
# ╟─dad86c6c-c59b-49b4-ad99-83bdfb88abe0
# ╟─48abcbab-bc05-4f45-88a2-9637a2d1e7c7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
