### A Pluto.jl notebook ###
# v0.19.19

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

# ╔═╡ 0bb512ce-bced-11ec-0695-4dcca0634f4e
begin
	using HypertextLiteral,PlutoUI,LaTeXStrings, Formatting
	
	using Logging
	Logging.disable_logging(Logging.Info) # Disables printing on the (pluto) terminal
	
	using Plots,Plots.PlotMeasures # To be able to use cm, mm, etc.
	default(legend=false,
			size=(250,225),
			tickfontsize=8,
			line=(:2, :blue),
			framestyle=:origin
	)
	
	html"""
	Notebook Packages & Settings
	<style> main {max-width: 925px; } </style>
	<style> .rich_output {color: black;}</style>
	"""	
end

# ╔═╡ be09ef22-72c0-4ef2-8825-cfb5c5d71a0f
function center_div(something)
		@htl "<div align='center'>$something</div>"
end;

# ╔═╡ 04913f2a-0377-4af9-8654-ca732edcfa7e
md"""$\require{physics}$"""

# ╔═╡ 967bef88-73b5-4b87-85af-094a4c170ab9
TableOfContents(title="Ecuaciones & Inecuaciones")

# ╔═╡ 0a6666ce-8f54-4865-a81e-a26ec2e21b1a
md"""
# Polinomios, Ecuaciones & Inecuaciones
## Definiciones

Un polinomio es una expresión de la forma

$P(x)=a_n.x^n + a_{n-1}x^{n-1}+..+a_1x+a_0$

donde $n$ es el **grado** del polinomio y $n\in \mathbb{Z}, \; n\geq 0$. Con base en lo anterior podemos definir:

 | | |
|:--|:--|:--|
|Ecuación Polinómica|$P(x)=Q(x)$| |
|Solución de Ecuación|$\big\{x:P(x)=Q(x)\big\}$| |
|Inecuación Polinómica|$P(x)>Q(x)$|o $<,\;\leq, \;\geq$|
|Solución de Inecuación|$\big\{x:P(x)>Q(x)\big\}$|*IDEM*|
|Sistema de Ecuaciones/Inecuaciones|$\begin{cases}P(x)=Q(x)\\R(x)=S(x)\end{cases}$|o $>\; <, \; \leq, \; \geq$|
|Solución del Sistema|$\big\{x:P(x)=Q(x)\;\land\;R(x)=S(x)\big\}$|*IDEM*|


!!! warning ""
	Si tenemos las siguientes ecuaciones $P(x)=Q(x)\;$ y $\;R(x)=Q(x)$, entonces podemos derivar:
	
	 | | |
	|:--|:--:|:--:|
	|Adición y Sustracción|$P(x) \pm R(x) = Q(x) \pm S(x)$|
	|Multiplicación|$P(x)R(x) = Q(x)S(x)$|
	|División|$\displaystyle\frac{P(x)}{R(x)} = \frac{Q(x)}{S(x)}$|$\forall x:R(x)\neq 0$|

Lo anterior es posible ya que un lado de la ecuación es equivalente al otro lado, pero expresado de una forma distinta. $\blacksquare$.

De forma similar podemos notar que

!!! warning ""
	Si tenemos las siguientes inecuaciones $P(x)>Q(x)\;$ y $\;R(x)>Q(x)$, entonces podemos derivar:
	
	 | | |
	|:--|:--:|:--:|
	|Adición y Sustracción|$P(x) \pm R(x) > Q(x) \pm S(x)$|
	|Multiplicación|$P(x)R(x) = Q(x)S(x)$|
	|División|$\displaystyle\frac{P(x)}{R(x)} = \frac{Q(x)}{S(x)}$|$R(x)\neq 0$|
"""

# ╔═╡ f8e0edb0-44e6-48cf-9b00-afe9fd131645
md"""
## Equivalencias

 $P(x)=Q(x)$ es equivalente con $R(x)=S(x)$ si tienen el mismo conjunto solución, i.e. si se cumplen

$\big\{x:P(x)=Q(x)\} \subseteq \{x:R(x)=S(x)\big\}$

$\big\{x:R(x)=S(x)\} \subseteq \{x:P(x)=Q(x)\big\}$



Con la condición anterior se pueden demostrar las siguientes equivalencias

!!! warning ""
	Sea $a\in\mathbb{R}$

	 ||
	|:--|:--|
	|$P(x)=Q(x) \implies P(x) + a = Q(x) + a$||
	|$P(x)=Q(x) \implies P(x) + G(x) = Q(x) + G(x)$||
	|$P(x)=Q(x) \implies aP(x) = aQ(x)$||
	|$P(x)>Q(x) \implies aP(x) > aQ(x)$|$\forall a>0$|

**Teoremas**

!!! warning ""
	Sean $P(x), Q(x), G(x)$ polinomios de grado $n\geq0$. Entonces las ecuaciones

	$\begin{align}
	P(x)&=Q(x) \\
	P(x)G(x)&=Q(x)G(x)
	\end{align}$

	no son siempre equivalentes.

Siempre se cumplirá

$\big\{x:P(x) = Q(x)\big\} \subseteq \big\{x:P(x)G(x) = Q(x)G(x) \big\}$

ya que al multiplicar por $G(x)$, el grado de ambos polinomios incrementa y el conjunto solución podría mantenerse o expandirse, pero no reducirse (ya que $n\geq0$). Es decir, aquellos $x$ que satisfacen la primera expresión también satisfacerán la segunda expresión. Sin embargo, al dividir $P(x)G(x) = Q(x)G(x)$ entre $G(x)$ estamos reduciendo el grado de los polinomios, lo que podría originar que aquellos $x$ que satisfacen la segunda expresión ya no satisfagan la primera. Por ejemplo cuando $G(a)=0$ pero $P(a) \neq Q(a). \quad \blacksquare$

!!! warning ""
	Sean $P(x), Q(x), G(x)$ polinomios de grado $n\geq0$. Entonces las ecuaciones

	$\begin{align}
	P(x) &> Q(x) \\
	P(x)G(x) &> Q(x)G(x)
	\end{align}$

	no son siempre equivalentes.

La demostración es similar a la del teorema anterior, con la diferencia de que al multiplicar por $G(x)$ podríamos hacer que para algunos $x$ pertenecientes al conjunto solución original se cumpla $P(x)G(x) = Q(x)G(x)$ pero no $P(x)G(x) > Q(x)G(x)$ (ver subfig. 2)

**Ejemplo**
- Subfig. 1: $P(x) > Q(x) \equiv P(x)G(x) > Q(x)G(x)$
- Subfig. 2: En $x=2$ tenemos $P(x)G(x) = Q(x)G(x) = 0$ pero $P(x) > Q(x)$.
- Subfig. 3: Para algunos $x$ se cumple $P(x)G(x) > Q(x)G(x)$ cuando $Q(x) > P(x)$ (alrededor de $x=0.5$ y hacia la izquierda).
"""

# ╔═╡ d0acc346-e295-40d3-839f-3c4690e67a25
let
	# Functions and Domain
	P(x) = 4x + 1
	Q(x) = 2x + 3
	G = [x->x^2, x->(x-2)^2, x->3x - 2]
	linewidth = 1
	x = range(start=-0.5, step=0.01, stop=2.5)
	
	# Plot
	fig = plot(layout=grid(1,3), size=(850,350), ylims=[-3,10], legend = :outertop, legendfontsize=10)
	for i in 1:3
		plot!(fig[i], x, P.(x), line=(:black, 1.3,), label=L"P(x)")
		plot!(fig[i], x, Q.(x), line=(:black, 1.3, :dash), label=L"Q(x)")
		plot!(fig[i], x, G[i].(x).*P.(x), line=(:blue, linewidth), label="\$P(x)G(x)\$")
		plot!(fig[i], x, G[i].(x).*Q.(x), line=(:red, linewidth), label="\$Q(x)G(x)\$")
	end
	plot!(fig[1], xlims=[-0.5, 1.5])
	plot!(fig[2], xlims=[-0.3, 2.5])
	plot!(fig[3], xlims=[-0.5, 1.5])
	
	center_div(fig)
end

# ╔═╡ be6c2f7b-f378-4322-8ecf-bb54ecd0815d
md"""
**Ejemplo**

Sea $A=\big\{x:\sqrt{x+2}=-3\big\}$ y $B=\big\{x:x+2=9\big\}$, demostrar si se cumple alguna o cada una de las siguientes relaciones $A \subset B, B \subset A, A = B$.

$\begin{align} 
\sqrt{x+2} &= -3 &&\longrightarrow P(x) = Q(x)\\
\left(\sqrt{x+2}\right)\left(\sqrt{x+2}\right) &= (-3)\left(\sqrt{x+2}\right) = (-3)(-3) &&\longrightarrow P(x)G(x)=Q(x)G(x)\\
\left(\sqrt{x+2}\right)^2 &= (-3)^2 \\
x+2 &= 9 \implies  A \subset B
\end{align}$

Sin embargo, no hay forma de llegar desde la segunda a la primera ecuación (al menos en $\mathbb{R}) \longrightarrow  B\not\subset A$.

**Teoremas**

!!! warning ""
	Sean $P(x), Q(x)$ polinomios de grado $n\geq0$. Entonces las ecuaciones

	$\begin{align}
	P(x)&=Q(x) \\
	\big[P(x)\big]^2&=\big[Q(x)\big]^2
	\end{align}$

	no son siempre equivalentes.

El ejemplo anterior sirve como demostración de un caso particular. En general, si $P(x)=Q(x)<0$, entonces es posible llegar desde la primera ecuación a la segunda, pero no al revés. $\quad\blacksquare$

!!! warning ""
	Sea $P(x)$ un polinomio de grado $n\geq0$. Entonces las inecuaciones

	$\begin{align}
	P(x) &> 0 \\
	\big[P(x)\big]^2 &> 0
	\end{align}$

	no son siempre equivalentes.

Siempre se cumple que $\big\{x:P(x)>0\big\} \subseteq \big\{x:[P(x)]^2>0\big\}$ pero no siempre se cumple la conversión, e.g. cuando $\big[P(x)\big]^2 > 0$ pero $P(x)<0$. $\quad\blacksquare$
"""

# ╔═╡ 475d97cc-f0f8-41a5-b403-5a7ffa6b7e9a
md"""
## 🔨 ???
!!! warning ""
	Si un polinomio puede ser factorizado como $P(x)=P_1(x)P_2(x)...P_r(x)$, entonces
	
	$\big\{x:P(x)=0\big\}=\big\{x:P_1(x)=0\big\}\cup\big\{x:P_2(x)=0\big\}\:\cup...\cup\: \big\{x:P_r(x)=0\big\} = \bigcup_{i=1}^{r}\big\{x:P_{i}(x)=0\big\}$

-  $\exists i \exists x:P_i(x)=0 \implies P(x)=0 \implies \bigcup_{i=1}^{r}\big\{x:P_{i}(x)=0\big\} \subseteq \big\{x:P(x)=0\big\}$
-  $P(x)=0 \implies \exists i \exists x:P_i(x)=0\implies \big\{x:P(x)=0\big\} \subseteq \bigcup_{i=1}^{r}\big\{x:P_{i}(x)=0\big\} \quad \blacksquare$
"""

# ╔═╡ 247d8fac-2139-4dd8-8dd5-f93a0ec3682d
md"""
# Ecuaciones & Inecuaciones Lineales
## 1 variable
!!! warning ""
	Sea $a\neq0$, entonces la ecuación lineal

	$ax+b=0$

	tiene una única solución. 

La solución es el cociente $-\frac{b}{a}$ y es un número único. $\quad\blacksquare$

!!! warning ""
	Por otro lado, las inecuaciones de la forma

	$ax+b>0$

	 $(<, \geq, \leq)$ tienen infinitas soluciones.
"""

# ╔═╡ bc2dcea2-2d29-4a79-9cc6-fea594351229
md"""
## 2 variables
!!! warning ""
	Sean $a, b \neq 0$, entonces la ecuación lineal
	
	$ax + by + c = 0$
	
	tiene como solución a un conjunto de $n$ pares ordenados $(x,y)$, donde $n$ es la cantidad de elementos en el field. Si $a=0 \underline\lor b=0$ (disyunción exclusiva), entonces la solución se reduce a la de una ecuación lineal univariable.

Para cualquier valor $x$, se puede encontrar un valor $y$ que satisfaga la ecuación. $\blacksquare$ En $\mathbb{R}^2$, la solución es un conjunto infinito de pares ordenados y puede representarse como una recta.

!!! warning ""
	Las inecuaciones de la forma

	$\begin{align}
	ax + by + c > 0 \\
	ax + by + c < 0
	\end{align}$

	también tienen como solución un conjunto infinito de pares ordenados $(x,y)$. Además:
	- Sea $ax + by + c = 0$ la recta que divide al plano $\mathbb{R}^2$ en dos mitades, entonces si un punto $P=(x,y)$ satisface la inecuación, todos y únicamente los puntos que se encuentran en la misma mitad que $P$ también lo hacen.
	- Para las inecuaciones con $\geq, \leq$, la solución se extiende para considerar también a aquellos valores que satisfacen $ax + by + c = 0$.

Demostración indirecta:
- Asumamos que los puntos $P_1, P_2$ se encuentran en la misma mitad del plano y que 
  -  $ax + by + c > 0$ en $P_1$
  -  $ax + by + c \leq 0$ en $P_2$ (se pretende demostrar que esta condición es absurda)
- Si 2 puntos se encuentran en la misma mitad del plano, entonces es posible unirlos mediante una curva que no tenga ningún punto en común con la recta divisoria $ax + by + c = 0$, por lo tanto solo queda el caso $ax + by + c < 0$ en $P_2$
- Sin embargo, al intentar unir $P_1$ y $P_2$ notaremos que en algún momento la relación tendrá que ser $ax + by + c = 0$ (al pasar de negativo a positivo), lo cual resulta contradictorio con la premisa inmediatamente anterior, y por lo tanto la premisa inicial es falsa. $\blacksquare$
"""

# ╔═╡ 96f085f5-aa3e-4c39-a9a1-c5f470b1e992
md"""
## Sistema de Ecuaciones con 2 variables

Consideremos un sistema de ecuaciones lineales simultáneas

$\begin{cases}
a_{1}x + b_{1}y + c_1 = 0 & (a_{1} \neq 0) \underline\lor (b_{1} \neq 0)\\
a_{2}x + b_{2}y + c_2 = 0 & (a_{2} \neq 0) \underline\lor (b_{2} \neq 0)
\end{cases}$

La solución del sistema es el par ordenado $(x,y)$ que satisface ambas ecuaciones, i.e.

$\big\{(x,y):a_{1}x + b_{1}y + c_1 = 0\big\} \cup \big\{(x,y):a_{2}x + b_{2}y + c_2 = 0\big\}$

Esta solución puede hallarse formando un sistema equivalente mediante adición y sustracción:

!!! warning ""
	Los sistemas de ecuaciones lineales
	
	$\begin{align}
	&(1) \quad \begin{cases}
	a_{1}x + b_{1}y + c_1 = 0 & (a_{1} \neq 0) \underline\lor (b_{1} \neq 0) \\
	a_{2}x + b_{2}y + c_2 = 0 & (a_{2} \neq 0) \underline\lor (b_{2} \neq 0)
	\end{cases} \\
	\\
	&(2)\quad \begin{cases}
	a_{1}x + b_{1}y + c_1 = 0 \\
	k_{1}\left(a_{1}x + b_{1}y + c_1\right) + k_{2}\left(a_{2}x + b_{2}y + c_2\right) = 0 
	\end{cases}
	\end{align}$	

	donde $k\neq0$ son equivalentes.

Es fácil notar que $\big\{(x,y):(1)\big\} \subseteq \big\{(x,y):(2)\big\}$. Ahora, si un par ordenado satisface $(2)$, entonces $a_{1}x + b_{1}y + c_1 = 0$ y ya que $k_{2}\neq0$, también $a_{2}x + b_{2}y + c_2 = 0 \quad \blacksquare$

En $\mathbb{R}^2$ la solución es el punto común de las rectas.

## Sistema de Inecuaciones con 2 variables
Consideremos el siguiente sistema de inecuaciones lineales

$\begin{cases}
a_{1}x + b_{1}y + c_1 > 0 & (a_{1} \neq 0) \underline\lor (b_{1} \neq 0)\\
a_{2}x + b_{2}y + c_2 > 0 & (a_{2} \neq 0) \underline\lor (b_{2} \neq 0) \\
...
\end{cases}$

La solución de cada inecuación es una mitad del plano y la solución del sistema es la intersección de todos los planos.

**Ejemplo**

"""

# ╔═╡ 3130eeef-4f14-4fb8-a35f-b61d93b55db4
begin
	functions = [x->(4x+25)/5, x->(5x+22)/(-3), x->(2x-24)/7, x->(7x+25)/(-5)]
	x = Vector(-30:30)
	fig = plot(size=(600,300), xlims=[-30, 30], ylims=[-20, 20])
	
	#Left
	c = [:red, :red, :red, :red]
	alpha = 0.25
	plot!(x, functions[1].(x), fill=(-100, alpha, c[1]), line=(:black, 1.5))
	plot!(x, functions[2].(x), fill=(+100, alpha, c[2]), line=(:black, 1.5))
	plot!(x, functions[3].(x), fill=(+100, alpha, c[3]), line=(:black, 1.5))
	plot!(x, functions[4].(x), fill=(-100, alpha, c[4]), line=(:black, 1.5))
	plot!(Plots.Shape([-5, -4.545, -0.932, -2], [1, 1.364, -3.695, -4]), line=(:black, 1), color=:red)
	center_div(fig)
end

# ╔═╡ 85c0c63e-df40-4c02-985a-ccfca531df9c
md"""
## Transformaciones Lineales en 2D
A grandes rasgos y muy superficialmente:
!!! warning ""
	 Transformación|**x'**|**y'**||
	|:--|:--:|:--:|:--:|
	|**Traslación**|$x + a$|$y + b$|
	|**Dilatación / Scaling**|$ax$|$ay$|
	|**Reflexión en Y**|$-x$|$y$|
	|**Reflexión en X**|$x$|$-y$|
	|**Rotación respecto al origen**|$ax + by$|$-bx + ay$|$\text{where } a^2 + b^2 = 1$|
"""

# ╔═╡ f660c77a-541c-44e4-8176-5524c63bb9ed
@bind α Slider(0:0.01:2π)

# ╔═╡ c3ac4e61-dfc4-43c8-aab9-350aaa1524e4
let
	x = [1, -3, 4, -9, 7]
	y = [-2, 8, -6, 7, 5]
	x_ = cos(α).*x + sin(α).*y
	y_ = -sin(α).*x + cos(α).*y
	lims = 15
	fig = plot(xlims=[-lims, lims], ylims=[-lims, lims], xticks=[], yticks=[])
	scatter!(x, y)
	scatter!(x_, y_)
	center_div(fig)
end

# ╔═╡ 68e4d9b7-5e3b-4d0d-a0fb-4ecc127ee580
md"""
# Ecuaciones & Inecuaciones Cuadráticas
## Ecuaciones Cuadráticas de 1 variable
**Método de completar el cuadrado**

Sabemos que $(x + d)^2 = x^2 + 2xd + d^2$. Ahora, cuando $a\neq 0$ podemos proceder de la siguiente forma

$\begin{align}
ax^2 + bx + c &= 0 \\
x^2 + \frac{b}{a}x + \frac{c}{a} &= 0 \\
x^2 + \frac{b}{a}x  &= -\frac{c}{a} 
\end{align}$

Haciendo que $d=\frac{b}{2a}$ podemos notar que

$\begin{align}
x^2 + \frac{b}{a}x + \left(\frac{b}{2a}\right)^2 &= -\frac{c}{a} + \left(\frac{b}{2a}\right)^2 \\
\left(x + \frac{b}{2a}\right)^2 &= -\frac{c}{a} + \frac{b^2}{4a^2} \\
\left(x + \frac{b}{2a}\right)^2 &= \frac{-4ac + b^2}{4a^2}
\end{align}$

Notemos además que $y^2=r \iff y = \pm \sqrt{r}$, entonces

$\begin{align}
x + \frac{b}{2a} &= \pm\sqrt{\frac{-4ac + b^2}{4a^2}}
\end{align}$

Finalmente obtenemos que

!!! warning ""
	$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$

	donde no necesariamente se cumple que $x_1,x_2\in\mathbb{R}$ 

"""

# ╔═╡ 0e6cb38b-ccc5-4446-b560-796118a50f84
md"""
## Ecuaciones Cuadráticas de 2 variables
"""

# ╔═╡ 8d1377a8-b933-463e-a599-f1921d86b995
md"""
# Ecuaciones Polinómicas de Grado Mayor

"""

# ╔═╡ 3dbe90f6-3365-4f29-9940-11100a3961c9
md"""
# Ecuaciones No Lineales
## 🔨 Non-linear, 2-variable equation examples

Una solución contiene 35% de alcohol y 65% de agua. Si empezamos con 12 cm3 (centímetros cúbicos) de solución, cuánta agua debe agregarse para hacer que el porcentaje de alcohol sea 20%, 10%, 5%?

Deseamos que la proporción sea $p$

$\begin{align}
\frac{0.35(12)}{12 + x} = p \implies x = \frac{0.35(12) - p(12)}{p}
\end{align}$

"""

# ╔═╡ 4ca5fc5a-f8e6-4d0b-b7e9-c00be13bde52
let
	f(p) = (0.35*12 - p*12)/p
	p = Vector(0.20:-0.01:0.05)
	y = f.(p)
	fig = plot(p, y, size=(600,300), xflip=true, framestyle=:default, gridalpha=0.3, bottom_margin=2mm,
		xticks=(p, [latexstring(format(i, precision=2)) for i in p]),
		yticks=(y, [latexstring(format(i, precision=2, commas=true)) for i in y]),
		xlabel="Proporción deseada de alcohol", ylabel="Agua adicional (cm3)"
	)
	center_div(fig)
end

# ╔═╡ 34a6bfc3-10dc-4991-a598-b9990f4286fe
md"""
The radiator of a car can contain 10 gal of liquid. If it is half full with a mixture having 60% antifreeze and 40% water, how much more water must be added so that the resulting mixture has only a) 40% antifreeze? b) 10% antifreeze? Will it fit in the radiator?

$\frac{0.60(5)}{5 + x}=p \implies x = \frac{0.60(5) - p(5)}{p} \quad\land\quad x \leq 5$
"""

# ╔═╡ a6fe1f8b-c72f-4d49-a08f-1f528c84c064
let
	f(p) = (0.60*5 - p*5)/p
	p = Vector(0.40:-0.05:0.10)
	y = f.(p)
	fig = plot(p, y, size=(600,300), xflip=true, framestyle=:default, gridalpha=0.3, bottom_margin=2mm,
		leg=:topleft, label=false,
		xticks=(p, [latexstring(format(i, precision=2)) for i in p]),
		yticks=(y, [latexstring(format(i, precision=2, commas=true)) for i in y]),
		xlabel="Proporción deseada de anticongelante", ylabel="Agua adicional (cm3)"
	)
	hline!([5], line=(:red, 1), label="Límite de capacidad")
	center_div(fig)
end

# ╔═╡ bdea4158-378e-490e-a134-8d319fd3f63f
md"""
# Ráices de Polinomios
## División de Polinomios

"""

# ╔═╡ e0362be3-6975-4af4-9005-80c67b258e78
md"""
## División Sintética
"""

# ╔═╡ b7e4efdc-305a-4f9f-84bf-a328d2572f51
md"""
# Aritmética Modular
## Operación Módulo
!!! warning ""
	La operación módulo establece la siguiente relación
	
	$\boxed{
	\begin{align}
	a \equiv b \mod{m} \iff a = b + mk, \; k \in \mathbb{Z} \\
	a \equiv b \mod{m} \iff a - b = mk, \; k \in \mathbb{Z}
	\end{align}
	}$

**Corolarios**

$\boxed{a \equiv b \mod{m} \implies a + c \equiv b + c \mod{m}, \quad c \in \mathbb{R}}$
$\begin{align}
a &= b + mk \\
a + c &= b + c + mk \quad \blacksquare
\end{align}$

$\boxed{a \equiv b \mod{m} \implies a \equiv b + mk_{2} \mod{m}, \quad k_{2}\in\mathbb{Z}}$
$\begin{align}
a &= b + mk \\
a &= b + mk_{2} + m(k - k_{2}) \\
a &\equiv b + mk_{2} \mod{m} \quad \blacksquare
\end{align}$

$\boxed{a \equiv b \mod{m} \implies a \times c \equiv b \times c \mod{m}, \quad c \in \mathbb{Z}}$
$\begin{align}
a &= b + mk \\
ac &= bc + mkc \\
ac &\equiv bc \mod{m} \quad \blacksquare
\end{align}$

$\boxed{a \equiv b \mod{m} \implies a \times c \equiv b \times c \mod{c\times m}, \quad c \in \mathbb{Z}}$

$\begin{align}
a &= b + mk \\
ac &= bc + mkc \\
ac &\equiv bc \mod{mc} \quad \blacksquare
\end{align}$

Siempre y cuando $mc \in \mathbb{Z}$ (particularmente cuando ocurre una división, i.e. $c=d^{-1}$)

$\boxed{a \equiv b \mod{m} \implies b \equiv a \mod{m}}$
$\begin{align}
a \equiv b \mod{m} &\implies a - b = mk_1 \\
	&\implies b - a = -mk_1 = m(-k_1) \\
	&\implies b \equiv a \mod{m} \quad\blacksquare
\end{align}$

$\boxed{(a \equiv b \mod{m} \;\;\land\;\; b \equiv c \mod{m}) \implies a \equiv c \mod{m}}$
$\begin{align}
(a \equiv b \mod{m} \implies a = b + mk_1) &\;\land\; (b \equiv c \mod{m} \implies b = c + mk_2) \\
	&\implies a = (c + mk_2) + mk_1 = c + m(k_1 + k_2)\\
	&\implies a = c \mod{m} \quad\blacksquare
\end{align}$

"""

# ╔═╡ 6b807128-41ef-4145-a00e-17606a613dd6
md"""
## Clase Residual
!!! warning ""
	Sea $a \equiv b \mod{m}$, entonces la clase residual $A$ es el conjunto infinito
	
	$A = \{..., \;a-2m,\; a-m,\; a,\; a+m,\; a+2m,\;...\}$
	
	que satisface la misma congruencia con diferentes valores $k\in\mathbb{Z}$

	$A \equiv b \mod{m}$

**Corolarios**
!!! warning ""
	Sean $X,Y$ dos clases residuales que satisfacen $\big(X \equiv a \mod{m}\big) \;\land\; \big(Y \equiv b \mod{m}\big)$, entonces
	
	$\boxed{X = Y \iff a \equiv b \mod{m}}$ 

- Sean $x,y$ elementos de $X,Y$ respectivamente:
  +  $x = a + mk_1$
  +  $y = b + mk_2$
- Se sabe que si $a \equiv b \mod{m} \implies a = b + mk_3$
  +  $\implies x = (b + mk_3) + mk_1 = b + m(k_3 + k_1)$ 
  +  $\implies x \equiv b \mod{m}$
- Ya que cualquier elemento $X$ puede expresarse como $b + mk, \;$ entonces  $\;X = Y \quad\blacksquare$

!!! warning ""
	Sea $A$ una clase residual que satisface $A \equiv b \mod{m}$
	
	$\boxed{A \equiv b \mod{m} \implies A \equiv b + m(j) \mod{m}, \quad j \in \mathbb{Z}}$

$\begin{align}
A &= b + mk \\
A + mj &= b + mj + mk \\
A &\equiv b + mj \mod{m} \quad\blacksquare
\end{align}$
Los valores de $A$ son los mismos, pero han sido desplazados $j$ espacios. Sucede lo mismo con la multiplicación (y por lo tanto con la división), siempre y cuando los valores resultantes en ambos lados sigan siendo enteros.

**Ejemplo**\
Sean
-  $x \equiv 5 \mod{2}$
-  $y \equiv 3 \mod{2}$

|k|-5|-4|-3|-2|-1|0|1|2|3|4|5|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|**x**|-5|-3|-1|1|3|5|7|9|11|13|15|
|**y**|-7|-5|-3|-1|1|3|5|7|9|11|13
"""

# ╔═╡ 34a6cfe1-11ef-40bc-acf2-7dedae382506
md"""
**Suma y Multiplicación de Clases Residuales**

!!! warning ""
	$\begin{align}
	[a \mod{m}] + [b \mod{m}] &= [a + b \mod{m}] \\
	[a \mod{m}] \times [b \mod{m}] &= [a\times b \mod{m}]
	\end{align}$

Sean $x, y$ elementos de ambas clases residuales, entonces

$\begin{align}
(x = a + mk_1) &\;\land\; (y = b + mk_2) \\
	&\implies x + y = a + b + m(k_1 + k_2) \\
	&\implies x + y \equiv a + b \mod{m} \quad\blacksquare \\
	&\implies x \times y = ab + amk_2 + bmk_1 + mk_1mk_2 = ab + m(...) \\
	&\implies x \times y \equiv a \times b \mod{m} \quad\blacksquare \\
\end{align}$

!!! warning ""
	Existen $m$ distintas clases residuales módulo $m$.

- Existen $m$ posibles restos al dividir un número $a\in\mathbb{Z}$ entre $m \longrightarrow \{0,1,...,m-1\}$
- Cada clase residual satisface con un único resto la condición $\longrightarrow a \equiv b \mod{m} \quad \blacksquare$

**Inverso Aditivo & Inverso Multiplicativo en una clase residual**

Recordemos que en $\mathbb{R}$ el inverso aditivo de un número $a$ es $-a$ y el inverso multiplicativo es $\frac{1}{a}$. Ahora
!!! warning ""
	 Sea $\;b\in \{0,1,...,m-1\}$ un posible resto que satisface $\;a \equiv b \mod{m}$, entonces en todas las clases residuales existe un valor $b_i \in \{0,1,...,m-1\}$ tal que

	$b + b_i \equiv 0 \mod{m}$

	y en **algunas** clases residuales existe un valor $b_j \in \{0,1,...,m-1\}$ tal que

	$b\times b_j \equiv 1 \mod{m}$

Por ejemplo, para la clase residual $\mod{7}$

|(+)|0|1|2|3|4|5|6| | |(×)|0|1|2|3|4|5|6|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|**0**|0|1|2|3|4|5|6| ||**0**|0|0|0|0|0|0|0|
|**1**|1|2|3|4|5|6|0| ||**1**|0|1|2|3|4|5|6|
|**2**|2|3|4|5|6|0|1| ||**2**|0|2|4|6|1|3|5|
|**3**|3|4|5|6|0|1|2| ||**3**|0|3|6|2|5|1|4|
|**4**|4|5|6|0|1|2|3| ||**4**|0|4|1|5|2|6|3|
|**5**|5|6|0|1|2|3|4| ||**5**|0|5|3|1|6|4|2|
|**6**|6|0|1|2|3|4|5| ||**6**|0|6|5|4|3|2|1|

Podemos notar que, por ejemplo, el inverso aditivo de $5$ es $2$ ya que $5+2\equiv 0 \mod{7}$ y su inverso multiplicativo es $3$ ya que $5\times 3\equiv 1 \mod{7}$.

Sin embargo en la clase residual $\mod{4}$ el número $2$ solo tiene inverso aditivo mas no un inverso multiplicativo.
"""

# ╔═╡ f36ac1b1-08a1-4262-9a64-5fcf72588ebe
md"""
## Ecuaciones con Operación Módulo
**¿Para qué valores $x$ se cumple la congruencia $3x+2 \equiv 4 \mod{5}$?**

Por definición podemos notar que $3x + 2 = 4 + 5k, \;k\in\mathbb{Z}$. Instanciando $k$ podríamos hallar los valores $x$, sin embargo este procedimiento sería muy tedioso. En su lugar podemos proceder de la siguiente forma

$\begin{align}
3x + 2 &\equiv 4 \mod{5} \\
3x &\equiv 2 \mod{5} \\
x &\equiv 4 \mod{5} \quad (\text{Inv. Mult. de }3=2)
\end{align}$

o de forma más detallada

$\begin{align}
3x &\equiv 2 \mod{5} \\
6x &\equiv 4 \mod{5} \\
5x + x &\equiv 4 \mod{5} \\
x &\equiv 4 \mod{5}
\end{align}$

Entonces los $x$ que satisfacen la ecuación original también son aquellos que satisfacen $x \equiv 4 \mod{5}$.


"""

# ╔═╡ 28b23a57-9528-406f-8d6f-b4581eb68284
md"""
---
**Resolver el sistema de ecuaciones**

$\begin{cases}
x + 3y \equiv 4 \mod{7} \\
3x - y \equiv 3 \mod{7}
\end{cases}$

Estas congruencias son equivalentes a las siguientes ecuaciones en el field de clase residual, mod 7

$(1)\begin{cases}
x + 3y - 4 = 0 \\
3x - y - 3 = 0
\end{cases}$

$\begin{align}
\begin{cases}
x + 3y - 4 = 0 \\
9x - 3y - 9 = 0
\end{cases} \implies 10x - 13 = 0 &\implies 10x \equiv 13 \mod{7} \\
&\implies 10x = 13 + 7k_1 \\
&\implies 10x - 7x = 13 - 7 + 7(1 + k_1 - x) \\
&\implies 3x \equiv 6 \mod{7} \\
&\implies x \equiv 2 \mod{7} \quad (\text{Inv. Mult. de }3=5)
\end{align}$

Resolviendo para $y$ en (1) y considerando la clase residual mod 7, obtenemos

$\begin{align}
2 + 3y - 4 = 0 &\implies 3y \equiv 2 \mod{7} \\
	&\implies y \equiv 3 \mod{7} \quad (\text{Inv. Mult. de }3=5)
\end{align}$
"""

# ╔═╡ b81fdf89-127c-47c2-8ad2-f9189984b116
md"""
---
**Hallar los puntos enteros $(x,y)$ por los cuales la recta $y = \frac{7}{15}x + \frac{1}{3}$ pasa** 

Para asegurar que $(x,y)$ es un punto entero, podemos reescribir la expresión como $y = \frac{7x + 5}{15}$ y utilizar la operación módulo

$\begin{align}
7x + 5 &\equiv 0 \mod{15} \\
7x &\equiv -5 \mod{15} \\
x &\equiv -65 \mod{15} \quad (\text{Inv. Mult.}=13)\\
x &= -65 + 15k \;\land\; y = \frac{7x + 5}{15} \\
\end{align}$

"""

# ╔═╡ 71eb51f0-66bb-4fe8-85db-b0a7fbaa6a5c
let
	k = Vector(-5:5)
	X = -5 .+ 15k
	Y = (7X .+ 5)/15
	x = Vector(-80:80)
	fig = plot(x, [(7/15)*x .+ 1/3], size=(600, 300), line=(1), gridalpha=0.3, tickfontsize=9)
	scatter!(X, Y, c=:blue, 
		xticks=(X, [latexstring(i) for i in X]), 
		yticks=(Y, [latexstring(format(i, precision=0)) for i in Y]),
		)
	center_div(fig)
end

# ╔═╡ 306a77c2-4792-4abf-9dbc-d9e25c3978d9
md"""
---
**Hallar todas las soluciones para $25x \equiv 10 \mod{40}$**

$\begin{align}
25x &\equiv 10 \mod{40} \\
5x &\equiv 2 \mod{8} \quad(\text{Cambio de módulo})\\
5x &\equiv 10 \mod{8} \implies 5(x-2) = 8k_1 \implies 5|8k_1 \implies 5|k_1 \implies k_1 = 5k_2\\
5x &= 10 + 8(5k_2) \\
x &\equiv 2 \mod{}8
\end{align}$

En la figura:
- Los puntos azules muestran la combinación de valores $(x, 25x-10)$. Notemos que los valores $y$ son múltiplos de $40$.
- Las línea azul muestra el resto obtenido de $\frac{25x - 10}{40}$ (multiplicado $\times 10$) para los otros valores en el eje $X$.
"""

# ╔═╡ 6eea60d4-07b4-401b-9318-03c859ff2487
let
	k = Vector(-4:4)
	X = 2 .+ 8*k
	Y = 25*X .- 10
	x_axis = Vector(X[1]:X[end])

	fig = plot(x_axis, ((25*x_axis .- 10).%40)*10, gridalpha=0.3,
		line=(1), size=(600, 300), tickfontsize=8, alpha=0.4
	)
	
	scatter!(X, Y, marker=(4, :blue), 
		xticks=(X, [latexstring(i) for i in X]),
		yticks=(Y, [latexstring(i) for i in Y])
	)

	center_div(fig)
end

# ╔═╡ 54850655-9ae6-483d-aa1b-7b904d3f30a8
md"""
---
**Hallar pares de números $(x,y) \in \mathbb{Z}^2$ tales que $23x + 17y = 1$**

$\begin{align}
1 - 23x &\equiv 0 \mod{17} \\
23x &\equiv 1 \mod{17} \\
23x - 17x &\equiv 1 -17x \mod{17} \\
6x &\equiv 1 \mod{17} \\
6x &\equiv 18 \mod{17} \\
x &= 3 + 17k
\end{align}$
"""

# ╔═╡ c7ba3944-25ac-4bc0-ac89-c1b90f5017dd
let
	k = (-5:5)
	x = 3 .+ 17*k
	y = (1 .- 23*x)/17
	fig = scatter(x, y, marker=(4, :blue), size=(600,300), gridalpha=0.3,
		xticks=(x, [latexstring(format(i, precision=0)) for i in x]),
		yticks=(y, [latexstring(format(i, precision=0)) for i in y])
	)
	center_div(fig)
end

# ╔═╡ a7393f5c-2084-4910-b177-2e4ab79819f6
md"""
# Referencias

|Autor(es)|Libro|Año|
|:--|:--|:--:|
|Serge Lang|Basic Mathematics|1971|
|C. Allendoerfer & C. Oakley|Principles of Mathematics (2nd ed.)|1963|
|Michael Spivak|Calculus (4th ed.)|2008|
|Tom M. Apostol|Calculus Vol. 1 (2nd ed.)|1967|
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Formatting = "59287772-0a20-5a39-b81b-1366585eb4c0"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Formatting = "~0.4.2"
HypertextLiteral = "~0.9.3"
LaTeXStrings = "~1.3.0"
Plots = "~1.27.5"
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "eb8395d62eaf1b5e46d794c9b1a5da2885bef883"

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
version = "1.1.1"

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
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "9950387274246d08af38f6eef8cb5480862a435f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.14.0"

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
git-tree-sha1 = "b153278a25dd42c65abbf4e62344f9d22e59191b"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.43.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

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
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

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

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

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
git-tree-sha1 = "af237c08bda486b74318c8070adb96efa6952530"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.2"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "cd6efcf9dc746b06709df14e462f0a3fe0786b1e"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.64.2+0"

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
git-tree-sha1 = "46a39b9c58749eefb5f2dc1178cb8fab5332b1ab"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.15"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

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
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

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
git-tree-sha1 = "a970d55c2ad8084ca317a4658ba6ce99b7523571"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.12"

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
version = "2.28.0+0"

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
version = "2022.2.1"

[[deps.NaNMath]]
git-tree-sha1 = "737a5957f387b17e74d4ad2f440eb330b39a62c5"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ab05aa4cc89736e95915b01e7279e61b1bfe33b8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.14+0"

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
git-tree-sha1 = "621f4f3b4977325b9128d5fae7a8b4829a0c2222"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.4"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "8162b2f8547bc23876edd0c5181b27702ae58dce"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.0.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "bb16469fd5224100e422f0b027d26c5a25de1200"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.2.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "88ee01b02fba3c771ac4dce0dfc4ecf0cb6fb772"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.27.5"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "670e559e5c8e191ded66fa9ea89c97f10376bb4c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.38"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "d3538e7f8a790dc8903519090857ef8e1283eecd"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.5"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

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
git-tree-sha1 = "dc1e451e15d90347a7decc4221842a022b011714"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.2"

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
version = "0.7.0"

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
git-tree-sha1 = "4f6ec5d99a28e1a749559ef7dd518663c5eca3d5"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "8d7530a38dbd2c397be7ddd01a424e4f411dcc41"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.2"

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
version = "1.0.0"

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
version = "1.10.0"

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
version = "1.2.12+3"

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
version = "5.1.1+0"

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
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

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
# ╟─0bb512ce-bced-11ec-0695-4dcca0634f4e
# ╟─be09ef22-72c0-4ef2-8825-cfb5c5d71a0f
# ╟─04913f2a-0377-4af9-8654-ca732edcfa7e
# ╠═967bef88-73b5-4b87-85af-094a4c170ab9
# ╟─0a6666ce-8f54-4865-a81e-a26ec2e21b1a
# ╟─f8e0edb0-44e6-48cf-9b00-afe9fd131645
# ╟─d0acc346-e295-40d3-839f-3c4690e67a25
# ╟─be6c2f7b-f378-4322-8ecf-bb54ecd0815d
# ╟─475d97cc-f0f8-41a5-b403-5a7ffa6b7e9a
# ╟─247d8fac-2139-4dd8-8dd5-f93a0ec3682d
# ╟─bc2dcea2-2d29-4a79-9cc6-fea594351229
# ╟─96f085f5-aa3e-4c39-a9a1-c5f470b1e992
# ╟─3130eeef-4f14-4fb8-a35f-b61d93b55db4
# ╟─85c0c63e-df40-4c02-985a-ccfca531df9c
# ╟─f660c77a-541c-44e4-8176-5524c63bb9ed
# ╟─c3ac4e61-dfc4-43c8-aab9-350aaa1524e4
# ╟─68e4d9b7-5e3b-4d0d-a0fb-4ecc127ee580
# ╟─0e6cb38b-ccc5-4446-b560-796118a50f84
# ╟─8d1377a8-b933-463e-a599-f1921d86b995
# ╟─3dbe90f6-3365-4f29-9940-11100a3961c9
# ╟─4ca5fc5a-f8e6-4d0b-b7e9-c00be13bde52
# ╟─34a6bfc3-10dc-4991-a598-b9990f4286fe
# ╟─a6fe1f8b-c72f-4d49-a08f-1f528c84c064
# ╟─bdea4158-378e-490e-a134-8d319fd3f63f
# ╟─e0362be3-6975-4af4-9005-80c67b258e78
# ╟─b7e4efdc-305a-4f9f-84bf-a328d2572f51
# ╟─6b807128-41ef-4145-a00e-17606a613dd6
# ╟─34a6cfe1-11ef-40bc-acf2-7dedae382506
# ╟─f36ac1b1-08a1-4262-9a64-5fcf72588ebe
# ╟─28b23a57-9528-406f-8d6f-b4581eb68284
# ╟─b81fdf89-127c-47c2-8ad2-f9189984b116
# ╟─71eb51f0-66bb-4fe8-85db-b0a7fbaa6a5c
# ╟─306a77c2-4792-4abf-9dbc-d9e25c3978d9
# ╟─6eea60d4-07b4-401b-9318-03c859ff2487
# ╟─54850655-9ae6-483d-aa1b-7b904d3f30a8
# ╟─c7ba3944-25ac-4bc0-ac89-c1b90f5017dd
# ╟─a7393f5c-2084-4910-b177-2e4ab79819f6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
