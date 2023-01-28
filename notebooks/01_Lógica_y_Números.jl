### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# ╔═╡ cc3486b0-b105-11ec-074b-01dadc9cf21e
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

	using Luxor
	
	html"""
	<style> main {max-width: 925px; } </style>
	<style> .rich_output {color: black;}</style>
	"""	
end

# ╔═╡ 9f30378f-aa8c-432e-bbb2-eb7d076c480d
function center_div(something)
		@htl "<div align='center'>$something</div>"
end;

# ╔═╡ 75b23021-18e0-471c-a9bb-7eb0abaa9098
md"""$\require{physics}$"""

# ╔═╡ 86fbf5cd-d09e-43ba-b272-12c1cc5d865a
TableOfContents(title="Fundamentos")

# ╔═╡ da295bc8-6707-4873-8efe-2b9caede2555
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

	rectangle(x, y, w, h) = Shape(x .+ [0,w,w,0], y .+ [0,0,h,h])
	print()
end

# ╔═╡ 21160fc7-cf58-4c9a-b5af-f8e6af0ef5f6
md"""
# Lógica y Teoría de Conjuntos
## Definiciones básicas
- En matemáticas se deben evitar definiciones circulares como
  + Punto: parte común de 2 líneas que se intersectan
  + Línea: figura trazada por un punto que se mueve a lo largo del camino más corto entre otros 2 puntos
- El procedimiento estandar en matemáticas para establecer definiciones es considerar a un pequeño grupo de palabras como *no definidas* (i.e. línea, punto) y establecer definiciones aprovechando las ideas intuitivas que estas ofrecen
  + Segmento de línea: Porción de *línea* contenida entre 2 *puntos*
- Notaremos que algunas palabras ni siquiera pueden ser definidas meticulosamente o sin ambigüedad.
- Finalmente las definiciones deben ser incluyentes con todos los casos que deseamos agregar, y excluyentes con aquellos que no, e.g. asumamos que todas las otras palabras, excepto *cuadrado* y *rectángulo*, han sido definidas, entonces
  + Cuadrado: polígono con 4 lados iguales $\longrightarrow$ No es suficientemente excluyente, un rombo satisface esta definición.
  + Rectángulo: polígono con 4 lados iguales y ángulos rectos $\longrightarrow$ No es suficientemente incluyente, excluye a los rectángulos/cuadriláteros sin 4 lados iguales.

En lo que corresponde a las siguientes definiciones, algunas palabras se asumen como autoevidentes. La intención no es ofrecer deficiones rigurosas, sino conceptos intuitivos

!!! warning ""
	| | |
	|:--|:--|
	|Proposición|Sentencia que puede ser **V** of **F**|
	|Axioma|Proposición inicial asumida como verdadera|
	|Sentencia Abierta|Sentencia neutra (variable) transformable en proposición|
	|Teorema|Sentencia que ha sido o puede ser demostrada como verdadera|
	|Lema|Teorema auxiliar en la demostración de otro más importante|
	|Corolario|Teorema derivado y deducido inmediatamente a partir de otro más importante|

"""

# ╔═╡ 93ffd6e6-0b0b-4f08-835a-73a1f6472392
md"""
## Notación de conjuntos

!!! warning ""
	|Concepto|Notación||
	|:--|:--|:--|
	|Conjunto|$A, B, C$|Colección de elementos agrupados|
	|Complemento de conjunto|$A'$ o $A^{c}$|Elementos que no están en dicho conjunto|
	|Cardinal de conjunto|$\abs{A}$|Cantidad de elementos del conjunto|
	|Conjunto vacío/nulo|$\varnothing$|Conjunto sin elemento alguno|
	|Par ordenado|$X \times Y$|Colección de pares de elementos de otros 2 conjuntos. $(x,y)\neq (y,x)$|
	|Conjunto universal|$U$|Conjunto mayor y externo que contiene a otros conjuntos|
	|Elemento|$a\in A$| $a$ es un elemento de $A$|
	|Subconjunto|$A \subseteq B$|$A$ está incluído en $B$|
	|Subconjunto propio|$A \subset B$|$A$ está incluído en $B$ y al menos un elemento de $B$ no está en $A$|
	|Conjuntos idénticos|$A=B$|Si y solo si $A \subseteq B \;\text{y}\; B \subseteq A$|

- Por convención, el conjunto nulo $\varnothing$ es un subconjunto de cualquier otro conjunto y es un subconjunto propio de cualquier otro conjunto a excepción de sí mismo.

**Número de Subconjuntos**
!!! warning ""
	Sea $n$ el número de elementos de un conjunto, entonces

	| | | |
	|:--|:--|:--|
	|Número de subconjuntos|$2^n$|(incluye al mismo conjunto)|
	|Número de subconjuntos propios|$2^n - 1$|(no incluye al mismo conjunto)|

	- Cada elemento puede estar presente o no en un subconjunto (carácter binario)
	- Si hay $n$ elementos, entonces hay $2^n$ combinaciones posibles para su inclusión o exclusión en un subconjunto
	- Si consideramos solo subconjuntos propios, entonces hay que sustraer el conjunto mismo: $2^n - 1 \quad\blacksquare$
"""

# ╔═╡ 1b555c03-7ed7-4970-9da3-849084f9bac4
md"""
## Operadores Lógicos

!!! warning ""
	| | |
	|:--|:--|
	|$x \in U$|Variable sustituible por cualquier elemento de un conjunto universal|
	|$p_x$|Sentencia abierta transformable en proposición al sustituir algún elemento de $U$|
	|$p$|Proposición (variable sustituida) sujeta a ser **V** o **F**|
	|$\{x:p_x\}=P$|Conjunto de valores $x \in U$ que hacen verdadera a $p_x$|

Por ejemplo

| |Matemática|Lenguaje|Valor de verdad|
|:--|:--|:--|:--|
|$p_x$|$x^3 + x^2 + 2$|$x$ es un miembro del congreso|Neutral|
|$p$|$7^3 + 7^2 + 2$|Juan es un miembro del congreso|**V** o **F**|

**Tablas de verdad**\
Sean $p$ y $q$ proposiciones, los operadores lógicos de `negación`, `conjunción`, `disyunción`, `disyunción exclusiva`, `implicación`, y `equivalencia` tienen las siguientes propiedades

!!! warning ""
	|$p$ |$q$ |$\lnot p$|$p \land q$|$p \lor  q$|$p \underline{\lor}  q$|$p\implies q$|$p \iff  q$|
	|:--:|:--:|:-------:|:---------:|:---------:|:---------:|:-----------:|:---------:|
	|V   |V   |F        |V          |V          |F          |V            |V          |
	|V   |F   |F        |F          |V          |V          |F            |F          |
	|F   |V   |V        |F          |V          |V          |V            |F          |
	|F   |F   |V        |F          |F          |F          |V            |V          |

Un ejemplo de implicación:
- Hay $4$ cartas sobre la mesa $[A], [K], [4], [7]$. Consideremos las proposiciones:
  +  $p$: La carta tiene una vocal en un lado
  +  $q$: La carta tiene un número par en el otro lado
- ¿Qué cartas hay que voltear para comprobar que la regla $p \implies q$ es correcta?

| | | | |
|:--|:--|:--|:--|
|[A]|Obligatorio|$V \implies V$|Si tuviese un número impar, la regla sería incorrecta|
|[K]|Innecesario|$F \implies ?$|La regla no menciona nada acerca de las cartas con consonantes|
|[4]|Innecesario|$? \:\implies V$|Similar al caso anterior, cualquiera de los 2 casos no rompería la regla|
|[7]|Obligatorio|$F \implies F$|Debe tener una consonante para no romper la regla|

**Relación entre operadores lógicos y operaciones con conjuntos**

!!! warning ""
	| | | |
	|:--|:--|:--|
	|Conjunción e Intersección|$\{x:p_x \land q_x\}$|$P \cap Q$|
	|Disyunción y Unión|$\{x:p_x \lor q_x\}$|$P \cup Q$|
	|Disyunción exclusiva|$\{x:p_x \underline{\lor} q_x\}$|$P \oplus Q \longrightarrow P \cup Q - (P \cap Q)$|
	|Negación|$\{x: \lnot p_x \}$|$P'$|

"""

# ╔═╡ 53e04e6e-49e3-49e4-af4c-2af54ad753d3
@svg let
	Drawing(655, 250, "my-drawing.svg")
	#background("#acbfcf")
	origin()
	r = 45
	Δx = 130
	Δy = 70
	circles = [
		[(O + (-Δx, -Δy), r), (O + (-Δx+r, -Δy), r)],
		[(O + (Δx, -Δy), r), (O + (Δx-r, -Δy), r)],
		[(O + (-Δx, Δy), r), (O + (-Δx+r, Δy), r)]
	]

	setline(1)
	for i in 1:3
		Luxor.circle(circles[i][1]... , :stroke)
		Luxor.circle(circles[i][2]... , :stroke)
	end
	
	sethue("#CD5C5C")
	# Intersection
	Luxor.circle(circles[1][1]... , :clip)
	Luxor.circle(circles[1][2]... , :fill)
	clipreset()
	
	# Union
	Luxor.circle(circles[2][1]... , :fill)
	Luxor.circle(circles[2][2]... , :fill)
	clipreset()
	sethue("black")
	Luxor.circle(circles[2][1]... , :stroke)
	Luxor.circle(circles[2][2]... , :stroke)
	sethue("#CD5C5C")
	
	# XOR
	Luxor.circle(circles[3][1]... , :fill)
	Luxor.circle(circles[3][2]... , :fill)
	sethue("white")
	Luxor.circle(circles[3][2]... , :clip)
	Luxor.circle(circles[3][1]... , :fill)
	clipreset()
	sethue("black")
	Luxor.circle(circles[3][1]... , :stroke)
	Luxor.circle(circles[3][2]... , :stroke)
	sethue("#CD5C5C")
	clipreset()

	# Complement
	sethue("#CD5C5C")
	box(O + (105, 70), 120, 100, 2, :fill)
	sethue("black")
	box(O + (105, 70), 120, 100, 2, :stroke)
	sethue("white")
	Luxor.circle(O + (105, 70), 45, :fill)
	sethue("black")
	Luxor.circle(O + (105, 70), 45, :stroke)
	
end

# ╔═╡ ca26f2cc-d073-4238-8246-fdd17b7083e9
md"""
!!! warning ""
	| | | |
	|:--|:--|:--|
	|Implicación|$\{x:p_x \implies q_x\}$|$P' \cup Q$|

- Para que una implicación sea **V** es suficiente que el antecedente sea **F** o que el consecuente sea **V**.
- Si $P$ es el conjunto de valores que hacen **V** a $p_x$, entonces $P'$ son los valores que la hacen **F**.
- Del mismo modo, $Q$ son aquellos valores que hacen **V** a $q_x$.
- Por lo tanto, la unión de $P'$ y $Q$ satisfacen la implicación. $\;\blacksquare$
"""

# ╔═╡ bda8ecbf-6ecd-458a-b9e1-a6c1a39a6efe
@svg let
	Drawing(655, 150, "my-drawing.svg")
	#background("#acbfcf")
	origin()
	c1 = (O + (-25, 0), 50)
	c2 = (O + (+25, 0), 50)
	setline(1)
	sethue("#CD5C5C")
	Luxor.box(O, 180, 120, :fill)
	sethue("black")
	Luxor.box(O, 180, 120, :stroke)
	sethue("white")
	Luxor.circle(c1..., :fill)
	sethue("black")
	Luxor.circle(c1..., :stroke)
	Luxor.circle(c2..., :stroke)
end

# ╔═╡ 35e711de-88e4-40b5-a6eb-19abef79e1c0
md"""
!!! warning ""
	| | | |
	|:--|:--|:--|
	|Equivalencia|$\{x:p_x \iff q_x\}$|$(P \cap Q) \cup (P' \cap Q')$|

- Para que la bicondicional o equivalencia sea **V**, es suficiente que $p_x$ y $q_x$ sean
  + Ambos **V** $\longrightarrow P \cap Q$
  + Ambos **F** $\longrightarrow P' \cap Q'$
- La unión de ambas condiciones satisface la equivalencia. $\;\blacksquare$

"""

# ╔═╡ c2966107-aec1-43a9-a349-3b2cd0256929
@svg let
	Drawing(655, 150, "my-drawing.svg")
	#background("#acbfcf")
	origin()
	c1 = (O + (-25, 0), 50)
	c2 = (O + (+25, 0), 50)
	setline(1)
	sethue("#CD5C5C")
	Luxor.box(O, 180, 120, :fill)
	sethue("black")
	Luxor.box(O, 180, 120, :stroke)
	sethue("white")
	Luxor.circle(c1..., :fill)
	Luxor.circle(c2..., :fill)
	sethue("#CD5C5C")
	Luxor.circle(c1..., :clip)
	Luxor.circle(c2..., :fill)
	clipreset()
	sethue("black")
	Luxor.circle(c1..., :stroke)
	Luxor.circle(c2..., :stroke)
end

# ╔═╡ 9cb72111-51f8-4484-9720-5870510d8525
md"""
## Equivalencias, Tautologías y Negaciones
**Fórmulas Proposicionales**

Son expresiones que contienen un número finito de proposiciones variables ($p, q, r, etc.$) y un número finito de operadores lógicos, e.g.

$(p \land q) \lor (\lnot p \land \lnot q)$

Se convierten en proposiciones cuando otras proposiciones específicas son sustituidas por las variables (i.e. al reemplazar **V** o **F** por $p$ o $q$). Ahora, consideremos

|$p$|$q$|$p \land q$|$\lnot p \land \lnot q$|$(p \land q) \lor (\lnot p \land \lnot q)$|$p \iff q$|
|:--:|:--:|:--:|:--:|:--:|:--:|
|V|V|V|F|V|V|
|V|F|F|F|F|F|
|F|V|F|F|F|F|
|F|F|F|V|V|V|

Notemos que las expresiones de las 2 últimas columnas de la tabla tienen los mismos valores de verdad. Si relacionáramos ambas fórmulas con el operador $\iff$ obtendríamos una nueva fórmula cuyos valores serían únicamente valores verdaderos.

!!! warning ""
	Una fórmula que se convierte en una proposición verdadera al reemplazar cualquier proposición específica (**V** o **F**) por sus variables se denomina **Tautología**.

!!! warning ""
	Si al evaluar dos fórmulas con el operador $\iff$ obtenemos una tautología, entonces las fórmulas son **equivalentes**.

**Equivalencias y Negaciones importantes**

Las siguientes equivalencias son intuitivas, pero pueden ser comprobadas utilizando tablas de verdad. 
!!! warning ""
	| | | | |
	|:--|:--:|:--|:--|
	|$p \land (q \land r)$|$\iff$|$p \land q \land r$|
	|$p \lor (q \lor r)$|$\iff$| $p \lor q \lor r$|
	|$p \land (q \lor r)$|$\iff$|$(p \land q) \lor (p \land r)$|
	|$p \lor (q \land r)$|$\iff$|$(p \lor q) \land (p \lor r)$|
	|$\lnot(\lnot p)$|$\iff$|$p$|Ley de doble negación|
	|$\lnot(p \land q)$|$\iff$|$\lnot p \lor \lnot q$|1ra Ley de Morgan|
	|$\lnot(p \lor q)$|$\iff$|$\lnot p \land \lnot q$|2da Ley de Morgan|

- Recordemos que la implicación será siempre verdadera cuando el antecedente sea **F** o cuando el consecuente sea **V**, de modo que $\lnot(\lnot p \lor q)$ representa la negación de la implicación.
- Del mismo modo, la equivalencia es siempre verdadera cuando ambas proposiciones tienen el mismo valor de verdad. Negar esta condición representa la negación de la equivalencia.
!!! warning ""
	| | | | |
	|:--|:--:|:--|:--|
	|$\lnot(p \implies q)$|$\iff$|$p \land \lnot q$| |
	|$\lnot(p \iff q)$|$\iff$|$(\lnot p \land q) \lor (p \land \lnot q) = p \underline{\lor} q$ | |
	|$\lnot(p \underline{\lor} q)$|$\iff$|$p \iff q$|

"""

# ╔═╡ a5d20484-d540-4187-b5d1-eb19fcc6896e
md"""
**Contraposición, Inversión, Conversión**

Consideremos las siguientes fórmulas

|$p$|$q$|$(p \implies q)$|$(q \implies p)$|$(\lnot p \implies \lnot q)$|$(\lnot q \implies \lnot p)$|
|:--:|:--:|:--:|:--:|:--:|:--:|
|V|V|V|V|V|V|
|V|F|F|V|V|F|
|F|V|V|F|F|V|
|F|F|V|V|V|V|

Podemos notar que

!!! warning ""
	| | | | | | |
	|:--|:--:|:--:|:--|:--:|:--|
	|Implicación|$p \implies q$|y|Contraposición |$\lnot q \implies \lnot p$|son equivalentes|
	|Inversión |$\lnot p \implies \lnot q$|y|Conversión |$q \implies p$|son equivalentes|
	
Ejemplo: Asumamos que las siguientes expresiones son verdaderas:
- "Al menos la caja [1] está en el grupo $A$"
- "Hay otros grupos con al menos una caja, distinta(s) a [1]"
- "Existe un elemento $a$ que debe estar obligatoriamente dentro de cualquier caja, en cualquier grupo"
Son notorios 2 casos particulares: El grupo A solo tiene una caja o el grupo A tiene más de una caja.
"""

# ╔═╡ 4a1df8b3-62ef-4e08-88e6-0d3b9001d51d
let
	fig = plot(layout=grid(1,2), size=(750, 200), axis=false, xticks=[], yticks=[], titlefontsize=11)
	# Caso 1
	plot!(fig[1], rectangle(0,0,2.5,2.5), line=(1, :black), fillcolor=:white, title="Caso 1")
	plot!(fig[1], rectangle(2.5,0,2.5,2.5), line=(1, :black), fillcolor=:white)
	plot!(fig[1], rectangle(0.5,1,0.5,0.5), line=(1, :black), fillcolor=:white)
	plot!(fig[1], rectangle(0.5 + 2.5,1,0.5,0.5), line=(1, :black), fillcolor=:white)
	annotate!(fig[1], 1.25, 2.25, Plots.text("\$A \\rightarrow |A| = 1\$", 11))
	annotate!(fig[1], 1.25 + 2.5, 2.25, Plots.text("\$B \\rightarrow |B| \\geq 1\$", 11))
	annotate!(fig[1], 1.5 + 2.4, 1.25, "\$...\$")
	annotate!(fig[1], 0.75, 1.7, Plots.text("\$1\$", 10))
	# Caso 2
	plot!(fig[2], rectangle(0,0,2.5,2.5), line=(1, :black), fillcolor=:white, title="Caso 2")
	plot!(fig[2], rectangle(2.5,0,2.5,2.5), line=(1, :black), fillcolor=:white)
	plot!(fig[2], rectangle(0.5,1,0.5,0.5), line=(1, :black), fillcolor=:white)
	plot!(fig[2], rectangle(1.25,1,0.5,0.5), line=(1, :black), fillcolor=:white)
	plot!(fig[2], rectangle(0.5 + 2.5,1,0.5,0.5), line=(1, :black), fillcolor=:white)
	annotate!(fig[2], 1.25, 2.25, Plots.text("\$A \\rightarrow |A| > 1\$", 11))
	annotate!(fig[2], 1.25 + 2.5, 2.25, Plots.text("\$B \\rightarrow |B| \\geq 1\$", 11))
	annotate!(fig[2], 2.1, 1.25, "\$...\$")
	annotate!(fig[2], 1.5 + 2.4, 1.25, "\$...\$")
	annotate!(fig[2], 0.75, 1.7, Plots.text("\$1\$", 10))
	annotate!(fig[2], 1.5, 1.7, Plots.text("\$2\$", 10))
	center_div(fig)
end

# ╔═╡ 9aae0205-493a-43b9-9954-9204f186cca3
md"""
|| |Caso 1|Caso 2| |
|:--|:--:|:--:|:--:|:--
|Implicación |$a \in \boxed{1} \implies a \in A$|V|V|Ya que [1] siempre está en $A$|
|Conversión |$a \in A \implies a \in \boxed{1}$|V|F|En el caso 2, $a$ podría estar en [2]|
|Inversión |$a \not\in \boxed{1} \implies a \not\in A$|V|F|*IDEM*|
|Contraposición |$a \not\in A \implies a \not\in \boxed{1}$|V|V|Ya que [1] siempre está en $A$|

Tanto la implicación como la contraposición resultan ser siempre ciertas.
"""

# ╔═╡ 4897d1f5-473d-41ec-9d9c-d74089de0c40
md"""
## Cuantificadores
!!! warning ""
	| | | |
	|:--|:--|:--|
	|$\forall_x p_x \iff \{x:p_x\}=U$|"Para todos los $x \in U$, se cumple $p_x$"|
	|$\exists_x p_x \iff \{x:p_x\} \neq \varnothing$|"Existe al menos un $x$ tal que $p_x$"|
	|$\forall_x(p_x \implies (q_x \land r_x))$| Cuantificación de una fórmula|
	|$\forall_x p_{x,y}$|Cuantificador con más de una variable (en este caso, una ligada y una libre)|

Al usar más de un cuantificador, el orden de los símbolos tiene gran importancia sobre la lógica que se desea representar

$\forall_x\exists_y p_{x,y} \not\equiv \exists_y\forall_x p_{x,y}$
"""

# ╔═╡ 95db3ced-b1f9-44e6-a7c5-5d74118f81fc
let
	fig = plot(layout=grid(1,2), size=(500, 125), axis=false, xticks=[], yticks=[])
	points_x = [0,0,0]
	points_y = [2,0,-2]
	scatter!(fig[1], points_x, points_y, marker=(5, :black), right_margin=10Plots.mm)
	scatter!(fig[1], points_x .+ 1, points_y, marker=(5, :black))
	for i in 1:3
		plot!(fig[1], [points_x[i], points_x[i]+1], [points_y[i], points_y[i]], line=(1, :black))
	end
	scatter!(fig[2], [0], [0], marker=(5, :black), left_margin=10Plots.mm)
	scatter!(fig[2], points_x .+ 1, points_y, marker=(5, :black))
	for i in 1:3
		plot!(fig[2], [points_x[i], points_x[i]+1], [points_y[2], points_y[i]], line=(1, :black))
	end
	center_div(fig)
end

# ╔═╡ dc282281-70ae-4fd7-8179-33d640b10953
md"""
**Suficiencia y Necesidad**
"""

# ╔═╡ 81ac5764-715e-4717-9ede-21e6603efe0f
let
	fig = plot(size=(220, 200), axis=false, xticks=[], yticks=[])
	plot!(rectangle(-7,-6, 14,12), line=(1, :black), fillcolor=:white)
	plot!(circle(0, 0, 5), line=(1, :black))
	plot!(circle(0, 0, 2.5), line=(1, :black))
	annotate!(0,0,L"P")
	annotate!(1.5,3.5,L"Q")
	annotate!(-5, 4.5,L"Q'")
	center_div(fig)
end

# ╔═╡ bad9af88-c129-44fc-b794-453e07c1865f
md"""
Del gráfico es fácil notar que
!!! warning ""
	| | |
	|:--|:--|
	|$P \subseteq Q$|$\implies P \cap Q = P$|
	|$P \subseteq Q$|$\implies P \cup Q = Q$|

Y que además

!!! warning ""
	$\forall_x(p_x \implies q_x) \iff P \subseteq Q \implies (P \cap Q') = \varnothing$

| | |
|:--|:--|
|Si $p_x$ entonces $q_x$| $p_x$ es suficiente para $q_x$|
|$q_x$ ya que $p_x$| $q_x$ es necesario para $p_x$

Ejemplos:

- "El hecho de que $x$ sea un cuadrado es condición suficiente para que sea un cuadrilátero"
- "Es necesario que $x$ sea mayor de edad para ser votatante (pero no es suficiente)"

Por otro lado

!!! warning ""
	$\forall_x(p_x \iff q_x) \iff (P \subseteq Q \land Q \subseteq P) \implies P=Q$


| | |
|:--|:--|
|$p_x$ si y solo si $q_x$|$p_x$ es necesario y suficiente para $q_x$|
|$q_x$ si y solo si $p_x$| $q_x$ es necesario y suficiente para $p_x$|
"""

# ╔═╡ e27576b3-aaff-40f4-b74a-68cf6ca3679d
md"""
**Equivalencias y negación de expresiones con cuantificadores**

!!! warning ""
	| | | |
	|:--|:--|:--|
	|$\forall_x p_x$|$\lnot(\exists_x \lnot p_x)$|Es falso que exista algún $x$ para el cual no se cumpla $p_x$|
	|$\exists_x p_x$|$\lnot(\forall_x \lnot p_x)$|Es falso que para todos los $x$ se cumpla no $p_x$|
	|$\lnot\forall_x p_x$|$\exists_x \lnot p_x$|Existe al menos un $x$ para el que no se cumple $p_x$|
	|$\lnot\exists_x p_x$|$\forall_x \lnot p_x$|Para todos los $x$ se cumple que no $p_x$|
	|$\lnot[\forall_x(p_x \implies q_x)]$|$\exists_x(p_x \land \lnot q_x)$|Contradictorias (Lógica Aristotélica) |
	|$\lnot[\exists_x(p_x \land q_x)]$|$\forall_x(p_x \implies \lnot q_x)$|Contradictorias (Lógica Aristotélica) |

"""

# ╔═╡ 50880025-f46c-4f0e-bc2a-02f67296b148
md"""
# Sistemas de Números y Propiedades
## Números Reales

!!! warning ""
	 Sistema|Símbolo|Descripción|
	|:--|:--:|:--|
	|Naturales|$\mathbb{N}$|Utilizados en el conteo natural (incluiremos al cero) |
	|Enteros|$\mathbb{Z}$|Aquellos sin componente fraccional o parte decimal|
	|Racionales|$\mathbb{Q}$|Aquellos que pueden expresarse de la forma $\frac{p}{q}$, donde $p,q\in\mathbb{Z}$. Su expansión decimal es finita o infinita repetible|
	|Irracionales|$\mathbb{R - Q}$|No pueden ser expresados de la forma anterior y su expansión decimal es infinita e irrepetible|
	|Reales|$\mathbb{R}$|Incluye a todos los conjuntos anteriores|

**Relación de conjuntos**

!!! warning ""
	$\mathbb{N} \subset \mathbb{Z} \subset \mathbb{Q} \subset \mathbb{R}$

**$\sqrt{2}$ es irracional**\
Demostración por contradicción:
- Asumamos que $\sqrt{2}$ es racional, entonces puede expresarse de la forma $\frac{p}{q}$, donde $p,q\in\mathbb{Z}$, $q\neq 0$, y ambos son no pares.
-  $\text{(Par)(Par)} =  2(n+1)2(m+1) = 2(...)= \text{Par}$
-  $\text{(Impar)(Impar)} = (2n+1)(2m+1) = 4nm + 2n + 2m + 1 = 2(...)+1 = \text{Impar}$
-  $\text{(Par)(Impar)} =  2(n+1)(2m+1) = 2(...) = \text{Par}$ 
-  $\implies q\sqrt{2}=p \implies q^{2}2=p^2 \implies p^2 \text{es par} \implies p \text{ es par} \implies p=2a$
-  $q^{2}2=(2a)^2=4a^2 \implies q^2 \text{ es par} \implies q \text{ es par}$
-  $\implies p, q \text{ son pares} \implies \text{Contradicción} \implies \sqrt{2} \text{ es irracional} \quad \blacksquare$
"""

# ╔═╡ 6b759f88-ddac-4fcb-ad21-2c07331e9cc1
md"""
## Propiedades de los números
**Adición y Sustracción:**

!!! warning ""
	 | |
	|:--|:--|
	|1) |  $\; a + b = b + a$|
	|2) |  $\; a+(-a)=(-a)+a=0$|
	|3) |  $\; a+0=0+a=a$|
	|4) |  $\; a + (b + c) = (a + b) + c$|


La expresión $a + (-b)$ puede ser abreviada como $a - b$.\
**Multiplicación y División:**

!!! warning ""
	 | |
	|:--|:--|
	|5) | $\; a \cdot(b \cdot c) = (a \cdot b)\cdot c$|
	|6) | $\; a \cdot 1 = 1\cdot a = a$|
	|7) | $\; a \cdot a^{-1} = a^{-1} \cdot a = 1$|
	|8) | $\; a \cdot b = b \cdot a$|

Definiremos a la división $a/b$ como $a \cdot b^{-1}$. La expresión $0^{-1}$ no está definida, i.e. $a/0$ no está definida.\
Notemos que si $a\neq 0$, entonces $a\cdot b= a\cdot c \implies b = c$, sin embargo si $a=0$, el consecuente anterior no es necesariamente verdadero.\

**Combinando Multiplicación y Adición $\longrightarrow$ Ley Distributiva**

!!! warning ""
	 | |
	|:--|:--|
	|9) | $\; a \cdot (b + c) = a \cdot b + a \cdot c$|

**Inecuaciones**\
Sea $\mathbb{P}$ la colección de números positivos y $a,b$ dos números cualesquiera, entonces

!!! warning ""
	 | |
	|:--|:--|
	|10) | Solo una expresión puede ser verdadera: $\quad a = 0, \quad a \in \mathbb{P}, \quad  -a \in \mathbb{P} \quad$|
	|11) | $a,b>0 \implies a+b>0$| 
	|12) | $a,b>0 \implies a \cdot b>0$|

Algunos complementos:

$\begin{align}
a - b > 0  &\implies a > b \\
a>b &\implies b<a \\
a \geq b &\implies a > b \;\lor\; a = b\\
\end{align}$

**Exponentes**

!!! warning ""
	 | |
	|:--|:--|
	|13) | $a^m a^n = a^{m+n}$|
	|14) | $(a^m)^n = a^{mn}$|
"""

# ╔═╡ ea213fc8-91ff-491a-8f9e-b4a1c893e9a4
md"""
## Propiedades de las inecuaciones
Estas son consecuencias inmediatas de las propiedades anteriores. Sean $a, b, c$ números reales cualesquiera, entonces:

!!! warning ""
	| | |
	|:--|--:|
	|**1)** $a > b \implies a + c > b + c$|$\begin{align}a > b &\implies a - b > 0 \\&\implies a - b + c - c > 0 \\&\implies (a + c) - (b+c)  > 0 \\&\implies  a + c > b + c \quad\blacksquare\end{align}$|
	| | |
	|**2)** $a>b \;\land\;b>c \implies a > c$|$\begin{align}a > b \;\land\; b > c &\implies a - b > 0 \;\land\; b - c > 0 \\&\implies a - b + b - c > 0 \\&\implies a - c > 0 \implies a > c \quad\blacksquare\end{align}$|
	| | |
	|**3)** $a>b \;\land\; c>0 \implies ac > bc$|$\begin{align}a > b \;\land\; c>0 &\implies a - b > 0 \\ &\implies c\cdot(a - b) > c\cdot 0 \\ &\implies ac - bc > 0 \implies ac > bc \quad\blacksquare \end{align}$|
	| | |
	|**4)** $a>b \;\land\; c<0 \implies ac < bc$|$\begin{align} a > b \;\land\; c<0 &\implies a - b > 0 \\ &\implies c\cdot(a - b) < 0\\ &\implies ac - bc < 0 \implies ac < bc \quad\blacksquare \end{align}$|
	| | |
	|**5)** $a <0 \;\land\; b<0 \implies (-a)(-b)>0$|$\begin{align} a <0 \;\land\; b<0 &\implies -a>0 \;\land\; -b>0 \\ &\implies (-a)(-b)>0 \quad\blacksquare \end{align}$|
	| | |
	|**5)** $a^2>0$| $\begin{align} a >0 \;\lor\; a<0 &\implies (a)(a)>0 \;\lor\; (-a)(-a)>0 \\ &\implies a^2>0 \quad\blacksquare \end{align}$|
	| | |
	|**7)** $\displaystyle\frac{a}{b}<\frac{c}{d} \implies ad < cb \iff b,d>0$| $\begin{align} \frac{a}{b}>\frac{c}{d} \;\land\; b,d>0 &\implies \frac{a}{b}bd<\frac{c}{d}bd\\ &\implies ad < cb \quad\blacksquare \end{align}$|
	| | |
	|**8)** $a<b \;\land\; a>0 \implies a^n < b^n$| $\begin{align} &\implies a^2 < ab \;\land\; ab < b^2 \\ &\implies a^2 < b^2 \\ &\implies a^3 < ab^2 \;\land\; ab^2 < b^3 \\ &\implies a^3 < b^3 \\ &\implies ... \\ &\implies a^n < b^n \quad\blacksquare \end{align}$|
"""

# ╔═╡ cbe6c085-cdb1-4794-87e5-c21cc9735f3c
md"""
## Números Complejos

!!! warning ""
	Se define $\sqrt{-1}=i$ como *unidad imaginaria*. Notemos que $i^2=-1$

!!! warning ""
	|Sistema|Símbolo|Descripción|
	|:--|:--:|:--|
	|Imaginarios|$\mathbb{C}$ - $\mathbb{R}$|Número real multiplicado por $i$, e.g. $i, 5i$|
	|Complejos|$\mathbb{C}$|Formados por una parte real y una parte imaginaria, e.g.  $z_1 = 3 + 2i, z_2=17.02+0i$|
"""

# ╔═╡ 3bac8723-bf25-42f2-a12e-b48381e6baf2
begin
	a = md"""
	![setup of the tower of a hanoi](https://i.imgur.com/xgazUqJ.png)
	"""
	center_div(a)
end

# ╔═╡ d3782025-d4c5-44ac-b285-987721e164be
md"""
**Operaciones con números complejos**\
Sean los números complejos $z_{1} = x + ai \;\land\; z_2 = y + bi$

!!! warning ""
	| |  |
	|:--|:--|
	|Adición y Sustracción|$\begin{align} z_1 \pm z_2 &= (x \pm y) + (a \pm b)i \end{align}$|
	| | |
	|Multiplicación|$\begin{align} z_1 \cdot z_2 &= (x+ai)(y+bi) \\ &= xy + xbi + yai + abi^2 \\ &= (xy - ab) + (xb + ya)i \end{align}$|
	| | |
	|División|$\begin{align} \frac{z_1}{z_2} &= \frac{x+ai}{y+bi} \\ &= \left(\frac{x+ai}{y+bi}\right)\left(\frac{y-bi}{y-bi}\right) \\ &= \frac{xy - xbi + yai + ab}{y^2 + b^2} \\ &= \frac{xy + ab}{y^2 + b^2} + \frac{ya - xb}{y^2 + b^2}\cdot i \end{align}$|

**Operaciones con números imaginarios**\
Utilizando la notación de números complejos podemos expresar dos números imaginarios de la forma $z_{1} = 0 + ai \land z_{2} = 0 + bi$, de esta forma obtenemos
!!! warning ""
	| |  | |
	|:--|:--|:--|
	|Adición y Sustracción|$\begin{align} z_1 \pm z_2 &= (a \pm b)i \end{align}$|
	| | |
	|Multiplicación|$\begin{align} z_1 \cdot z_2 &= -ab \end{align}$|$\implies z_1 \cdot z_2 \in \mathbb{R}$|
	| | |
	|División|$\begin{align} \frac{z_1}{z_2} &= \frac{ab}{b^2} \end{align}$|$\implies \frac{z_1}{z_2} \in \mathbb{R}$|

!!! asd ""
	Notemos que la ecuación $z^2 = -1$ puede resolverse utilizando números complejos. Sea $z\in\mathbb{C}$

	$\begin{align}
	z^2 &= -1 \\
	(x+ai)(x+ai) &= -1 \\
	&\implies z=1i \;\lor\; z=-1i
	\end{align}$


**Conjugados y Opuestos, Representación en el plano**\
Sea $z = x + ai$ un número complejo, entonces
!!! warning ""
	| | |
	|:--|:--:|
	|Conjugado| $\overline{z} = x - ai$|
	|Opuesto| $-z = -x - ai$|
Los números complejos pueden representarse en un plano donde el eje vertical contiene las unidades imaginarias y el eje horizontal contiene los números reales.
"""

# ╔═╡ 9b8d451d-d9a4-4a14-b364-3563d871f5b5
let
	p = scatter([3,3,-3], [2,-2,-2], framestyle=:origin, size=(400,200), marker=(:black),
		xticks=([-3,3], ["\$ -x \$","\$ x \$"]), yticks=([-2,2], ["\$ -ai \$","\$ ai \$"]),
		tickfontsize=12,		
		xlims=[-5,5], ylims=[-3,3])
	plot!([0,3],[0,2], line=(:black, 1.5))
	plot!([0,3],[0,-2], line=(:black, :dash, 1.5))
	plot!([0,-3],[0,-2], line=(:black, :dash, 1.5))
	annotate!(3.5,2, Plots.text("\$ x + ai \$", :left))
	annotate!(3.5,-2, Plots.text("\$ x - ai \$", :left))
	annotate!(-3.5,-2, Plots.text("\$ -x - ai \$", :right))
	center_div(p)
end

# ╔═╡ dfca7b42-8e30-40d8-85b9-bfd933323f69
md"""
**Distancia desde el Origen**\
Notemos que

$\begin{align}
z\cdot \overline{z} &= (x+ai)(x-ai) \\
	&= x^2 -xai + xai + a^2 \\
	&= x^2 + a^2
\end{align}$

Sea $|z|$ la distancia desde el origen, entonces 

!!! warning ""
	$|z|^2 = z\cdot \overline{z} \implies |z| = \sqrt{z\cdot \overline{z}}$

**Inverso Multiplicativo**\
Del procedimiento anterior obtenemos

!!! warning ""
	$\frac{1}{z} = \frac{\overline{z}}{x^2+a^2} \implies z\left(\frac{\overline{z}}{x^2+a^2}\right) = 1$

"""

# ╔═╡ 82ca28bf-93d1-4149-8e12-8c172e817b5e
md"""
**Referencias**

|Autor(es)|Libro|Año||
|:--|:--|:--:|:--:|
|Serge Lang|Basic Mathematics|1971||
|C. Allendoerfer & C. Oakley|Principles of Mathematics (2nd ed.)|1963| |
|Michael Spivak|Calculus (4th ed.)|2008|🔨|
|Tom M. Apostol|Calculus Vol. 1 (2nd ed.)|1967|🔨|

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Formatting = "59287772-0a20-5a39-b81b-1366585eb4c0"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Luxor = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Formatting = "~0.4.2"
HypertextLiteral = "~0.9.3"
LaTeXStrings = "~1.3.0"
Luxor = "~3.2.0"
Plots = "~1.27.4"
PlutoUI = "~0.7.38"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "5002d1ed3f641a159100035337b44855f372d000"

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

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "d0b3f8b4ad16cb0a2988c6788646a5e6a17b6b1b"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.0.5"

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

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "80ced645013a5dbdc52cf70329399c35ce007fae"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.13.0"

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

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "1c5a84319923bea76fa145d49e93aa4394c73fc2"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.1"

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

[[deps.Juno]]
deps = ["Base64", "Logging", "Media", "Profile"]
git-tree-sha1 = "07cb43290a840908a771552911a6274bc6c072c7"
uuid = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
version = "0.8.4"

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
git-tree-sha1 = "6f14549f7760d84b2db7a9b10b88cd3cc3025730"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.14"

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

[[deps.Librsvg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pango_jll", "Pkg", "gdk_pixbuf_jll"]
git-tree-sha1 = "25d5e6b4eb3558613ace1c67d6a871420bfca527"
uuid = "925c91fb-5dd6-59dd-8e8c-345e74382d89"
version = "2.52.4+0"

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

[[deps.Luxor]]
deps = ["Base64", "Cairo", "Colors", "Dates", "FFMPEG", "FileIO", "Juno", "LaTeXStrings", "Random", "Requires", "Rsvg"]
git-tree-sha1 = "156958d51d9f758dc5a00dcc6da4f61cacf579ed"
uuid = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
version = "3.2.0"

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

[[deps.Media]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "75a54abd10709c01f1b86b84ec225d26e840ed58"
uuid = "e89f7d12-3494-54d1-8411-f7d8b9ae1f27"
version = "0.5.0"

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
git-tree-sha1 = "b086b7ea07f8e38cf122f5016af580881ac914fe"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.7"

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

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a121dfbba67c94a5bec9dde613c3d0cbcf3a12b"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.50.3+0"

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
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "bb16469fd5224100e422f0b027d26c5a25de1200"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.2.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "edec0846433f1c1941032385588fd57380b62b59"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.27.4"

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

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

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

[[deps.Rsvg]]
deps = ["Cairo", "Glib_jll", "Librsvg_jll"]
git-tree-sha1 = "3d3dc66eb46568fb3a5259034bfc752a0eb0c686"
uuid = "c4c386cf-5103-5370-be45-f3a111cca3b8"
version = "1.0.0"

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

[[deps.gdk_pixbuf_jll]]
deps = ["Artifacts", "Glib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg", "Xorg_libX11_jll", "libpng_jll"]
git-tree-sha1 = "c23323cd30d60941f8c68419a70905d9bdd92808"
uuid = "da03df04-f53b-5353-a52f-6a8b0620ced0"
version = "2.42.6+1"

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
# ╟─cc3486b0-b105-11ec-074b-01dadc9cf21e
# ╟─9f30378f-aa8c-432e-bbb2-eb7d076c480d
# ╟─75b23021-18e0-471c-a9bb-7eb0abaa9098
# ╠═86fbf5cd-d09e-43ba-b272-12c1cc5d865a
# ╟─da295bc8-6707-4873-8efe-2b9caede2555
# ╟─21160fc7-cf58-4c9a-b5af-f8e6af0ef5f6
# ╟─93ffd6e6-0b0b-4f08-835a-73a1f6472392
# ╟─1b555c03-7ed7-4970-9da3-849084f9bac4
# ╟─53e04e6e-49e3-49e4-af4c-2af54ad753d3
# ╟─ca26f2cc-d073-4238-8246-fdd17b7083e9
# ╟─bda8ecbf-6ecd-458a-b9e1-a6c1a39a6efe
# ╟─35e711de-88e4-40b5-a6eb-19abef79e1c0
# ╟─c2966107-aec1-43a9-a349-3b2cd0256929
# ╟─9cb72111-51f8-4484-9720-5870510d8525
# ╟─a5d20484-d540-4187-b5d1-eb19fcc6896e
# ╟─4a1df8b3-62ef-4e08-88e6-0d3b9001d51d
# ╟─9aae0205-493a-43b9-9954-9204f186cca3
# ╟─4897d1f5-473d-41ec-9d9c-d74089de0c40
# ╟─95db3ced-b1f9-44e6-a7c5-5d74118f81fc
# ╟─dc282281-70ae-4fd7-8179-33d640b10953
# ╟─81ac5764-715e-4717-9ede-21e6603efe0f
# ╟─bad9af88-c129-44fc-b794-453e07c1865f
# ╟─e27576b3-aaff-40f4-b74a-68cf6ca3679d
# ╟─50880025-f46c-4f0e-bc2a-02f67296b148
# ╟─6b759f88-ddac-4fcb-ad21-2c07331e9cc1
# ╟─ea213fc8-91ff-491a-8f9e-b4a1c893e9a4
# ╟─cbe6c085-cdb1-4794-87e5-c21cc9735f3c
# ╟─3bac8723-bf25-42f2-a12e-b48381e6baf2
# ╟─d3782025-d4c5-44ac-b285-987721e164be
# ╟─9b8d451d-d9a4-4a14-b364-3563d871f5b5
# ╟─dfca7b42-8e30-40d8-85b9-bfd933323f69
# ╟─82ca28bf-93d1-4149-8e12-8c172e817b5e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
