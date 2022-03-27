### A Pluto.jl notebook ###
# v0.18.4

using Markdown
using InteractiveUtils

# ╔═╡ bb89dbf6-aac6-4b86-949f-15d293f9fe33
using HypertextLiteral

# ╔═╡ d21bb6ba-3fff-425b-9963-e17b1c2980fe
using PlutoUI,Random

# ╔═╡ 8e85528f-87b5-40e5-856e-bbc53d0b3386
@htl("""
Notebook Size & Color Settings
	<style> main { max-width: 800px; } </style>
	<style> .rich_output {color: green;}</style>
	""")

# ╔═╡ 3d1336b7-ef09-4097-9934-beab70188a4c
html"""
Other Size & Color Settings
<!-- Change background color of output cells -->
<style> pluto-output:not(.rich_output) { background-color: rgb(255, 254, 250);}</style>

<!-- Set new max-width, handles window reduction. Thought not efficiently -->
<!-- <style>main {max-width: 1000px;}</style> --> 

<!-- Set new max-height of output cells. Haven't tested -->
<!-- <style>pluto-output.scroll_y {max-height: 2000px;}</style> -->

"""

# ╔═╡ 1d3d6267-3e60-4b00-a970-c8a5a1f891cc
TableOfContents(title="Arrays")

# ╔═╡ d0d503d5-9125-4eb7-bc27-a8d9a8107a5e
md"""
# Types:
"""

# ╔═╡ feb0138f-ea46-4e85-9e3f-607906f8efb1
md"""
## Hierarchy and dimensions
"""

# ╔═╡ 1e6a5c57-1793-4604-83da-d86a0deb8a7a
md"""
**Array{T, N}** is a N-dimensional **DenseArray** with elements of type T. DenseArray has other subtypes, but we'll be using only Array for now.
"""

# ╔═╡ 57bbc2f8-3538-4766-b064-cfb609729583
supertype(Array)

# ╔═╡ 40a8fede-a14e-43f9-b159-637bad13e753
supertype(DenseArray) # DenseArray belongs to the AbstractArray type

# ╔═╡ a06408d9-e21f-4741-91e2-7435d4aa3af5
supertype(AbstractArray) # AbstractArray is the highest array type

# ╔═╡ 64270074-23af-4da0-af93-9c20e9c35f00
md"""
Array{ } has no subtypes but alliases (see vectors/matrices section)
"""

# ╔═╡ 0e32a99d-6d09-4084-8e80-51ac250ac311
subtypes(Array{})

# ╔═╡ eae5ba7c-9783-4416-a298-2ff7e43b219c
md"""
- Array{T, 1} are called **Vectors**
- Array{T, 2} are called **Matrices**
- Array{T, 3} (or >3) are simply called Arrays
"""

# ╔═╡ bb936765-9472-4fdc-8e9d-15d25c831a59
md"""
## Uninitialized Arrays
"""

# ╔═╡ de357118-a894-45ad-a72b-62c7cecdb2e0
md"""
Mostly used for bug/error avoidance and better performance for algorithms. Syntax:
"""

# ╔═╡ 5b67de5f-2fcf-45a5-83d7-eeb8fdfd04b9
md"""
```julia
Array{T,N}(singleton_initializer, dims)
Array{T}(singleton_initializer, dims) # defaults to N=1
```
"""

# ╔═╡ c05cd818-df39-4528-9a98-093eb87bcdcb
# let is used to locally define variables and avoid global definitions
let A = Array{Int64, 2}(undef, 4, 2)
	A[1,2] = 300
	A
end
# N=2 argument is optional/redundant since dims already implies dimensionality

# ╔═╡ 9daa2b6a-7e35-44aa-be22-151d1b7a10a0
md"""Here **undef** is a singleton type used in array initialization, indicating the array-constructor-caller would like an *uninitialized* array.

*undef* values can default to zero or random values, based on the type T from Array{T}"""

# ╔═╡ c6a08019-594e-40b3-933c-a05eed94cd0f
# Try these: Any, Float64, Int64, Int128, Bool, Char, String
Array{String}(undef, 2, 3)

# ╔═╡ da650a3b-f042-4b92-a071-ca299ca1408b
md"""
There's also a **missing** and **nothing** initializer, but these have to be used with the Union{ } operator inside the type definition of the array.
"""

# ╔═╡ 78b46207-65de-4f3f-b5d0-84108235f199
md"""
```julia
Array{Union{Missing, T}}(missing, dims)
Array{Union{Nothing, T}}(nothing, dims)
```
"""

# ╔═╡ 5d7f5bd1-af7a-42b9-846c-22b71d79be89
try Array{Float64}(missing, 2, 3) catch; "Ugly error will show up" end

# ╔═╡ 44a13bbb-e1b6-4cb4-8abb-734e50a72326
let A = Array{Union{Missing, Float64}}(missing, 2, 3)
	A[1,1] = 64; A
end

# ╔═╡ 295b2970-97c0-459f-b098-ed9ff38d6a2f
let A = Array{Union{Nothing, Bool}}(nothing, 4)
	A[4] = true; A
end

# ╔═╡ dbdb5ab4-3175-46aa-bd04-ae4768096f99
md"""
## Vectors
As mentioned before, **Vectors** are aliases for 1D Arrays
"""

# ╔═╡ 2e0ece62-c125-4e5c-b5cf-7f6f4e8c0ce7
typeof( [1, 2, 3, 4] )

# ╔═╡ 8ab53abb-a1c6-4086-9da2-0278fc89a110
typeof( [1, 2, 3, 4.0] )

# ╔═╡ 931f7a20-4caf-4800-8c28-e6f77a6e5328
[1, 2, 3, 4] == [[1, 2]; [3, 4]]

# ╔═╡ a5f3ab46-2526-4023-a461-fe4d8d7f6f24
typeof(  [[1, 2], [3, 4]]  ) # Vector of Vectors

# ╔═╡ 4f579584-0e6e-4e53-bd0c-2cf7907c1fef
md"""
```julia
Vector{T}(initializer, n) # Vector is always 1D
Vector{T}(range) # range has the form start:end
```
"""

# ╔═╡ db99b7d5-4067-436a-bbe9-917903af2b55
Vector{String}(undef, 5)

# ╔═╡ 87a27948-7182-4994-bedd-0aed5a580737
Vector{Float64}(5:10)

# ╔═╡ 0f8218e0-0402-4cef-a75c-00da836b25ba
Vector(5:10) # defaults to Int64

# ╔═╡ 19403748-3592-4cc9-b28e-fb0b9184ef3f
md"""
Using ≥ 2 range expressions (see ranges section)
"""

# ╔═╡ f0b917ae-fc72-42d7-9c75-f5728b741290
[1:5; 101:110] # ";" is mandatory

# ╔═╡ 924ca07b-ce90-474f-91cd-5d80d40404a3
[1:5, 101:110] # "," will produce a vector of ranges
# Not using anything will produce a matrix (see matrix section)

# ╔═╡ 0a64c8e6-0334-4be7-b6b9-07d0416d1d6c
md"""
----
"""

# ╔═╡ 581fccac-d4f1-4ce8-b9b4-f869db77364a
md"""
## Matrix/Matrices
Alias for 2D arrays
"""

# ╔═╡ 57a63bba-e9b2-4d8c-b8ae-da4e4e87adee
[1 2 3 4]

# ╔═╡ 389523b5-b84c-4816-913a-9f70b78049a0
typeof([1 2 3 4])

# ╔═╡ 9ef56b70-a019-4d12-ad55-ac8a97124226
[1 2; 3 4; 5 6] == [[1 2]; [3 4]; [5 6]]

# ╔═╡ 3d719516-7ec7-4279-bc9f-3d104899842a
md"""
Construct a matrix from horizontal concatenation of vectors. Dimensions must coincide
```julia
[u;; v ...]
```
"""

# ╔═╡ c9e303d6-3612-44ee-af33-59892cbf8f40
[[1,3,5];; 2:2:6;; Vector(7:9)] # Dimensions must coincide (See ranges section)

# ╔═╡ a44495ff-3c9c-440f-9652-874d72e1f616
md"""
Julia has the following behavior for matrix syntax in a row
"""

# ╔═╡ 3bbb3adb-d0fd-48c6-be10-1c3baf060593
[[1 2 3] [4 5 6];
 [1 2 3] [4] [5 6]]

# ╔═╡ e610d850-12c6-4e15-a39c-c01a08948b33
md"""
## Vector of Matrices
"""

# ╔═╡ 567d7bdb-6c9f-421a-9150-a2911f6e3f40
typeof( [[1 2 3], [4 5]] )

# ╔═╡ 6af94384-f63f-43ca-96d2-ed17319a0e92
[[1 2; 3 4], [5 6 7; 8 9 10]]

# ╔═╡ f5864b45-d59e-43b1-94bf-1120c82d89c3
md"""
## Matrix of Vectors
(i.e. just a matrix)
"""

# ╔═╡ d3f1380d-d715-4bc1-8cd7-e9005fd6b873
typeof(
[[1, 2, 3] [4, 5, 6]]
)

# ╔═╡ bb7c7d68-e967-4022-8000-1bec87f7ea5f
[[1, 2] [3, 4] [5, 6]]

# ╔═╡ 2cabc082-748e-44bb-951c-08de8b79ed49
md"""
---
"""

# ╔═╡ 921fd462-55b8-4cae-a877-2b7ad5fa4929
md"""
# Basic Array Constructors
"""

# ╔═╡ 278085f8-4e4c-4dfd-9d0f-f9e6905bfd98
md"""
## Array{Any}
Initializing array with any value
"""

# ╔═╡ 22913113-08f5-44cc-aefd-da458e27441b
let A = Array{Any}(missing, 2, 3)
	A[1,1] = 2
	A[1,2] = "Two"
	A[1,3] = 2.0
	A[2,1] = true + true
	two = 2
	A[2,2] = two 
	
	# Printing
	A, A[2,3], typeof(A[2,3])
end

# ╔═╡ 8ee7b977-601e-4595-ae61-3c33393064ac
md"""
Julia identifies the type of matrix
"""

# ╔═╡ 1319256f-eeba-4f3b-bf1d-4b33f60ec45e
[[1 (true, false)]; [3.0 "4"]; [missing "🚀"]]

# ╔═╡ ea32e3ae-03de-4e3e-9fcd-6fccf1e4064f
md"""
## Zeros, Ones
```julia
zeros([T], dims)
ones([T], dims)
```
"""

# ╔═╡ c1a247de-24d5-45a8-954e-fc4a5ff8d3ee
zeros(4)

# ╔═╡ 000b3555-74bf-43e5-9f01-e45b2e832e37
zeros(Int128, 2, 3)

# ╔═╡ 1a0e794d-c05f-466b-a552-fdbb59bc2dd3
ones(1, 4)

# ╔═╡ d08fafcf-0542-4da7-955b-48ba4bf35c15
ones(Bool, 2, 3)

# ╔═╡ 5110647c-6314-4c32-b5db-309cd330ce1a
md"""
## Trues, Falses
"""

# ╔═╡ 759e4cdb-858c-45e8-8db7-4df35b4bd6fa
typeof( trues(5) )

# ╔═╡ ca0b4bf2-bc3d-4c81-8957-62cfcc8c438e
typeof( trues(2, 3) ) 

# ╔═╡ 50d02a76-ad72-4db3-b6b5-515ade21fc40
falses(5)

# ╔═╡ 02e3cf29-a67a-4c13-b279-31f8cc9e4c09
falses(2, 3)

# ╔═╡ a6a7090d-bd10-4ca6-8c30-1fdb3d17b727
md"""
## BitArray
"""

# ╔═╡ a09fb115-aee1-46ee-b0ac-9d954908b365
md"""
```julia
BitArray(itr) # Argument is a logical iterator for evaluation
```
"""

# ╔═╡ 8f76e78e-701b-4cc3-90a8-fa3a3edb2e3e
md"""
Using many **for** expressions outputs a *vector*
"""

# ╔═╡ ebdd35b2-179a-4e1c-a7ec-1c02eef3893d
BitArray((x+y-z)%2 == 0 for x = 1:2 for y = 1:3 for z = 2:3)

# ╔═╡ 26600b56-5477-4212-a41d-221523f39057
# It can also be constructed with list comprehension
BitArray(x+y == 3 for x = 1:2 for y = 1:3) == 
[x+y == 3 for x = 1:2 for y = 1:3]

# ╔═╡ d62485fa-fbc8-4555-bd56-6374a3d1d0f5
md"""
Using *commas* instead of for expressions outputs an array with N≥2
"""

# ╔═╡ bd8e0a35-eae5-481c-8a9a-1b97fa01db63
BitArray((x+y-z)%2 == 0 for x = 1:2, y = 1:3, z = 2:3)

# ╔═╡ d7bebf65-6737-4023-9fb4-39a9ae3bc365
# It can also be constructed with list comprehension 
BitArray((x+y-z)%2 == 0 for x = 1:2, y = 1:3, z = 2:3) == 
[(x+y-z)%2 == 0 for x = 1:2, y = 1:3, z = 2:3]

# ╔═╡ 2d627404-2c64-41d1-bdb7-37349668c96f
md"""
## Fill + !
```julia
fill(X, dims) # X could be a single value, tuple, or an array
```
"""

# ╔═╡ e9896ac8-a3a7-4cb7-a006-8b090726f500
fill(10.0, (2, 3))

# ╔═╡ 2915f291-084a-40c2-91c0-9fcfa56982d0
fill(zeros(Int64, 2), 4)

# ╔═╡ 1ea7e650-d9fc-430e-8523-f866351393a5
fill(zeros(2,3), 2)

# ╔═╡ a278c88f-f297-47db-af45-a3befacd1957
fill(ones(Int64, 1, 3), (2, 3))

# ╔═╡ 2b18429b-c65d-4a1d-b98f-faf3df9efc46
md"""
```julia
fill!(dest, X)
```
"""

# ╔═╡ 166415a5-d624-4109-8ac4-5e19be8f8fbc
let A = fill("Hello", 4)
	fill!(A, "World")
end

# ╔═╡ 7aee0822-57c9-487d-8c4b-dde788778723
md"""
## Similar
Outputs a similar array with the same dimensions/data type and random/arbitrary values.
```julia
similar(array, [T], [dims])
```
"""

# ╔═╡ 86e70306-9fb9-4417-a483-667be982bd59
let A = ones(Bool, 4, 32)
	similar(A)
end

# ╔═╡ 42b61c64-9fce-49a5-aaa2-46cda0927821
md"""
If the array is of type *Any*, it will return *undef* values.
"""

# ╔═╡ f6b1b6a9-6b43-40bb-b0e7-bbe4990e5eaf
let A = [1, "2", true]
	similar(A)
end

# ╔═╡ de62d171-4ae9-4483-a2bf-549a8a1a4af7
md"""
Though data type can also be specified
"""

# ╔═╡ ab0bf66b-f042-4725-9b06-b85d807a8a12
let A = fill(52.02, (2, 3))
	A, similar(A, Bool)
end

# ╔═╡ 8f2f340a-64f3-4317-bb88-7fdca99c0ba2
md"""
As well as dimensions
"""

# ╔═╡ 08b348c5-1603-450d-a1d1-6d12e23f1483
let A = fill("Hola", 3, 3)
	A, similar(A, Bool, 5)
end

# ╔═╡ f8077ab3-f61d-4378-80e0-6bccb058a96d
md"""
# Array measurement
"""

# ╔═╡ 59d335f6-7263-4754-b077-eb60b2a249ba
md"""
## ndims(), size(), length()
"""

# ╔═╡ 6b039636-345a-4eb6-8d9e-cbaa85d8c330
ndims(ones(2,3,4,5)) # Number of dimensions

# ╔═╡ 94681a6d-d97a-4c9d-93e2-1966e3af9210
let A = zeros(50)
	length(A) # Common length function for 1D array
end

# ╔═╡ 0d7ed0fd-5b9e-4a63-a8ea-dc4c515dee6f
let A = zeros(4, 5, 10)
	length(A) # Total number of elements in array
end

# ╔═╡ b7c762cb-4b51-49c3-9e21-ffb31efcbcec
size(ones(4,10,100)) # Gives length for each dimension

# ╔═╡ a9bc4e79-4596-4726-884f-09a225d27cf8
size(ones(4,10,100), 3) # Dimensions can be specified

# ╔═╡ 9677984d-55c5-4790-8973-c03ef928da77
md"""
# Range Array Constructors
"""

# ╔═╡ 96b49b6f-4b77-4a94-b1ab-12658e9b85ea
md"""
## range()
"""

# ╔═╡ 5b165209-92f9-4bd5-a061-8b7b98a0e554
md"""
Implicit
```julia
range(start, stop) === start:stop
range(start, step, stop) === start:step:stop
```
Explicit
```julia
range(start=a, stop=b)
range(start=a, step=b, stop=c)
```
Collect
```julia
collect(range(...)) # range in implicit or explicit form
Vector(range(...)) # idem
```
"""

# ╔═╡ 215d5ff6-2867-45ce-be4e-37a0ebc9c617
collect(1:10) == Vector(1:10)

# ╔═╡ a42e3e24-029a-4208-84ba-4cff98a6279a
collect(1:3:10)

# ╔═╡ 1decbef8-0f26-4b17-bee0-a77f696a724d
md"""
If *stop* is not a multiple of *step*, it will automatically consider the immediate lower multiple
"""

# ╔═╡ 19cc7849-f17d-4957-8156-00a296826f4f
Vector(1:3:12)

# ╔═╡ 99d77508-b4c0-44a3-91f4-46f9d8b772e6
collect(1:3:12.0) # Behavior when any argument is not an integer

# ╔═╡ e26d1092-9d88-4263-b26c-37ed4f62b3b3
md"""
Other explicit forms
```julia
range(start=a, stop=b, length=c)
range(start=a, step=b, length=c)
range(step=a, stop=b, length=c)
range(start=a, length=b) # step defaults to 1
range(stop=a, length=b) # step defaults to 1
```
"""

# ╔═╡ 7d9656a1-d2e0-4f67-adc0-47acc9299479
collect(range(stop=100, length=10, step=2))

# ╔═╡ 7b31e5a4-3e84-43cc-94c0-d3568ac76522
md"""
When using [*start*, *length*, *stop*] arguments, dimension is predictable, but there maybe some rounding issues
"""

# ╔═╡ 584d198d-bbbf-45f1-8e04-4baf5cffafee
Vector(range(start=1, stop=10.5, length=4))

# ╔═╡ c87d9f81-8ded-43f5-a2bc-ac8f88398a53
md"""
## LinRange()
Similar to range(start, stop, length) but without keyword arguments
```julia
LinRange(start, stop, length)
```
"""

# ╔═╡ 2f94d5df-9e85-424a-bb3f-9af462d570aa
LinRange(1,10.5,4) == range(start=1, stop=10.5, length=4)

# ╔═╡ 9f99c04b-c633-4c07-ad14-636465d05470
md"""
But it won't try to correct for floating point errors, unless its range( ) equivalent"""

# ╔═╡ c90a8de1-0d77-4069-8581-a66a51343099
collect(range(start=-0.1, stop=0.3, length=5))

# ╔═╡ bb0c51db-1be0-4900-8eff-3624a25793e4
collect(LinRange(-0.1,0.3,5))

# ╔═╡ 251ac698-74c4-41e9-b15c-3be5866908f7
md"""
# List Comprehension + Zip or Ternary Operators
"""

# ╔═╡ cf6ed7cd-b826-4991-a3a7-c51d09988fa6
md"""
## List Comprehension
"""

# ╔═╡ 8a5c603f-6d72-45f8-aa7e-9095bc6015d8
[2*x for x in 1:2:11 if x > 3] # if statement is applied before 2*x

# ╔═╡ 13881b55-f09a-4133-aa4e-84935f5d803e
2*[x for x in 1:2:11 if x > 3]

# ╔═╡ 9f4f9f97-c858-45bd-b466-94ff20a09738
let A = [10*x for x in similar(ones(4, 5), Bool)]
	A, ["Yes!" for y in A if y > 0]
end

# ╔═╡ 94833fbe-0ba5-4bb1-be08-01c2c841eb78
md"""
## Zip
We get different results for *zipping* vectors vs. matrices
"""

# ╔═╡ 1da295d3-1ffe-4f4d-9d07-391519bedcaf
[pair for pair in zip([1, 2, 3], [4, 5, 6])] # Vector of tuples

# ╔═╡ 2c7a09b1-1d04-4e7c-a0b6-038c1f2f2b4d
[pair for pair in zip([1 2 3], [4 5 6])] # "1D" matrix of tuples

# ╔═╡ 5bb235c9-e465-4326-a59a-745e67be2d11
[group for group in zip([1, 2, 3], [4, 5, 6], [7, 8, 9])] # Vector of tuples

# ╔═╡ ad901061-01cf-441a-8f49-6379fb1b6216
md"""
Using tuples to break the pairs/groups
"""

# ╔═╡ f467811d-dbaa-4c9d-8aa4-e310641cb11f
[x+y for (x,y) in zip([1, 2, 3], [4, 5, 6])]

# ╔═╡ 35f411f9-eb32-4dbe-9ecc-b511dcfac138
[x+y for (x,y) in zip([1 2 3], [4 5 6])]

# ╔═╡ 54aa3993-73eb-4ac9-baeb-52dfb49c1c15
md"""
Using ranges outputs a vector
"""

# ╔═╡ 5a9cbb1b-a208-4c3f-a4fd-9c90e79702a5
[pair for pair in zip(1:4, 4:7)]

# ╔═╡ 32a2461c-4026-4013-a2bf-a522590232a5
[x + y for (x,y) in zip(1:4, 4:7) if (x < 4 || y < 7)]

# ╔═╡ fdeb4ee4-46de-4c9f-93cd-a1e0e973e939
md"""
The output from list comprehension + zip will always be a vector or a matrix with size(dim 1) = 1, since we always do operations with tuples (which is the output of a zip())
"""

# ╔═╡ 43e61d4e-36ab-4549-ae38-2199bb52a9ec
[x+y+z for (x,y,z) in zip([1 2 3], [4 5 6], [7 8 9])]

# ╔═╡ c29b8676-4efa-4bf1-a5e2-9f8a3c49ba9f
md"""
## Ternary Operator
"""

# ╔═╡ 9bc0805b-a2d6-4ed8-b873-14868a112021
[x%2==0 ? 1*x : "odd" for x in 1:10]

# ╔═╡ 129df6fe-3bec-4231-971a-a5309d069653
let A = similar(ones(4, 5), Bool)
	A, [x>0 ? "One" : "Zero" for x in A]
end

# ╔═╡ ff7b1f6e-e80c-4117-a860-f03df4bbfded
md"""
Nested ternary operations
"""

# ╔═╡ 629a860f-8f34-4be0-b79e-810ab95afc45
let A = rand(1:3, 8) # 8 random integers between 1 and 3
	A, [x==1 ? "R" : (x==2 ? "G" : "Y") for x in A] # Red, Green, Yellow if...
end

# ╔═╡ 4e09b6ee-1f5b-4435-b111-815f4ea29da3
md"""
# Multi-dimensional Arrays from operations
"""

# ╔═╡ 495c85da-806d-424a-b8be-dadc632abce9
[x + y for x in 10:10:30, y in [4, 5, 6]] # x and y are both vectors

# ╔═╡ 33265322-2ab6-4eae-a9a2-21171770de6a
[x + y for x in [10, 20, 30], y in [4 5 6]] # now y is a matrix

# ╔═╡ f8117b5a-e652-4896-8d40-3da772af5bd4
md"""
When both are matrices, then it outputs the following 4D array (?). We can see that dimension 3 is unnecessary (1x3x**1**x3). Anyway, it can be fixed using **reshape( )** or **dropdims()**
"""

# ╔═╡ ba65ff51-052f-4a65-bc87-85e015deacc0
let A = [x + y for x in [10 20 30], y in [4 5 6]]
	A, reshape(A, 1,3,3), dropdims(A, dims=3)
end

# ╔═╡ a7aad93e-7717-49db-b58a-3ab527663d94
md"""
The same happens with
"""

# ╔═╡ 8b3907f9-fd11-403d-b6f3-61d621994980
[x + y for x in [[10 20 30]; [40 50 60]], y in [4 5 6]] # dims=3 can be dropped

# ╔═╡ b8b34db2-e974-4a37-abeb-d07ae06a5ac9
md"""
👉 Anyway, a more reliable way of getting the above array would be
"""

# ╔═╡ 60cf797a-61bc-483a-bfa7-c56ebeb2070b
[x + y + z for x in [10, 40], y in [0, 10, 20], z in [4, 5, 6]]

# ╔═╡ 4d2d6959-59d4-4660-b007-2ecd0d3003e7
md"""
# Broadcasting
"""

# ╔═╡ ab6b43b2-3e2d-4d88-8155-c0a8cb103ee0
md"""
## broadcast() + !
"""

# ╔═╡ f5eecee2-54e4-4bf0-be24-61671a1099ed
md"""
```julia
# Let f be a function
broadcast(f, arrays...)
(f).(arrays...)
```
"""

# ╔═╡ aa044d93-cd07-469c-a4e2-48245654ccb2
md"""
Trying to sum the same values of a vector with each of the 2 columns of a matrix
"""

# ╔═╡ effe8dec-9b64-480b-a4ef-a5160349b928
let A = [0.1, 0.2, 0.3, 0.4, 0.5]
	B = [1 2; 3 4; 5 6; 7 8; 9 10]
	A + B
end

# ╔═╡ 10eb76b2-5938-465b-884c-aea51e0ff931
md"""
We have to use broadcasting in order to *vectorize* arguments
"""

# ╔═╡ a2f6d5a6-e6e8-4a63-9f05-0ebce06e0757
let A = [0.1, 0.2, 0.3, 0.4, 0.5]
	B = [1 2; 3 4; 5 6; 7 8; 9 10]
	broadcast(+, A, B), "-----> or ---->", (+).(A, B)
end

# ╔═╡ 79e70773-b54b-4108-a739-538c9699da48
# Another example
string(fill("--> ", 3, 2), [10:10:30  40:10:60])

# ╔═╡ 76b8b578-0bf2-4060-9bb3-21849e9d6274
string.(fill("--> ", 3, 2), [10:10:30  40:10:60])

# ╔═╡ 84abadd1-22a9-4614-a00e-e3e6dd4f3563
md"""
```julia
broadcast!(f, dest, arrays...)
```
"""

# ╔═╡ 1af60b3b-9ce4-4c63-aefa-d36210967dd7
let A = [1 2 3 4 5; 6 7 8 9 10; 11 12 13 14 15]
	B = [1; -1; 10]
	C = similar(A)
	broadcast!(*, C, A, B)
end

# ╔═╡ a6bb1868-4ad7-4975-aa60-9591116f5958
md"""
## broadcasting simple operators
"""

# ╔═╡ 2162300f-4bc8-4ff7-824e-78122560ac56
Vector(1:10).>5 # is greater than 5 ?

# ╔═╡ 188f675e-6a32-4dfd-be6a-24fa60d1979d
Vector(1:10).%3 # modulo 3 operation

# ╔═╡ 8a049c92-8f02-48cf-a2c9-00b1933d1ee7
Vector{Float64}(1:10).^3

# ╔═╡ a595e1d7-7b64-4b45-a247-75bd800f8e00
# Matrices
(x->cbrt(x)).([1 8 27 64 125; 216 343 512 729 1000])

# ╔═╡ 2b4a917d-7238-4190-9c6f-be23e150183e
md"""
## @.
Convert every function call or operator in expr into a "dot call" (e.g. convert f(x) to f.(x)), and convert every assignment in expr to a "dot assignment" (e.g. convert += to .+=).

If you want to avoid adding dots for selected function calls in expr, splice those function calls in with \$. For example, 
```julia
@. sqrt(abs($sort(x)))
```
is equivalent to 
```julia
sqrt.(abs.(sort(x))) # (no dot for sort).
```
"""

# ╔═╡ def69adf-ff2d-452b-b086-37030cb47ffa
let A = 1:3
	B = similar(A)
	B = A + 3*sin.(A) # Want to execute this broadcasting with @.
end

# ╔═╡ 6ff2059a-fb2c-41ec-98f4-77055ea81351
let A = 1.0:3 # These have to be converted to Float, otherwise @. wont work. Not sure why
	B = similar(A)
	@. B = A + 3*sin(A)
end

# ╔═╡ 2a9ca801-73a9-4eaf-a655-f71510081bcd
md"""
# Reshaping & Shifting
"""

# ╔═╡ 15a451dd-54c1-4c1a-aed6-d19a4a32d26e
md"""
## vec()
"""

# ╔═╡ d3042530-844c-4f71-b69b-cef5657a6a1e
let A = [1 2 3; 4 5 6]
	A, vec(A)
end

# ╔═╡ 39e37280-9f6a-470c-be1e-7d4a425d2eea
let A = [x+y+z for x in [1,2], y in [10,20], z in [0,0.5]]
	A, vec(A)
end

# ╔═╡ 7a8abcbc-f05e-4891-9b02-daa213e8745e
md"""
## reshape()
```julia
reshape(array, dims)
reshape(range, dims)
# Using : in dims will automatically calculate dimension 
```
"""

# ╔═╡ c77f8459-9826-4776-a7fa-d853ec191851
let A = reshape(1:10, 2, 5)
	A, Array{Int64}(A)
end

# ╔═╡ 6a129f40-c99c-473d-8e45-3646ad06d006
md"""
Of course, when using **:**, lengths and dimensions must match
"""

# ╔═╡ 50092053-d77e-4600-90f2-db15286a039f
reshape(Vector(1:24), :, 8)

# ╔═╡ a73ec280-8332-45f9-93b3-40ef19075a60
reshape(Vector(1:24), 3, :)

# ╔═╡ eca06a7b-1b0f-459c-9fee-ebcbe7381074
md"""
## transpose() & adjoint
"""

# ╔═╡ ca54ce1f-02d9-4bf2-acb0-91d83e8ffd6b
transpose(reshape(Vector(1:15), 5, 3)) # Transpose matrix

# ╔═╡ 3286ccf9-31ea-43de-829c-a191e38f0da8
reshape(collect(1:18), 6, 3)' # Adjoint (?) matrix 

# ╔═╡ e1821a01-9128-4128-960a-2d30d96ac6ec
(1:5)' # Vector to Adjoint of size(dim 1) = 1...

# ╔═╡ eae0735d-7d16-4e64-9b7d-ac32b3a334c3
[(1:5)'; (6:10)'] # ...to Matrix

# ╔═╡ 39889f77-6ada-42e5-8d5f-e0fb66703d26
md"""
## permute!()
```julia
permute!(v, p) # Permute vector v according to permutation vector p
v[p] # Also works, and according the documentation, is generally faster
```
"""

# ╔═╡ e5e22778-3137-469c-bddd-261102385991
let A = [100, 200, 300, 400, 500]
	permute!(A, [4, 2, 1, 3, 5])
	A
end

# ╔═╡ 4ca21214-c9c8-42e7-9e4f-0f9f35c93416
let V = [100, 200, 300, 400, 500]
	p = [4, 2, 1, 3, 5]
	V[p]
end

# ╔═╡ dbcf5707-3a29-42a2-895a-4c4d141d9300
md"""
The **isperm(p)** function checks for valid permutations, i.e. checks if p is a complete, not necessarily sorted (ofc) vector that starts at 1
"""

# ╔═╡ 87600bd6-c8a6-4e93-a529-eed6b1fc1f3c
isperm([1,2,3,5]) || isperm([2,3,5,4])

# ╔═╡ 450edefd-6376-4a96-93c4-100417f81947
isperm([1,2,3,5,4])

# ╔═╡ 846da198-a0f7-4ab9-a65c-29b365c22864
md"""
## reverse()
```julia
reverse(array; [dims])
```
"""

# ╔═╡ 0fe8399e-d422-418b-a837-8913b13b5afc
reverse(Vector(1:5))

# ╔═╡ dccfc62f-532b-48ca-b44c-cb48f0e85a63
let A = reshape(Vector(1:8), (2,2,2))
	A, reverse(A, dims=(1,2)), reverse(A)
end

# ╔═╡ 5511bb76-f575-429a-81a5-def781a9ec02
md"""
## permutedims() + !
```julia
permutedims(perm::Tuple)
# The tuple determines the dimensions with which 1D, 2D, 3D... will be interchanged.
```
"""

# ╔═╡ 17b1c41e-2119-47d4-8498-8e61894ad0c7
md"""
For the below example, the changes are
- dim 1 ---> dim 2
- dim 2 ---> dim 1
"""

# ╔═╡ a5bbd46c-202e-4a84-aed2-719a9054cf83
let A = [x + y for x in 1:2, y in 10:10:30]
	A, permutedims(A, (2,1)) # Basically a transposition
end

# ╔═╡ 01a9a853-c176-44aa-8a61-96378157cb44
md"""
For the below example, changes are
- dim 1 ---> dim 3
- dim 2 ---> dim 1
- dim 3 ---> dim 2
"""

# ╔═╡ 985d9f55-1ce4-48f0-8031-6d66d89033e0
let A = [x+y+z for x in [0,5], y in 10:10:30, z in 0:0.5:1.5]
	A, permutedims(A, (3,1,2))
end

# ╔═╡ 72fb4066-c74e-4e39-8dc8-1e6d287ba1d5
PlutoUI.Resource("https://i.imgur.com/LOx66oD.png", :align => "center")

# ╔═╡ dbe8a9ea-6040-4c0a-af1c-cb037ec4705c
md"""
## circshift() + !
```julia
circshift(array, shifts::Tuple)
```
"""

# ╔═╡ ab651de1-e299-4060-af6a-516f2d8a5b2b
md"""
- The tuple determines the shifts in each dimension
- Positive numbers default to right/downward shifts, negative to left/upward shifts
- If the value of shifts is greater than the size of a dimension, then modulo logic is applied
"""

# ╔═╡ c34d93cf-3f7f-4427-bb1d-e00b868d523d
let A = Array(reshape(Vector(1:16), 4, :)')
	A, 
	circshift(A, (0,1)), circshift(A, (5,0)) # 5%4=1
end

# ╔═╡ 01e9aee6-38a8-455b-b8e5-8a2d077629a3
let A = Array(reshape(Vector(1:16), 4, :)')
	A,
	circshift(A, (0,-1)), circshift(A, (3, -3))
	# Order of shifting (rows first or cols first) doesn't matter
end

# ╔═╡ fd7d2a46-385b-4a13-a7e6-308e621ee5eb
md"""
```julia
circshift!(dest, src, shifts::Tuple)
```
"""

# ╔═╡ 1ca4334b-03fe-47cc-8018-8ce0a729b24d
let A = Array(reshape(Vector(1:16), 4, :)')
	D = similar(A)
	A, circshift!(D, A, (-1,3))
end

# ╔═╡ 003aa441-0d00-41c7-a95f-3c8db097295d
md"""
## Rotations
```julia
rotr90(array, k::Integer)
rotl90(array, k::Integer)
rot180(array, k::Integer)
```
"""

# ╔═╡ 0f76c005-f079-4620-ad3e-1e6b3b9e6708
let A = reshape(Vector(1:16), 4, 4)
	A, 
	rotl90(A, 3), rotl90(A, 3), rot180(A)
end

# ╔═╡ 1d147ed6-f640-44b0-947c-be95f93a0754
md"""
## dropdims()
```julia
dropdims(array; dims)
```
Dropped dimensions must be of size 1, i.e. it must be trivial. This is useful when some complex array operations output unnecessary extra dimensions.

See:
- Multidimensional Arrays from operations
- Mapslices
"""

# ╔═╡ 6b9409d4-44ac-4953-b8ef-fd90d7732796
let A = reshape(Vector(1:18), 2, 3, 3, 1, 1)
	A, dropdims(A, dims=(4,5))
end

# ╔═╡ f06c0ec3-b133-4f7d-adc4-c547af0cf9be
md"""
# Repetition & Concatenation
"""

# ╔═╡ d7cd3384-e43a-468d-9c84-acb24819bce0
md"""
## repeat()
```julia
repeat(array, counts::Integer...)
```
For vectors:
"""

# ╔═╡ 2d6ad9bb-ba34-4d91-b716-0a94d426f3d8
repeat([1, 2, 3], 2)

# ╔═╡ b7d3a9ed-b5fd-49a6-aec1-a45b86d5d8f6
repeat(["Rocket", "🚀", "Star", "🌟"], 1, 4) # 1 repetition along dim=1

# ╔═╡ 0dbbcee3-677f-4130-a042-fa8552325e80
repeat([99, 100], 2, 6) # 2 repetitions along dim=1

# ╔═╡ 5b3d6f5b-abab-4444-9fae-149946e0e646
md"""
---
For matrices
"""

# ╔═╡ b61c193d-5a0f-4280-a5a6-1ef28c37de0f
repeat([1 2 3], 2)

# ╔═╡ 571e4643-7413-4922-906f-3ba4204a91b2
repeat(["🚀" 100], 1, 4)

# ╔═╡ 439ec2f8-d31e-47d3-b07c-14da02cdfc52
repeat(["🚀" 100], 2, 6)

# ╔═╡ 471680dc-4e81-45a4-90a9-6fe4c8cf0ac5
md"""
## cat() over one dimension
```julia
cat(arrays... ; dims::Integer)
```
"""

# ╔═╡ 166f79e0-c94c-4152-a498-42cb9e14387c
let A = [1 2 3 4 5], B = [6 7 8 9 10], C = repeat([99], 5)'
	cat(A, B, C, dims=1),
	cat(A, B, C, dims=2)
end

# ╔═╡ b6140c08-7ab3-4df8-8ad9-186c49c2c8ce
let A = [1, 2, 3, 4, 5], B = [6, 7, 8, 9, 10], C = fill(99, 5)
	cat(A, B, C, dims=1),
	cat(A, B, C, dims=2)
end

# ╔═╡ b951c3e0-5e29-429d-bbb1-a4a9cc47baaa
cat([1 2; 3 4], [pi, pi], fill(10, (2, 3)), dims=2)

# ╔═╡ 6a46ac62-8988-4beb-96e8-be623c55c8ac
md"""
## vcat()
"""

# ╔═╡ 2909d091-49cf-4d76-9432-54cc11fa695b
# Since vectors are 1D, putting one over another will produce another vector
vcat(1:3, 101:103, 1001:1003) 

# ╔═╡ c98ba8e5-65a4-4c29-a954-f8979315ada8
vcat([1 2 3 4 5; 6 7 8 9 10], (101:105)', fill(999, 1, 5))

# ╔═╡ d631a821-abc1-45dc-b7a3-28f356622832
md"""
## hcat()
"""

# ╔═╡ edb08880-3a9e-4cc5-a289-c46a6293985e
hcat(1:3, 101:103, 1001:1003)

# ╔═╡ a5027f6a-dc01-4410-92d0-7df99cced029
hcat(1:5, 6:10, [101 102 103 104 105]', fill(999, 5, 2))

# ╔═╡ 2e5fd8b7-ed17-43bd-9e68-40f2a2cf8315
md"""
## cat() over 2 or more dimensions
"""

# ╔═╡ 6af84834-d43c-4fd3-80ce-40cf4521b731
cat([1,2], hcat(3:5, 6:8), (9:15)', dims=(1,2)) 
# dims(2,1) will output the same array

# ╔═╡ fe77f068-14a6-4731-aeb4-06e7ee9987b0
cat([1,2], (9:15)', hcat(3:5, 6:8), dims=(2,1))

# ╔═╡ 9f6e30fb-a08e-492b-9c67-f439f21cd986
md"""
## hvcat()
```julia
hvcat(number of arrays per block-row::Tuple, arrays...)
# The sum of the values in the tuple must be equal to the number of arrays.
```
"""

# ╔═╡ c26cf7de-32fb-43e1-a70c-87763c97e43d
let A = zeros(2, 3), B = ones(2, 3)
	C = fill(99, 2, 6)
	D = zeros(1, 6)
	hvcat((2, 1, 1), A, B, C, D)
end

# ╔═╡ a66791ff-0ea9-416a-b058-a05a5be66081
md"""
- Concatenated first 2 arrays (a,b) horizontally $\longrightarrow$ 2
- Concatenated 3rd array (c) horizontally, and vertically to the previous
- Concatenated 4th array (d) horizontally, and vertically to the previous
"""

# ╔═╡ b342a84a-0890-4219-9bb3-d3c1c1c2fcf3
let A = fill(:🚀, 2, 2), B = fill(:🌚, 2, 4),
	C = fill(:🌎, 2, 3), D = fill(:🌙, 2, 3), 
	E = fill(:🦎, 2, 2), F = fill(:🐼, 2, 2), G = fill(:🦨, 2, 2)
	hvcat((2, 2, 3), 
		A, B, # 2
		C, D,  # 2
		E, F, G) # 3
end

# ╔═╡ d50d4d24-5c3e-44dc-a789-288009e6a0c4
md"""
# Indices
"""

# ╔═╡ fb4865eb-a5a5-48dd-84e0-f806b2575245
md"""
## keys() & axes()
```julia
keys(array) -> Array with indices
```
"""

# ╔═╡ e89e4f15-473f-4b32-9ef5-5567f4339c7f
keys(Vector(101:105))

# ╔═╡ 95dc9315-baa8-4a89-ad1a-155598050162
let A = [100 200 300;
		400 500 600]
	keys(A)
end

# ╔═╡ f41ff9ab-ba3c-4f69-994d-f6f95c87ae47
md"""
```julia
axes(array, [dim::Integer]) -> Tuple of valid ranges || range (if dim is specified)
```
Returns a range of indices for the array along a dimension
"""

# ╔═╡ 85448658-a80b-4d0e-a0dd-2bc43dc8958c
axes([x+y+z for x in 1:2, y in 1:3, z in 1:4])

# ╔═╡ 9b90b20a-7c31-455d-9dbf-ce1157e190cd
collect(axes([x+y+z for x in 1:2, y in 1:3, z in 1:4], 3))

# ╔═╡ 2bc2dc15-ea83-4ff6-93bf-f163bb7a89c8
md"""
## pairs()
```julia
pairs(array)
```
Returns valid indices and respective values from an array (but also dictionaries and other data structures)
"""

# ╔═╡ b3cca955-661d-4895-9330-d0340aa17e72
let D = Dict("A" => 1, "B" => 2)
	keys(D)
end

# ╔═╡ f76acc60-0937-4f56-8cf9-15b755438fb5
pairs(Vector(101:105))

# ╔═╡ f7aea7e1-eee3-4107-a8c1-31d072cabb30
[(x,y) for (x,y) in pairs(Vector(101:105))]

# ╔═╡ 8e8a0817-e3bb-4722-9c7b-f97733725a87
let A = [100 200 300; 400 500 600]
	pairs(A)
end

# ╔═╡ 8b72023e-dd9e-4715-9861-3a90742a1b63
md"""
## CartesianIndex + Broadcasting
A CartesianIndex is simply a multidimensional index
"""

# ╔═╡ 80665de1-f6bd-4d9b-872b-8569ca82d667
let A = reshape(Vector(1:27), (3, 3, 3))
	A,
	A[[CartesianIndex(1,2,2), CartesianIndex(2,2,1), CartesianIndex(3,3,3)]]
end

# ╔═╡ 56e4c61d-5b7c-4939-bd24-a50934a93b2c
md"""
Constructing Cartesian Indices with broadcasting
"""

# ╔═╡ 7a3f8a47-51ce-4d1b-831e-25cbceafcb6b
CartesianIndex.([1,2,3], [4,5,6]) # Vectors only

# ╔═╡ 7dae5adf-58c6-4017-851e-e62e05d109bc
CartesianIndex.([1,2,3], [1,2,3], [10 20 30]) # Vectors + Matrix

# ╔═╡ dfd598cb-6fdd-4bb6-8a79-714f9e0350ff
CartesianIndex.([1 2 3], [4 5 6]) # Matrices only

# ╔═╡ 697aaddf-aa12-468e-81c8-e37aadcc78f2
CartesianIndex.([1 2 3], [4 5 6], [7 8 9]) # Matrices only

# ╔═╡ 87925f5c-e467-4708-aa11-6eb7d8967f1e
md"""
Getting diagonals from 3x3x3 array
"""

# ╔═╡ 8c4184fb-5c17-4a7d-9835-eb89fbebd84c
CI = CartesianIndex.([1,2,3], [1,2,3], [1 2 3]) # outputs a 3x3 matrix

# ╔═╡ 278158c0-4df5-495f-bfec-56a9cd9a381f
let A = reshape(Vector(1:27), (3, 3, 3))
	A, A[CI]
end

# ╔═╡ ebfcaaf1-2c47-46cf-8b50-2854ea46d363
md"""
Some variations:
"""

# ╔═╡ 835c9cbe-e23f-4781-af2e-4f4cd480a72a
let A = reshape(Vector(1:27), (3, 3, 3))
	A, A[CartesianIndex.([1,2,3], [1 2 3], [1,2,3])]
end

# ╔═╡ 2f43ec7a-758b-4435-9336-d518f82f6bab
let A = reshape(Vector(1:27), (3, 3, 3))
	A, A[CartesianIndex.([1 2 3], [1,2,3], [1,2,3])]
end

# ╔═╡ c74d2650-36e7-49cd-9a14-89969e220e90
md"""
## CartesianIndices()
```julia
CartesianIndices(array)
CartesianIndices(start:[step]:stop)
CartesianIndices((istart:[istep]:istop, jstart:[jstep:]jstop, ...))
CartesianIndices(tuple)
```
The first method is self evident. It outputs an array with all valid Cartesian Indices for the inputted array
"""

# ╔═╡ 8e30c230-c3b7-47cd-884d-ec5ee140de19
CartesianIndices(Vector(1:5))

# ╔═╡ 6e80b81f-8fbe-4e78-a4f0-28e9db1ab13c
CartesianIndices([1 2 3; 4 5 6])

# ╔═╡ a3629544-01bc-40ac-b14b-1733460c9ceb
md"""
For the second method it outputs indices according to the number of elements in the range, not for the intended values
"""

# ╔═╡ 6b36ac49-c4ba-4fdd-8912-fd3aa33fcb08
let CI_1 = CartesianIndices(1:5)
	CI_2 = CartesianIndices(6:10)
	CI_3 = CartesianIndices(1:2:9)
	CI_1 == CI_2 == CI_3,
	CI_3 
end

# ╔═╡ 29e61f40-a8f4-4517-9af9-91a7ae180432
md"""
Third method (note the double parenthesis) works in a combinatorial way
"""

# ╔═╡ e14f5abd-b5d8-4f0f-aa84-319d94e3d73a
CartesianIndices((1:3:10, 1:3))

# ╔═╡ a010f844-9d29-458f-9c12-0b9e9ac87537
# Setting a fix value for a dimension
CartesianIndices((1:3:10, 1:1, 3:4))

# ╔═╡ e6a9722a-3893-40cf-8584-b1475fbb76f8
let A = reshape(Vector(1:24), (3,4,2))
	CI = CartesianIndices((2:3, 2:2, 1:2))
	A, A[CI]
end

# ╔═╡ 24c92168-1c1a-4950-9bce-b19694dd9ee7
md"""
Fourth method (tuple input) creates cartesian indices starting from 1 up to the values specified for each dimension
"""

# ╔═╡ ff4878a8-1bc4-4a09-91e9-7259d7392c2f
CartesianIndices((2, 2, 2))

# ╔═╡ 2ccffb9b-587e-49ae-accd-81abc3cd51ca
CartesianIndices((2, 3, 1))

# ╔═╡ 3ac69ce2-af9f-429d-9684-2f6f7a9f3a47
md"""
# Indexing & Simple Slicing
"""

# ╔═╡ c495ca36-e19c-44e1-a4de-d0c2a8a4793f
md"""
## getindex() & simple slicing
```julia
getindex(array, inds)
array[inds]
# Both are equivalent and equally efficient for simple slicing
# Thought they can have different functionalities when called using macros, etc.
```
"""

# ╔═╡ cee01e0c-1baa-4898-b793-92d53a0ca631
arr25 = reshape(Vector(1:32), 4, :)*10

# ╔═╡ 6af3f2e1-fcc9-4d95-87d2-b1035fb822cb
getindex(arr25, 3) # arr25[3]

# ╔═╡ 87783e7f-22b1-47ed-9724-a0a504f93dc9
arr25[[30,31,32]] # getindex(arr25, [30,31,32])

# ╔═╡ f1c7f692-4204-4580-955d-b58d773adb67
getindex(arr25, 3:6) # arr25[3:6]

# ╔═╡ 099edc68-8058-4d59-bfd2-7385e89ad981
arr25[1,2] # getindex(arr25, CartesianIndex(1,2))

# ╔═╡ 7ec02e9e-ad65-4dc6-9acc-1c14f9feccf3
getindex(arr25, :, 4) # arr25[:,4]

# ╔═╡ 912b14f9-094c-4415-9e65-beffabfef1e6
arr25[2:3, 3:end-1] 

# ╔═╡ 0a9e72f8-9cec-4e81-98b6-173854d4e41d
md"""
getindex(arr25, 2:3, 3:end-1) wont work
"""

# ╔═╡ f653ca98-ae7f-412a-bd24-39776dbd747e
getindex(arr25, 2:3, 3:end-1)

# ╔═╡ e1db9cef-5576-4ee4-b5f7-e97286f95ae7
md"""
## Logical Indexing
"""

# ╔═╡ b2a790ff-08fe-4c0a-832d-c41e6c489209
arr28 = reshape(Vector(1:36), 3, :)

# ╔═╡ 5514d620-3d31-47c0-b749-aca51fbfe3ae
arr28[[true, false, true], 4:end-2]

# ╔═╡ 69b451df-2003-4788-98a4-1a22bd49bee8
arr28[:, vcat(falses(4), trues(4), falses(4))]

# ╔═╡ 37c0230d-d2ec-49ab-89df-d072aa3f8f31
arr28[map(ispow2, arr28)] # See map() section

# ╔═╡ 55ad938e-e41f-499c-b2df-5fad5d3f6957
md"""
# Assignment & Copies
"""

# ╔═╡ 7e2da9ba-b158-48d5-a002-ed34b48c9cbb
md"""
## setindex!()
```julia
setindex!(array, X, inds)
```
"""

# ╔═╡ f1c16eaa-afaf-4b9c-8c63-568003cd29cd
let A = Array{Int64}(undef, 4, 8)
	setindex!(A, Vector(110:10:200), 11:20)
end

# ╔═╡ 0a81d44e-0f9a-4ef8-9456-d0515d995b27
# Equivalent to a simple assignment
let A = zeros(Int64, 4, 8)
	A[2:3,:] = fill(99, 2, size(A, 2))
	A
end

# ╔═╡ 27f92a0c-bccc-4e0c-a7cb-66536a9c9157
md"""
## copy!() & copyto!()
"""

# ╔═╡ 40ae78f3-33ff-4475-bde9-68d7bfde024b
md"""
```julia
copy!(dst, src)
```
Simple copy function
"""

# ╔═╡ 765ecc00-f506-4f09-b0b2-3eb0f7f03345
let dst = zeros(3,3)
	src = ones(3,3)
	copy!(dst, src)
	src, dst
end

# ╔═╡ 30e8a0b0-bc74-41ca-a9b2-24e762b676d9
md"""
```julia
copyto!(dst, Rdest::CartesianIndices, src, Rsrc::CartesianIndices)
```
Copy function with the option to specify indices for both *dst* and *src* arrays
"""

# ╔═╡ 896682bb-3ec6-46df-a2e2-4ee18f43b191
let dst = zeros(3,3)
	src = reshape(Vector(1:9), (3,3))
	copyto!(dst, CartesianIndices((1:2, 2:2)), src, CartesianIndices((2:3, 2:2)))
	src, dst
end

# ╔═╡ dcb1ef63-7d94-4f89-89ac-e86e90b54c6a
md"""
# Views
"""

# ╔═╡ fd5a242a-3384-4dca-aa92-51b62f0377d7
md"""
## view()
```julia
view(array, inds)
```
!!! note
	Similar to getindex(), but it doesn't construct a copy or extract elements into another array (i.e. it's generally more efficient for assignment and other operations). Returns a lightweight array that lazily references (or is effectively a view into) the parent array.
"""

# ╔═╡ 519f6d73-274c-4752-8d20-71e7c9e0005d
let A = reshape(Vector(1:36), 4, :)	
	@time A[2:3, 4:6]
	@time view(A, 2:3, 4:6) # Less time and no allocations
end

# ╔═╡ f227d565-231d-442b-b558-3e885a8c2f30
md"""
## view() + Efficient Operations on Arrays
"""

# ╔═╡ 2de2d2b9-39d8-483c-b26e-7b3d1eee6fbe
let A = reshape(Vector(1:4000000), 4, :)
	@time sum(A[:,100:100000])
	@time sum(view(A, :, 100:100000)) # Less time and no allocations
end

# ╔═╡ 1e71dfba-e53d-45f7-8b5c-76ec7fcb27e7
let A = zeros(Int, 4, 100)
	@time A[:, 1:2:20] .+= 1
	@time view(A, :, 1:2:20) .+= 2 # Less time and less allocations
	A
end

# ╔═╡ efe04b28-3d74-4a28-8a2e-e764adead3cd
md"""
## view() + Efficient Assignment
"""

# ╔═╡ 89fab077-25bd-4578-ae92-8562ddb67018
@time let A = zeros(3, 10^6)
	A[2,:] = ones(10^6)
	A
end

# ╔═╡ 4fafa03b-ae0f-4836-8649-83a3424b5361
@time let A = zeros(3, 10^6)
	fill!(view(A, 2, :), 1) # Slightly more efficient
	A
end

# ╔═╡ 749ec334-cbe5-4218-91b9-2490e82c19bb
@time let A = zeros(4, 10^6)
	setindex!(A, fill(99, 2, 10^6), 2:3, :)
	A
end

# ╔═╡ 72916308-bd79-4469-8f40-38b4325c693d
@time let A = zeros(4, 10^6)
	fill!(view(A, 2:3, :), 99) # Slightly more efficient
	A
end

# ╔═╡ ef92324e-9395-4960-98a9-eaafa3ed32d4
md"""
## @view
Macro version of view(). Only works for the **single indexing expression** that's next to it.
```julia
@view arrray[inds]
```
"""

# ╔═╡ 54a1539a-7f35-466e-8b64-7edb034a6cec
let A = reshape(Vector(1:32), 4, :)
	A, @view A[3, 4:8]
end

# ╔═╡ eb89e7f9-21dd-4132-a4ad-a50a8fb26dd5
md"""
!!! note
	Allows to handle slicings/idexations that have **begin** and **end** keywords
"""

# ╔═╡ 93b8fae8-7af1-4cd1-b1e4-0a43274eb8e8
let A = reshape(Vector(1:32), 4, :)
	B = view(A, 2:end, 4:end) # Won' be able to execute it
	fill!(B, 0)
	A
end

# ╔═╡ ede2bd03-a8f2-4fba-bbd8-c826225aa8de
let A = reshape(Vector(1:32), 4, :)
	B = @view A[2:end, 4:end] # No problem 😎
	fill!(B, 0)
	A
end

# ╔═╡ 175df8ad-d02b-43c5-b6d2-4c4dee8dfb8a
md"""
## @views
Convert every array-slicing operation in the given expression into views
```julia
@views array[inds]...
@views begin array[inds]... end
@views for array[inds]... end
@views while array[inds]... end
@views function array[inds]... end
...(?)
```
"""

# ╔═╡ 76b316e5-8a76-4216-9b54-6ba9bf2b64d6
md"""
!!! note
	Scalar indices, non-array types, and explicit **getindex( )** calls (as opposed to **array[inds]**) are unaffected
"""

# ╔═╡ eeb8450d-3079-4c88-acfc-3c9a151d9d71
@time let A = zeros(3, 3) # The only allocation it will be made
	@views for row in 1:3
		B = A[row, :] # This is a view, i.e. it's accessing the array itself
		B[:] .= row # So this assignment goes directly into A
	end
	A
end

# ╔═╡ 063410ea-18e2-47fa-bc12-9f8c4de9936a
@time let A = zeros(3, 3)
	@views for row in 1:3
		B = getindex(A, row, :) # This creates another array, not a view
		B[:] .= row # So assignment won't go into A
	end
	A
end

# ╔═╡ 648de74c-ad4d-46a5-b487-3c67c3a13848
md"""
!!! note
	The @views macro only affects array[...] expressions that appear explicitly in the given expression, not array slicing that occurs in functions called by that code.
"""

# ╔═╡ 703cde05-ad97-4c5d-af51-3738a38b1282
@time let f(arr) = arr[2,:] # Defining f() in both cases, here...
	A = zeros(3, 3)
	@views A[2,:]
end

# ╔═╡ f6093bef-24d4-4abb-9443-fda087368a31
@time let f(arr) = arr[2,:] # ...and here, for fairness in @time results
	A = zeros(3, 3)
	@views f(A) # Check output here (is not a view) and in the terminal (time)
end

# ╔═╡ 8eddc139-2bbc-497c-a2e0-3060e72b2cbe
md"""
!!! warning
	Nevertheless, it works with functions like sum( ) because these don't use any slicing.
!!! warning
	Also, using @view won't work for these expressions, but @views will
"""

# ╔═╡ f3f4d4ea-1220-4e49-96e5-0078dae5ee3b
let A = reshape(Vector(1:27), 3, :)
	@view sum(A[2:end, begin:6])
end

# ╔═╡ 479f7d6d-bbdb-45e8-9552-783ce8fbfbf4
let A = reshape(Vector(1:27), 3, :)
	@views sum(A[2:end, begin:6])
end

# ╔═╡ 2d18cab9-d665-44c0-8204-9d16744d7510
md"""
!!! note
	Using @views to define a function. This is different from using @views before calling a function that executes slicings
"""

# ╔═╡ dafa8d33-a901-4d1d-a10f-f58759e55058
let
	@views function foo(arr, i, j)
		return arr[i:j]
	end

	A = reshape(Vector(1:16), 4, :)
	foo(A, 8, 12)
end

# ╔═╡ e4d270ce-e270-4b48-a7aa-62bdef85842c
md"""
## Parent of a view
"""

# ╔═╡ 76622412-1a9f-4fdb-b08b-af8ec45c2364
let A = reshape(Vector(1:15), 3, :)
	v1 = @view A[1:2, [1,3,5]]
	v1, parent(v1)
end

# ╔═╡ 7deb4428-a063-4288-b144-8f07575dbdd8
let A = reshape(Vector(1:15), 3, :)
	v1 = @view A[1:2, [1,3,5]]
	parentindices(v1), parentindices(v1)[1], parentindices(v1)[2]
end

# ╔═╡ ec017bf1-6814-498e-8af8-8eeb92e1cfee
md"""
# Slices, Rows & Cols
"""

# ╔═╡ 681f3d6b-1296-4da6-b2b6-9e8461b99889
md"""
## eachslice()
Creates a **generator** (not an array) that iterates over dimensions dims of A, returning **views** that select all the data from the other dimensions in A.
```julia
eachslice(array; dims)
```
!!! note
	returns views ---> consider this in order to assign a section inside this notebook
"""

# ╔═╡ 359e688b-9586-42db-9d3b-07fb6cd372f0
md"""
Iterate over dims=1, select data from dims=2
"""

# ╔═╡ 2da40598-b938-4939-91af-9eab4cb86bd2
eachslice([1 2 3; 4 5 6], dims=1) # See output ---> Base.OneTo(2)

# ╔═╡ d05446d8-13fa-4338-b82f-d6db18a818c1
collect(eachslice([1 2 3; 4 5 6], dims=1))

# ╔═╡ b822e3a8-5096-4415-bff9-91a18552dafd
let A = Array{Float64}(undef, 3, 2)
	B = [1 2 3; 4 5 6]
	for slice in enumerate(eachslice(B, dims=2))
		A[slice[1],:] .= slice[2] 
	end
	B, A
end

# ╔═╡ a335bd65-a4b4-4f71-b879-26bb8154056e
let A = reshape(Vector(1:18), (2,3,3))
	A, collect(eachslice(A, dims=2))[1] # try with dims=1, dims=3
end

# ╔═╡ 19408d55-1a68-4d5d-95e7-d2ba8c3ae29f
md"""
## eachrow(), eachcol()
Self evident. Unlike eachslice(), it only works with vectors or arrays.
```julia
eachrow(vector or matrix)
eachcol(vector or matrix)
```
"""

# ╔═╡ b750afa0-b46f-4ae4-88b4-481b61a166a7
let A = rand(2,3,4)
	A, [sum(row) for row in eachrow(A[:,:,1])],
	# Test
	[sum(A[i,:,1]) for i in 1:2]
end

# ╔═╡ 0b207ae2-f4b6-402d-862c-ab7c39db8eac
let foo(col) = (m=minimum(col); m >= 0.5 ? m : 0)
	A = rand(2,3,4)
	A, [foo(col) for col in eachcol(A[:,:,2])]
end

# ╔═╡ e73b7d26-05b9-4881-b05a-dc0ff27ece45
md"""
# Array Mapping
"""

# ╔═╡ a01883ac-f370-4bff-a552-b4dca8f915bd
md"""
## map() + !
```julia
map(function, arrays...)
```
Transforms the array by applying f to each element. For multiple arrays, it stops when any of them is exhausted.
"""

# ╔═╡ 48c0d2b9-a827-424f-893e-db7cf0e6288e
let A = randn(5); B = rand(5)
	foo(x,y,z) = (x*y-y)/z
	map(foo, A, B, A) # Values of A are inputted both as x and z
end

# ╔═╡ 6de1f6de-2df9-4a07-a168-779c08954461
let A = Vector(1:3:7)
	B = Vector(1:3:19)
	A, B, map(*, A, B) # It stops when A is exhausted
end

# ╔═╡ 8230a814-3ea0-43e0-93ce-60fbb325d673
md"""
```julia
map!(function, dst, arrays...)
```
"""

# ╔═╡ 8131f2cf-07a1-443d-b66f-3de14ab81dc9
let D = zeros(2,5)
	A = 1:6 # Can also use ranges
	B = 1:7
	map!(+, D, A, B) # Stops when A is exhausted (since is the smaller collection) 
end

# ╔═╡ a9ba9164-990b-4a57-9f75-fcabd5342a64
md"""
## mapreduce()
```julia
mapreduce(function, op, itrs...; [init])
```
Apply function to each element(s) in itrs, and then reduce the result using the binary function op. init is considered for the op operation.
"""

# ╔═╡ 6cfed146-f97c-4678-871b-9d044355f7f0
mapreduce(x->x^2, +, [1:5;]) # [1:5;] == Vector(1:5)

# ╔═╡ bdc56b81-8b23-4187-8fde-58f9e58aeb20
let A = rand(1:50, 5)
	B = rand(1:50, 5)
	C = rand(1:50, 5)
	A, B, C,
	mapreduce((A,B,C)->A+B+C, max, A, B, C, init=120)
end

# ╔═╡ c207f4ca-0af8-40b8-8593-4d7d453787c8
md"""
## mapslices()
Transforms the given dimensions of the array using the function f. Results are concatenated along the remaining dimensions.
```julia
mapslices(function, array; dims)
```
"""

# ╔═╡ 29a5522c-4218-4d57-bf82-4170b24ff3f6
md"""
Using 1 dimension of a 3D array
"""

# ╔═╡ 80b4a9e5-d2de-4b9d-957a-714bea37ece3
let A = reshape(Vector(1:18), (2,3,3))
	A, 
	mapslices(sum, A, dims=1), # [1+2, 3+4, 5+6] ...
	mapslices(sum, A, dims=2), # [1+3+5; 2+4+6] ...
	mapslices(sum, A, dims=3) # [1+7+13 3+9+15 5+11+17; ...]
end

# ╔═╡ 8b96b18f-d759-41d3-b6b4-624d9c669611
md"""
Using 2 dimensions of a 3D array
"""

# ╔═╡ 379cc9bb-a7f3-4d19-a20e-c64a30d1fff9
let A = reshape(Vector(1:18), (2,3,3))
	A, 
	mapslices(sum, A, dims=[1,2]), # [1+2+3+4+5+6] ...
	mapslices(sum, A, dims=[2,3]) # [1+3+5+7+9+11+13+15+17; ...]
end

# ╔═╡ 9f99ee18-545d-4f08-8e31-84e887f9fe42
md"""
Using an anonymous function
"""

# ╔═╡ 3b476d8c-67cd-4517-931d-9fde0aa061ea
let A = rand(2,3,4)
	A, mapslices(x->sum(x)/length(x), A, dims=[1,3]),
	# Testing results
	[sum(A[:,i,:])/(size(A,1)*size(A,3)) for i in 1:3] # Or I could simply divide by 8
end

# ╔═╡ a13bdcda-e927-496f-a7d9-d8897ae2973e
md"""
An slightly more advanced example of mapslicing
"""

# ╔═╡ 8ecc8772-d5e7-491d-9865-624f37db1fe8
begin
	fxy(X,Y) = X'*Y # Function with 2 inputs, supposed to be arrays
	X1 = randn(2, 3, 3) # Intentionally added a 3rd dimension for mapslices()
	Y1 = randn(2, 1) # 2 rows, 1 col
	
	try X1'
	catch; "Adjoint/Transposition won't work with a 3D array" end
end

# ╔═╡ e56cec13-c880-4247-b650-316a2a2e0a6b
X1, Y1

# ╔═╡ 9221fb9e-42fd-4175-84cb-fcd3bab31363
begin
	# The fxy(X,Y) function has to be introduced as an anonymous function, can't be done directly since mapslices() will allow only 1 array as input --> See its syntax
	# Now, mapslices() will treat X1 as the first input of fxy(X,Y), i.e. as X
	# That's why the second input, i.e. Y, has to be defined outside (as Y1 in this case)
	# Because of the dimensions of X1, using mapslices() with dims=(1,2) will get us 3 matrix of dimensions 2x3, and their transpositions (with dimensions 3x2) can be finally multiplied with a matrix of dimensions 2x1 
	result1 = mapslices(X->fxy(X, Y1), X1, dims=(1,2))
	result1,
	# I can also drop dims=2 in the last result, so I can get a matrix with before dim=3 values now as dim=2
	dropdims(result1, dims=2)
end

# ╔═╡ 7387975c-4ace-4a03-b1b4-cb1d81113014
begin
	# dims=(1,3) can also be used since the size of X1's dim=1 matches the size of Y1's dim=1
	result2 = mapslices(X->fxy(X, Y1), X1, dims=(1,3))
	
	# Dropping unnecessary dimensions
	result2, dropdims(result2, dims=3)
end

# ╔═╡ 26ec757a-a941-4233-bb17-7947cdf4d997
md"""
# Array Cumulative Operation Functions
"""

# ╔═╡ 303d4529-db84-4528-9499-be1a7945875e
md"""
## accumulate() + !
```julia
accumulate(op, array, [dims::Integer], [init])
# [dims] specifies the dimension in which to accumulate. Optional if array is a vector
# [init] sets an initial value that will be involved in the cumulative operation
```
"""

# ╔═╡ 7cbbe111-b090-46db-a96a-d4f46b75ea55
accumulate(+, Vector(1:10)) # + - * /

# ╔═╡ 7a903155-a3db-48e2-9446-7b67f86b9f8d
accumulate(-, Vector(1:10), init=100)

# ╔═╡ a878cab5-8c59-453b-9690-a0d153e99b41
# It's a cumulative comparison
# 220 is the max value for the first 2 elements, then it's 300 and then 400
accumulate(max, [100, 200, 300, 400], init=220)

# ╔═╡ 7074259e-aea1-4fe3-bba9-b2296678824c
md"""
Accumulating arithmetic operations through different dimensions on an array
"""

# ╔═╡ 320b096c-c8ea-4513-a9b6-130fb86fad94
let A = reshape(Vector(1:16), 4, :)
	A, accumulate(*, A, dims=1), accumulate(*, A, dims=2)
end

# ╔═╡ 225fb3a2-482d-41a7-85b6-97ca5913eaf0
accumulate(^, [1 2; 3 4], dims=2)

# ╔═╡ 516b1a26-66e1-40c2-8cf9-e9ec5e432bb9
md"""
```julia
accumulate!(op, dest, Array, [dims::Integer], [init])
```
"""

# ╔═╡ 482387d6-0a23-48c4-9273-6106052bfe87
let	A = rand(50:150, 5)
	D = similar(A)
	init = rand(50:150)
	accumulate!(max, D, A, init=init)
	A, D,
	init > A[1] ? "init=$init was greater" : "A[1]=$(A[1]) was greater"
end

# ╔═╡ c152587e-bf86-4332-ae21-cd6e68c5c4cc
md"""
## cumprod() + !
Equivalent to accumulate() with * as op.\
It lacks *init* though.
```julia
cumprod(array, [dims::Integer])
cumprod!(dest, array, [dims::Integer])
```
"""

# ╔═╡ 4ebe991e-89d9-45a6-8a6e-4112514c995a
let A = reshape(Vector(1:18), (2,3,3))
	A, cumprod!(similar(A), A, dims=3)
end

# ╔═╡ d0d263a1-d74d-4c44-8c44-aaa9a7ab7fb2
md"""
## cumsum() + !
Equivalent to accumulate() with + as op.\
It lacks *init* though.
```julia
cumsum(array, [dims::Integer])
cumsum!(dest, array, [dims::Integer])
```
"""

# ╔═╡ 6d96c95a-c7ea-4fe3-aae1-9f5283d4ac6f
cumsum([fill(1,5) for i in 1:3])

# ╔═╡ b8a792aa-dfdf-4dfa-adef-977450772e25
cumsum([fill(1,3) for i in 1:5])

# ╔═╡ 65e66e17-58bd-4140-aa71-aad491599375
md"""
## diff()
```julia
diff(array, [dims])
```
!!! note
	It's not equivalent to accumulate() with - as op.
"""

# ╔═╡ cae12504-2fb4-4f03-8531-a4038bddf4c4
let A = [1 5; 100 160] 
	A, accumulate(-, A, dims=1), diff(A, dims=1), diff(A, dims=2)
end

# ╔═╡ b7530092-10b2-4bef-bc03-7c578c50b5f3
md"""
Order of rows/columns matters
"""

# ╔═╡ 38e5b0de-276c-4cbd-a088-da2325297f38
let B = [100 160; 1 5]
	B, accumulate(-, B, dims=1), diff(B, dims=1), diff(B, dims=2)
end

# ╔═╡ bb47be0b-f06d-429a-89f6-f617c7fb04b9
diff([1, 5, 100, 160])

# ╔═╡ 59297ba3-dfb7-4931-8058-1ec9e935a939
let A = A = [1 5; 100 160; 1000 1700]
	V = vec(A)
	A, V, diff(V)
end

# ╔═╡ 506a9c65-62d5-4da5-9c0a-4fc7c5f30813
md"""
# Finding
"""

# ╔═╡ fd65201d-84e1-40ec-85eb-9c81cc23bfb0
md"""
## findall()
Returns **indices** that evaluate to true in the given array
```julia
findall([function], array) # If function is omitted, array must be of type bool
```
"""

# ╔═╡ 4495bfe6-4b55-4ff7-ae8f-5e45f21b4948
let A = rand(Bool, 6)
	A, findall(A)
end

# ╔═╡ 5077c94a-4a7c-4d4a-85f4-0861bb25d528
let A = rand(1:10, 2, 4)
	A, findall(iseven, A)
end

# ╔═╡ 8d34c616-c78d-4074-90fd-f682e5d95221
md"""
## findfirst() & findlast()
Returns an **index** of first/last that evaluates to true
```julia
findfirst([function], array) -> Index
findlast([function], array) -> Index
```
If function is omitted, array must be of type bool.
"""

# ╔═╡ 2e3e06e3-4d34-4da0-bf54-efba8dcd2677
let A = rand(Bool, 10)
	A, findlast(A)
end

# ╔═╡ b296da43-5eb8-4b17-b441-aa2a5582be39
let A = ["Apple", "Banana", "Chirimoya", "Coconut"]
	findfirst(x->x[1]=='C', A), findlast(x->length(x)<7, A)
end

# ╔═╡ dc87201f-9e6d-493a-9ef5-31319921f9ac
md"""
## findnext() & findprev()
Finds the next or previous index (not necessarily inmediate) to *idx* that evaluates to true, **given that array[idx] itself does not, if so, it returns that same index**.
```julia
findnext([function], array, idx) -> Index
findprev([function], array, idx) -> Index
```
"""

# ╔═╡ 884e7911-05b6-4022-8925-63dfc8405bb8
findnext([false, true, true, false, false, true, true], 3)

# ╔═╡ 39756550-3e70-4aac-94e6-6bc0a9a1d617
findnext([false, true, true, false, false, true, true], 4)

# ╔═╡ 95da77be-fb64-47a6-9939-b49facb0bf5c
findnext(x->x%3==0, Vector(1:10), 5)

# ╔═╡ b961a8ed-8375-4464-8ef9-9919f445cbb5
findprev(x->x%3==0, Vector(1:10), 5)

# ╔═╡ d3584169-87b2-4cdf-8c66-9f8586595a1e
md"""
## maximum(), minimum(), extrema()
Returns a **value** or pair **values** in the case of extrema()
```julia
maximum(function, array; [init], [dims]) -> Value
minimum(function, array; [init], [dims]) -> Value
```
"""

# ╔═╡ 8018f9b0-77f0-4351-ac0c-2f0bdea24bc4
maximum(rand(1:15, 10), init=13)

# ╔═╡ 963a113f-9df3-4e26-9ef3-129faa7e12de
let A = rand(1:15, 2, 5)
	A, minimum(A, init=3, dims=2)
	# Along dim=2, i.e. one for each row (dim=1). Also compared against 3
end

# ╔═╡ 4910361b-0379-479c-b172-dbf28462e800
let A = rand(-20:20, 3, 5)
	A, maximum(x->x^2, A, init=199, dims=1)
	# Along dim=1, i.e. one for each col (dim=2). Also compared against 199
end

# ╔═╡ 5e48b79d-a78b-40ce-9fc3-02de6f3c42a3
md"""
```julia
extrema([function], array; [dims]) -> (Value, Value)
```
"""

# ╔═╡ 2008988a-b4d2-45d3-ac5e-c6d71a07003d
let A = rand(-10:10, 3, 4, 2)
	A, extrema(x->x^3, A, dims=(1,3))
	# One for each col (dim=2), along the union of the other dimensions
end

# ╔═╡ 4e338d0f-9ac2-4648-bd42-c20363beeb7f
md"""
## argmax(), argmin()
```julia
argmax(function, array) -> Value
argmin(function, array) -> Value
```
Returns a **value** from the array for which the function is maximised
"""

# ╔═╡ c46b8549-a14b-45b8-9bb1-3ddb5c88f235
md"""
!!! important
	collect(0:π/2:2π) = [0.0, 1.5708, 3.1416, 4.7124, 6.2832]
"""

# ╔═╡ 5f0cee80-b39b-43bc-9165-61873fb6dbca
argmax(sin, collect(0:π/2:2π))

# ╔═╡ 8394cf6b-72ac-46de-afd5-3b66e9f72f16
let A = reshape(collect(0:π/4:2π), 3, :)
	x = argmin(cos, A)
	A, cos(x)
end

# ╔═╡ b5e018cb-5402-4c3b-bf0b-7a26f6d37a7c
md"""
## findmax(), findmin()
Returns a pair of **evaluated value** and **index** for which *function* is maximized or minimized
```julia
findmax(function, array) -> (function(x), index)
findmin(function, array) -> (function(x), index)
findmax(array; dims) -> (Value, index)
findmin(array; dims) -> (Value, index)
```
"""

# ╔═╡ 5ed17dc1-2e7c-44d8-a8d6-f844b4980c53
findmax(sin, 0:π/2:2π)

# ╔═╡ 7bcd8b57-ce1a-47bf-9660-51231dcac1cf
let A = reshape(collect(0:π/4:2π), 3, 3)
	A, findmin(tan, A)
end

# ╔═╡ 0d489c25-47d6-4e97-9669-48b4bd5f0123
let A = randn(2, 3)
	A, findmin(A, dims=2) # Along dim=2, i.e. for each row (dim=1)
end

# ╔═╡ fcb6a38b-9509-437e-a706-db3f6e41a981
md"""
## any(), all()
Returns true if any or all elements, respectively, evaluate to true by themselves or using the optional function
```julia
any([function], array) -> Bool
all([function], array) -> Bool
```
"""

# ╔═╡ c272a2f9-de68-471a-bc35-f20d3368e44b
any(rand(Bool, 5)), all(rand(Bool, 10))

# ╔═╡ 4a620cb6-4103-4f43-bb41-95fe1421a1db
let A = rand(1:10, 5)
	A, any(x->x%5==0, A)
end

# ╔═╡ 1ec36105-8167-4e69-a6f6-684d45213311
let A = rand(1:10, 10)
	B = rand(2:2:10, 10)
	A, B, all(x->x%2==0, A), all(x->x%2==0, B)
end

# ╔═╡ 110d28ce-9356-42f4-a448-cc57ef0cee2b
md"""
# Unique Elements
"""

# ╔═╡ 88958f32-e0da-4217-be3c-d048a12dc042
md"""
## unique() + !
```julia
unique(array)
unique(array, dims::Int)
unique(function, array)
```
"""

# ╔═╡ 05e8954f-8b5d-4bbf-a61f-49004fa0a392
unique([1,1,2,3,4,4,7,9,99])

# ╔═╡ a81e2732-3d65-4cbc-88ad-7ea3a18fb6bb
let A = [x+y+z for x in 1:3, y in 4:6, z in [0.5, 1, 0.5]]
	A, unique(A, dims=3)
end

# ╔═╡ c45ab603-2cc8-42d8-a66d-8d936596e919
md"""
The third method returns an array containing one value from the **inputted array** for each unique value produced by the application of the function
"""

# ╔═╡ b9b89763-cf67-4a7e-bd9c-4bb1c9608e1c
let A = rand(-15:15, 4, 6)
	A, unique(x->x^2, A)
end

# ╔═╡ 16498902-7ab2-40f4-b5d8-7a7084960347
let A = rand(-15:15, 4, 6)
	A, unique(x->x%3, A) 
end
# Posibilites are -2, -1, 0, 1, 2, so output is expected to have ≤ 5 elements

# ╔═╡ b32e13c2-cccd-44f6-adee-eb6aaa6573a0
md"""
## unique!()
```julia
unique!(function, array)
```
Selects one value from *array* for each unique value produced by the application of the function, then returns the modified *array*.
"""

# ╔═╡ cce54c8f-bfe2-4857-90d6-c5a3a34a3d7b
let A = rand(1:10, 20) # A initially has 200 elements
	unique!(x->x^2, A) # But unique!() will keep only unique elements produced by f
	A # The modified array is returned
end

# ╔═╡ 76de3c07-d235-4df9-abdf-bcb77c8d3001
md"""
## allunique()
```julia
allunique(array) -> Bool
```
Returns true if all elements are distinct
"""

# ╔═╡ 9ac88e71-a3da-4ee6-a610-8cff33869376
allunique(rand(1,5)), allunique(zeros(1,5))

# ╔═╡ a1699676-77ad-43e9-879d-910f74e1c2f2
md"""
# Filtering & Replacing
"""

# ╔═╡ 65d75c55-ef19-4666-baed-6e74620e7e21
md"""
## filter() + !
```julia
filter(function, array) -> Vector
```
Removes filtered elements and **returns a copy**
"""

# ╔═╡ 980b03c0-aee0-43c7-9cf0-fadfcc6dd9a8
filter(isodd, 1:10)

# ╔═╡ c98d5e2b-1116-4c05-b78f-2b5c27ff816a
let A = reshape(Vector(1:18), 2, 3, 3)
	A, filter(x->x%3==0, A)
end

# ╔═╡ bfdcb17b-5116-4f91-bea2-c33aec506c7e
md"""
```julia
filter!(function, vector || dict || set) -> Vector
```
Removes filtered elements and **returns an updated vector**
"""

# ╔═╡ fc4516ed-02b4-4b60-a987-284c98205eb9
filter!(x->x%3==0, rand(1:18, 10))

# ╔═╡ 8b40830b-024d-42db-8a9e-ff73d5580b90
md"""
## replace() + !
```julia
replace(array, old_new::Pair...; [count::Integer]) -> Copy of Array
```
Replaces *old* for *new* values in each pair. If count is specified, then replace at most *count* ocurrences in total.
```julia
replace(new::Expression, array; [count::Integer]) -> Copy of Array
```
Replaces each value x of *array* for new(x). new can be an function or a logical evaluation (ternary operator). Count works in the same way.
```julia
replace!(...)
```
Has both methods described above, but updates the array instead of returning a copy
"""

# ╔═╡ 80d38842-5c78-4257-971b-7035d93200fe
replace(rand(1:10, 3, 5), 3 => 33, 6 => 66, 9 => 99)

# ╔═╡ c8187820-08e6-4cdf-b4c4-9e95f394223e
let A = rand(1:10, 3, 5)
	A, replace(x->x%3==0 ? 11*x : x, A)
end

# ╔═╡ 0c94526f-1228-47a2-8154-4032712ec251
let A = rand(1:10, 3, 5)
	replace!(x->x%3==0 ? 11*x : x, A)
	A
end

# ╔═╡ 3991a333-8b83-4ac6-8175-c0f960ecd18e
md"""
# Appending, Inserting, Popping
!!! warning
	All these directly modify the inputted array
"""

# ╔═╡ e8b0f2dc-285c-45f9-9cd2-59b8dab6342e
md"""
## push!(), pushfirst!()
```julia
push!(vector, items...)
pushfirst!(vector, items...)
```
"""

# ╔═╡ 36cbfcc0-696c-49ca-a0e2-f6b5bd853377
let A = []
	for val in 10:18
		push!(A, Float64(val), 99)
	end
	A
end

# ╔═╡ 48cad5e4-3c95-4fc5-a9a2-5b39fe5ecfac
let A = rand(1:10, 5)
	for val in -10:-1
		pushfirst!(A, val)
	end
	A
end

# ╔═╡ 72e96dac-03b0-4951-84dc-54ee6580709a
md"""
## pop!(), popfirst!(), popat!()
```julia
pop!(vector)
popfirst!(vector)
popat!(vector)
```
Though it can be used with 1*N arrays, but elements won't be popped, only returned
"""

# ╔═╡ 36598984-a90f-4469-9b12-87b85fb8c7e6
let A = [1 2 3; 4 5 6]
	pop!(A[1,:]), A # pop!() only returns an element
end

# ╔═╡ 7bea7d51-530e-4f61-9a4f-df2fa32cbc33
let A = Vector(10:10:150)
	pop!(A), popfirst!(A), popat!(A, 5), A
end

# ╔═╡ 37c5f31a-c052-4255-b57e-34ae0cd9a693
md"""
## insert!(), deleteat!(), keepat!()
```julia
insert!(vector, index, item)
deleteat!(vector, inds...)
keepat!(vector, inds...)
```
"""

# ╔═╡ 68dc25e9-6740-4479-9df4-147067f959c9
let A = rand(1:100, 2, 10)
	B = insert!(A[2,:], 5, 999) # Works with a copy --> A[2,:]
	A, B
end

# ╔═╡ e4a10bdc-126f-4f7e-ae97-a22988698692
let A = Vector(10:10:200)
	deleteat!(A, (1:3:15))
	A
end

# ╔═╡ a472b4ee-ce7e-4b6f-93e5-22dfc5a52fba
let A = Vector(10:10:200)
	keepat!(A, [5, 7, 10])
	A
end

# ╔═╡ 24b9b2b2-5734-4300-afe2-c7f83702ed38
md"""
## splice!(), resize!()
```julia
splice!(vector, index, [replacement]) -> item
splice!(vector, inds) -> items
```
Removes the value at index and returns it. Optionally, the value can be replaced.
"""

# ╔═╡ adad9262-923e-478a-b1bf-b34f36fe7777
let A = Vector(10:10:100)
	splice!(A, 9, 999), A
end

# ╔═╡ 3e21fd57-4a8f-4ce5-ab74-2db80d2ca778
let A = Vector(10:10:100)
	splice!(A, (9, 10)), A
end

# ╔═╡ b506ead8-dbbc-4c96-a045-9ae5a5617f03
md"""
```julia
resize!(vector, n::Integer) -> Modified array
```
Resize a to contain n elements. If n is smaller than the current collection length, the first n elements will be retained. If n is larger, the new elements are not guaranteed to be initialized.
"""

# ╔═╡ 39591e4d-f7f0-4e85-82f4-df294ac72317
let A = Vector(1:10)
	resize!(A, 8) # Keeps first 8 elements
	resize!(A, 12) # Assigns 4 arbritrary, random values
end

# ╔═╡ fe2e0928-2cfc-4b7f-b77a-fc2a98a12645
md"""
## append!(), prepend!()
```julia
append!(vector, vector(s)) -> Modified array
prepend!(vector, vector(s)) -> Modified array
```
Similar to push!() or pushfirst!(), but allows to append or prepend ≥ one vectors
"""

# ╔═╡ e0b5953f-d5ef-4a04-9b9f-1200d38a192f
let A = Vector(1:5)
	B = Vector(100:-1:96)
	append!(A, B, zeros(5))
end

# ╔═╡ be79ef4c-7a63-413a-a4e5-fcf2e35baab5
let A = Vector(10:5:25)
	B = Vector(100:-1:96)
	prepend!(A, B, zeros(3), ones(3))
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
HypertextLiteral = "~0.9.3"
PlutoUI = "~0.7.34"
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

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

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

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "13468f237353112a01b2d6b32f3d0f80219944aa"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8979e9802b4ac3d58c503a20f2824ad67f9074dd"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.34"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═bb89dbf6-aac6-4b86-949f-15d293f9fe33
# ╟─8e85528f-87b5-40e5-856e-bbc53d0b3386
# ╟─3d1336b7-ef09-4097-9934-beab70188a4c
# ╠═d21bb6ba-3fff-425b-9963-e17b1c2980fe
# ╠═1d3d6267-3e60-4b00-a970-c8a5a1f891cc
# ╟─d0d503d5-9125-4eb7-bc27-a8d9a8107a5e
# ╟─feb0138f-ea46-4e85-9e3f-607906f8efb1
# ╟─1e6a5c57-1793-4604-83da-d86a0deb8a7a
# ╠═57bbc2f8-3538-4766-b064-cfb609729583
# ╠═40a8fede-a14e-43f9-b159-637bad13e753
# ╠═a06408d9-e21f-4741-91e2-7435d4aa3af5
# ╟─64270074-23af-4da0-af93-9c20e9c35f00
# ╠═0e32a99d-6d09-4084-8e80-51ac250ac311
# ╟─eae5ba7c-9783-4416-a298-2ff7e43b219c
# ╟─bb936765-9472-4fdc-8e9d-15d25c831a59
# ╟─de357118-a894-45ad-a72b-62c7cecdb2e0
# ╟─5b67de5f-2fcf-45a5-83d7-eeb8fdfd04b9
# ╠═c05cd818-df39-4528-9a98-093eb87bcdcb
# ╟─9daa2b6a-7e35-44aa-be22-151d1b7a10a0
# ╠═c6a08019-594e-40b3-933c-a05eed94cd0f
# ╟─da650a3b-f042-4b92-a071-ca299ca1408b
# ╟─78b46207-65de-4f3f-b5d0-84108235f199
# ╠═5d7f5bd1-af7a-42b9-846c-22b71d79be89
# ╠═44a13bbb-e1b6-4cb4-8abb-734e50a72326
# ╠═295b2970-97c0-459f-b098-ed9ff38d6a2f
# ╟─dbdb5ab4-3175-46aa-bd04-ae4768096f99
# ╠═2e0ece62-c125-4e5c-b5cf-7f6f4e8c0ce7
# ╠═8ab53abb-a1c6-4086-9da2-0278fc89a110
# ╠═931f7a20-4caf-4800-8c28-e6f77a6e5328
# ╠═a5f3ab46-2526-4023-a461-fe4d8d7f6f24
# ╟─4f579584-0e6e-4e53-bd0c-2cf7907c1fef
# ╠═db99b7d5-4067-436a-bbe9-917903af2b55
# ╠═87a27948-7182-4994-bedd-0aed5a580737
# ╠═0f8218e0-0402-4cef-a75c-00da836b25ba
# ╟─19403748-3592-4cc9-b28e-fb0b9184ef3f
# ╠═f0b917ae-fc72-42d7-9c75-f5728b741290
# ╠═924ca07b-ce90-474f-91cd-5d80d40404a3
# ╟─0a64c8e6-0334-4be7-b6b9-07d0416d1d6c
# ╟─581fccac-d4f1-4ce8-b9b4-f869db77364a
# ╠═57a63bba-e9b2-4d8c-b8ae-da4e4e87adee
# ╠═389523b5-b84c-4816-913a-9f70b78049a0
# ╠═9ef56b70-a019-4d12-ad55-ac8a97124226
# ╟─3d719516-7ec7-4279-bc9f-3d104899842a
# ╠═c9e303d6-3612-44ee-af33-59892cbf8f40
# ╟─a44495ff-3c9c-440f-9652-874d72e1f616
# ╠═3bbb3adb-d0fd-48c6-be10-1c3baf060593
# ╟─e610d850-12c6-4e15-a39c-c01a08948b33
# ╠═567d7bdb-6c9f-421a-9150-a2911f6e3f40
# ╠═6af94384-f63f-43ca-96d2-ed17319a0e92
# ╟─f5864b45-d59e-43b1-94bf-1120c82d89c3
# ╠═d3f1380d-d715-4bc1-8cd7-e9005fd6b873
# ╠═bb7c7d68-e967-4022-8000-1bec87f7ea5f
# ╟─2cabc082-748e-44bb-951c-08de8b79ed49
# ╟─921fd462-55b8-4cae-a877-2b7ad5fa4929
# ╟─278085f8-4e4c-4dfd-9d0f-f9e6905bfd98
# ╠═22913113-08f5-44cc-aefd-da458e27441b
# ╟─8ee7b977-601e-4595-ae61-3c33393064ac
# ╠═1319256f-eeba-4f3b-bf1d-4b33f60ec45e
# ╟─ea32e3ae-03de-4e3e-9fcd-6fccf1e4064f
# ╠═c1a247de-24d5-45a8-954e-fc4a5ff8d3ee
# ╠═000b3555-74bf-43e5-9f01-e45b2e832e37
# ╠═1a0e794d-c05f-466b-a552-fdbb59bc2dd3
# ╠═d08fafcf-0542-4da7-955b-48ba4bf35c15
# ╟─5110647c-6314-4c32-b5db-309cd330ce1a
# ╠═759e4cdb-858c-45e8-8db7-4df35b4bd6fa
# ╠═ca0b4bf2-bc3d-4c81-8957-62cfcc8c438e
# ╠═50d02a76-ad72-4db3-b6b5-515ade21fc40
# ╠═02e3cf29-a67a-4c13-b279-31f8cc9e4c09
# ╟─a6a7090d-bd10-4ca6-8c30-1fdb3d17b727
# ╟─a09fb115-aee1-46ee-b0ac-9d954908b365
# ╟─8f76e78e-701b-4cc3-90a8-fa3a3edb2e3e
# ╠═ebdd35b2-179a-4e1c-a7ec-1c02eef3893d
# ╠═26600b56-5477-4212-a41d-221523f39057
# ╟─d62485fa-fbc8-4555-bd56-6374a3d1d0f5
# ╠═bd8e0a35-eae5-481c-8a9a-1b97fa01db63
# ╠═d7bebf65-6737-4023-9fb4-39a9ae3bc365
# ╟─2d627404-2c64-41d1-bdb7-37349668c96f
# ╠═e9896ac8-a3a7-4cb7-a006-8b090726f500
# ╠═2915f291-084a-40c2-91c0-9fcfa56982d0
# ╠═1ea7e650-d9fc-430e-8523-f866351393a5
# ╠═a278c88f-f297-47db-af45-a3befacd1957
# ╟─2b18429b-c65d-4a1d-b98f-faf3df9efc46
# ╠═166415a5-d624-4109-8ac4-5e19be8f8fbc
# ╟─7aee0822-57c9-487d-8c4b-dde788778723
# ╠═86e70306-9fb9-4417-a483-667be982bd59
# ╟─42b61c64-9fce-49a5-aaa2-46cda0927821
# ╠═f6b1b6a9-6b43-40bb-b0e7-bbe4990e5eaf
# ╟─de62d171-4ae9-4483-a2bf-549a8a1a4af7
# ╠═ab0bf66b-f042-4725-9b06-b85d807a8a12
# ╟─8f2f340a-64f3-4317-bb88-7fdca99c0ba2
# ╠═08b348c5-1603-450d-a1d1-6d12e23f1483
# ╟─f8077ab3-f61d-4378-80e0-6bccb058a96d
# ╟─59d335f6-7263-4754-b077-eb60b2a249ba
# ╠═6b039636-345a-4eb6-8d9e-cbaa85d8c330
# ╠═94681a6d-d97a-4c9d-93e2-1966e3af9210
# ╠═0d7ed0fd-5b9e-4a63-a8ea-dc4c515dee6f
# ╠═b7c762cb-4b51-49c3-9e21-ffb31efcbcec
# ╠═a9bc4e79-4596-4726-884f-09a225d27cf8
# ╟─9677984d-55c5-4790-8973-c03ef928da77
# ╟─96b49b6f-4b77-4a94-b1ab-12658e9b85ea
# ╟─5b165209-92f9-4bd5-a061-8b7b98a0e554
# ╠═215d5ff6-2867-45ce-be4e-37a0ebc9c617
# ╠═a42e3e24-029a-4208-84ba-4cff98a6279a
# ╟─1decbef8-0f26-4b17-bee0-a77f696a724d
# ╠═19cc7849-f17d-4957-8156-00a296826f4f
# ╠═99d77508-b4c0-44a3-91f4-46f9d8b772e6
# ╟─e26d1092-9d88-4263-b26c-37ed4f62b3b3
# ╠═7d9656a1-d2e0-4f67-adc0-47acc9299479
# ╟─7b31e5a4-3e84-43cc-94c0-d3568ac76522
# ╠═584d198d-bbbf-45f1-8e04-4baf5cffafee
# ╟─c87d9f81-8ded-43f5-a2bc-ac8f88398a53
# ╠═2f94d5df-9e85-424a-bb3f-9af462d570aa
# ╟─9f99c04b-c633-4c07-ad14-636465d05470
# ╠═c90a8de1-0d77-4069-8581-a66a51343099
# ╠═bb0c51db-1be0-4900-8eff-3624a25793e4
# ╟─251ac698-74c4-41e9-b15c-3be5866908f7
# ╟─cf6ed7cd-b826-4991-a3a7-c51d09988fa6
# ╠═8a5c603f-6d72-45f8-aa7e-9095bc6015d8
# ╠═13881b55-f09a-4133-aa4e-84935f5d803e
# ╠═9f4f9f97-c858-45bd-b466-94ff20a09738
# ╟─94833fbe-0ba5-4bb1-be08-01c2c841eb78
# ╠═1da295d3-1ffe-4f4d-9d07-391519bedcaf
# ╠═2c7a09b1-1d04-4e7c-a0b6-038c1f2f2b4d
# ╠═5bb235c9-e465-4326-a59a-745e67be2d11
# ╟─ad901061-01cf-441a-8f49-6379fb1b6216
# ╠═f467811d-dbaa-4c9d-8aa4-e310641cb11f
# ╠═35f411f9-eb32-4dbe-9ecc-b511dcfac138
# ╟─54aa3993-73eb-4ac9-baeb-52dfb49c1c15
# ╠═5a9cbb1b-a208-4c3f-a4fd-9c90e79702a5
# ╠═32a2461c-4026-4013-a2bf-a522590232a5
# ╟─fdeb4ee4-46de-4c9f-93cd-a1e0e973e939
# ╠═43e61d4e-36ab-4549-ae38-2199bb52a9ec
# ╟─c29b8676-4efa-4bf1-a5e2-9f8a3c49ba9f
# ╠═9bc0805b-a2d6-4ed8-b873-14868a112021
# ╠═129df6fe-3bec-4231-971a-a5309d069653
# ╟─ff7b1f6e-e80c-4117-a860-f03df4bbfded
# ╠═629a860f-8f34-4be0-b79e-810ab95afc45
# ╟─4e09b6ee-1f5b-4435-b111-815f4ea29da3
# ╠═495c85da-806d-424a-b8be-dadc632abce9
# ╠═33265322-2ab6-4eae-a9a2-21171770de6a
# ╟─f8117b5a-e652-4896-8d40-3da772af5bd4
# ╠═ba65ff51-052f-4a65-bc87-85e015deacc0
# ╟─a7aad93e-7717-49db-b58a-3ab527663d94
# ╠═8b3907f9-fd11-403d-b6f3-61d621994980
# ╟─b8b34db2-e974-4a37-abeb-d07ae06a5ac9
# ╠═60cf797a-61bc-483a-bfa7-c56ebeb2070b
# ╟─4d2d6959-59d4-4660-b007-2ecd0d3003e7
# ╟─ab6b43b2-3e2d-4d88-8155-c0a8cb103ee0
# ╟─f5eecee2-54e4-4bf0-be24-61671a1099ed
# ╟─aa044d93-cd07-469c-a4e2-48245654ccb2
# ╠═effe8dec-9b64-480b-a4ef-a5160349b928
# ╟─10eb76b2-5938-465b-884c-aea51e0ff931
# ╠═a2f6d5a6-e6e8-4a63-9f05-0ebce06e0757
# ╠═79e70773-b54b-4108-a739-538c9699da48
# ╠═76b8b578-0bf2-4060-9bb3-21849e9d6274
# ╟─84abadd1-22a9-4614-a00e-e3e6dd4f3563
# ╠═1af60b3b-9ce4-4c63-aefa-d36210967dd7
# ╟─a6bb1868-4ad7-4975-aa60-9591116f5958
# ╠═2162300f-4bc8-4ff7-824e-78122560ac56
# ╠═188f675e-6a32-4dfd-be6a-24fa60d1979d
# ╠═8a049c92-8f02-48cf-a2c9-00b1933d1ee7
# ╠═a595e1d7-7b64-4b45-a247-75bd800f8e00
# ╟─2b4a917d-7238-4190-9c6f-be23e150183e
# ╠═def69adf-ff2d-452b-b086-37030cb47ffa
# ╠═6ff2059a-fb2c-41ec-98f4-77055ea81351
# ╟─2a9ca801-73a9-4eaf-a655-f71510081bcd
# ╟─15a451dd-54c1-4c1a-aed6-d19a4a32d26e
# ╠═d3042530-844c-4f71-b69b-cef5657a6a1e
# ╠═39e37280-9f6a-470c-be1e-7d4a425d2eea
# ╟─7a8abcbc-f05e-4891-9b02-daa213e8745e
# ╠═c77f8459-9826-4776-a7fa-d853ec191851
# ╟─6a129f40-c99c-473d-8e45-3646ad06d006
# ╠═50092053-d77e-4600-90f2-db15286a039f
# ╠═a73ec280-8332-45f9-93b3-40ef19075a60
# ╟─eca06a7b-1b0f-459c-9fee-ebcbe7381074
# ╠═ca54ce1f-02d9-4bf2-acb0-91d83e8ffd6b
# ╠═3286ccf9-31ea-43de-829c-a191e38f0da8
# ╠═e1821a01-9128-4128-960a-2d30d96ac6ec
# ╠═eae0735d-7d16-4e64-9b7d-ac32b3a334c3
# ╟─39889f77-6ada-42e5-8d5f-e0fb66703d26
# ╠═e5e22778-3137-469c-bddd-261102385991
# ╠═4ca21214-c9c8-42e7-9e4f-0f9f35c93416
# ╟─dbcf5707-3a29-42a2-895a-4c4d141d9300
# ╠═87600bd6-c8a6-4e93-a529-eed6b1fc1f3c
# ╠═450edefd-6376-4a96-93c4-100417f81947
# ╟─846da198-a0f7-4ab9-a65c-29b365c22864
# ╠═0fe8399e-d422-418b-a837-8913b13b5afc
# ╠═dccfc62f-532b-48ca-b44c-cb48f0e85a63
# ╟─5511bb76-f575-429a-81a5-def781a9ec02
# ╟─17b1c41e-2119-47d4-8498-8e61894ad0c7
# ╠═a5bbd46c-202e-4a84-aed2-719a9054cf83
# ╟─01a9a853-c176-44aa-8a61-96378157cb44
# ╠═985d9f55-1ce4-48f0-8031-6d66d89033e0
# ╟─72fb4066-c74e-4e39-8dc8-1e6d287ba1d5
# ╟─dbe8a9ea-6040-4c0a-af1c-cb037ec4705c
# ╟─ab651de1-e299-4060-af6a-516f2d8a5b2b
# ╠═c34d93cf-3f7f-4427-bb1d-e00b868d523d
# ╠═01e9aee6-38a8-455b-b8e5-8a2d077629a3
# ╟─fd7d2a46-385b-4a13-a7e6-308e621ee5eb
# ╠═1ca4334b-03fe-47cc-8018-8ce0a729b24d
# ╠═003aa441-0d00-41c7-a95f-3c8db097295d
# ╠═0f76c005-f079-4620-ad3e-1e6b3b9e6708
# ╟─1d147ed6-f640-44b0-947c-be95f93a0754
# ╠═6b9409d4-44ac-4953-b8ef-fd90d7732796
# ╟─f06c0ec3-b133-4f7d-adc4-c547af0cf9be
# ╟─d7cd3384-e43a-468d-9c84-acb24819bce0
# ╠═2d6ad9bb-ba34-4d91-b716-0a94d426f3d8
# ╠═b7d3a9ed-b5fd-49a6-aec1-a45b86d5d8f6
# ╠═0dbbcee3-677f-4130-a042-fa8552325e80
# ╟─5b3d6f5b-abab-4444-9fae-149946e0e646
# ╠═b61c193d-5a0f-4280-a5a6-1ef28c37de0f
# ╠═571e4643-7413-4922-906f-3ba4204a91b2
# ╠═439ec2f8-d31e-47d3-b07c-14da02cdfc52
# ╟─471680dc-4e81-45a4-90a9-6fe4c8cf0ac5
# ╠═166f79e0-c94c-4152-a498-42cb9e14387c
# ╠═b6140c08-7ab3-4df8-8ad9-186c49c2c8ce
# ╠═b951c3e0-5e29-429d-bbb1-a4a9cc47baaa
# ╟─6a46ac62-8988-4beb-96e8-be623c55c8ac
# ╠═2909d091-49cf-4d76-9432-54cc11fa695b
# ╠═c98ba8e5-65a4-4c29-a954-f8979315ada8
# ╟─d631a821-abc1-45dc-b7a3-28f356622832
# ╠═edb08880-3a9e-4cc5-a289-c46a6293985e
# ╠═a5027f6a-dc01-4410-92d0-7df99cced029
# ╟─2e5fd8b7-ed17-43bd-9e68-40f2a2cf8315
# ╠═6af84834-d43c-4fd3-80ce-40cf4521b731
# ╠═fe77f068-14a6-4731-aeb4-06e7ee9987b0
# ╠═9f6e30fb-a08e-492b-9c67-f439f21cd986
# ╠═c26cf7de-32fb-43e1-a70c-87763c97e43d
# ╟─a66791ff-0ea9-416a-b058-a05a5be66081
# ╠═b342a84a-0890-4219-9bb3-d3c1c1c2fcf3
# ╟─d50d4d24-5c3e-44dc-a789-288009e6a0c4
# ╟─fb4865eb-a5a5-48dd-84e0-f806b2575245
# ╠═e89e4f15-473f-4b32-9ef5-5567f4339c7f
# ╠═95dc9315-baa8-4a89-ad1a-155598050162
# ╟─f41ff9ab-ba3c-4f69-994d-f6f95c87ae47
# ╠═85448658-a80b-4d0e-a0dd-2bc43dc8958c
# ╠═9b90b20a-7c31-455d-9dbf-ce1157e190cd
# ╟─2bc2dc15-ea83-4ff6-93bf-f163bb7a89c8
# ╠═b3cca955-661d-4895-9330-d0340aa17e72
# ╠═f76acc60-0937-4f56-8cf9-15b755438fb5
# ╠═f7aea7e1-eee3-4107-a8c1-31d072cabb30
# ╠═8e8a0817-e3bb-4722-9c7b-f97733725a87
# ╟─8b72023e-dd9e-4715-9861-3a90742a1b63
# ╠═80665de1-f6bd-4d9b-872b-8569ca82d667
# ╟─56e4c61d-5b7c-4939-bd24-a50934a93b2c
# ╠═7a3f8a47-51ce-4d1b-831e-25cbceafcb6b
# ╠═7dae5adf-58c6-4017-851e-e62e05d109bc
# ╠═dfd598cb-6fdd-4bb6-8a79-714f9e0350ff
# ╠═697aaddf-aa12-468e-81c8-e37aadcc78f2
# ╟─87925f5c-e467-4708-aa11-6eb7d8967f1e
# ╠═8c4184fb-5c17-4a7d-9835-eb89fbebd84c
# ╠═278158c0-4df5-495f-bfec-56a9cd9a381f
# ╟─ebfcaaf1-2c47-46cf-8b50-2854ea46d363
# ╠═835c9cbe-e23f-4781-af2e-4f4cd480a72a
# ╠═2f43ec7a-758b-4435-9336-d518f82f6bab
# ╟─c74d2650-36e7-49cd-9a14-89969e220e90
# ╠═8e30c230-c3b7-47cd-884d-ec5ee140de19
# ╠═6e80b81f-8fbe-4e78-a4f0-28e9db1ab13c
# ╟─a3629544-01bc-40ac-b14b-1733460c9ceb
# ╠═6b36ac49-c4ba-4fdd-8912-fd3aa33fcb08
# ╟─29e61f40-a8f4-4517-9af9-91a7ae180432
# ╠═e14f5abd-b5d8-4f0f-aa84-319d94e3d73a
# ╠═a010f844-9d29-458f-9c12-0b9e9ac87537
# ╠═e6a9722a-3893-40cf-8584-b1475fbb76f8
# ╟─24c92168-1c1a-4950-9bce-b19694dd9ee7
# ╠═ff4878a8-1bc4-4a09-91e9-7259d7392c2f
# ╠═2ccffb9b-587e-49ae-accd-81abc3cd51ca
# ╟─3ac69ce2-af9f-429d-9684-2f6f7a9f3a47
# ╠═c495ca36-e19c-44e1-a4de-d0c2a8a4793f
# ╠═cee01e0c-1baa-4898-b793-92d53a0ca631
# ╠═6af3f2e1-fcc9-4d95-87d2-b1035fb822cb
# ╠═87783e7f-22b1-47ed-9724-a0a504f93dc9
# ╠═f1c7f692-4204-4580-955d-b58d773adb67
# ╠═099edc68-8058-4d59-bfd2-7385e89ad981
# ╠═7ec02e9e-ad65-4dc6-9acc-1c14f9feccf3
# ╠═912b14f9-094c-4415-9e65-beffabfef1e6
# ╟─0a9e72f8-9cec-4e81-98b6-173854d4e41d
# ╠═f653ca98-ae7f-412a-bd24-39776dbd747e
# ╟─e1db9cef-5576-4ee4-b5f7-e97286f95ae7
# ╠═b2a790ff-08fe-4c0a-832d-c41e6c489209
# ╠═5514d620-3d31-47c0-b749-aca51fbfe3ae
# ╠═69b451df-2003-4788-98a4-1a22bd49bee8
# ╠═37c0230d-d2ec-49ab-89df-d072aa3f8f31
# ╟─55ad938e-e41f-499c-b2df-5fad5d3f6957
# ╟─7e2da9ba-b158-48d5-a002-ed34b48c9cbb
# ╠═f1c16eaa-afaf-4b9c-8c63-568003cd29cd
# ╠═0a81d44e-0f9a-4ef8-9456-d0515d995b27
# ╟─27f92a0c-bccc-4e0c-a7cb-66536a9c9157
# ╟─40ae78f3-33ff-4475-bde9-68d7bfde024b
# ╠═765ecc00-f506-4f09-b0b2-3eb0f7f03345
# ╟─30e8a0b0-bc74-41ca-a9b2-24e762b676d9
# ╠═896682bb-3ec6-46df-a2e2-4ee18f43b191
# ╟─dcb1ef63-7d94-4f89-89ac-e86e90b54c6a
# ╟─fd5a242a-3384-4dca-aa92-51b62f0377d7
# ╠═519f6d73-274c-4752-8d20-71e7c9e0005d
# ╟─f227d565-231d-442b-b558-3e885a8c2f30
# ╠═2de2d2b9-39d8-483c-b26e-7b3d1eee6fbe
# ╠═1e71dfba-e53d-45f7-8b5c-76ec7fcb27e7
# ╟─efe04b28-3d74-4a28-8a2e-e764adead3cd
# ╠═89fab077-25bd-4578-ae92-8562ddb67018
# ╠═4fafa03b-ae0f-4836-8649-83a3424b5361
# ╠═749ec334-cbe5-4218-91b9-2490e82c19bb
# ╠═72916308-bd79-4469-8f40-38b4325c693d
# ╟─ef92324e-9395-4960-98a9-eaafa3ed32d4
# ╠═54a1539a-7f35-466e-8b64-7edb034a6cec
# ╟─eb89e7f9-21dd-4132-a4ad-a50a8fb26dd5
# ╠═93b8fae8-7af1-4cd1-b1e4-0a43274eb8e8
# ╠═ede2bd03-a8f2-4fba-bbd8-c826225aa8de
# ╟─175df8ad-d02b-43c5-b6d2-4c4dee8dfb8a
# ╟─76b316e5-8a76-4216-9b54-6ba9bf2b64d6
# ╠═eeb8450d-3079-4c88-acfc-3c9a151d9d71
# ╠═063410ea-18e2-47fa-bc12-9f8c4de9936a
# ╟─648de74c-ad4d-46a5-b487-3c67c3a13848
# ╠═703cde05-ad97-4c5d-af51-3738a38b1282
# ╠═f6093bef-24d4-4abb-9443-fda087368a31
# ╟─8eddc139-2bbc-497c-a2e0-3060e72b2cbe
# ╟─f3f4d4ea-1220-4e49-96e5-0078dae5ee3b
# ╠═479f7d6d-bbdb-45e8-9552-783ce8fbfbf4
# ╟─2d18cab9-d665-44c0-8204-9d16744d7510
# ╠═dafa8d33-a901-4d1d-a10f-f58759e55058
# ╟─e4d270ce-e270-4b48-a7aa-62bdef85842c
# ╠═76622412-1a9f-4fdb-b08b-af8ec45c2364
# ╠═7deb4428-a063-4288-b144-8f07575dbdd8
# ╟─ec017bf1-6814-498e-8af8-8eeb92e1cfee
# ╟─681f3d6b-1296-4da6-b2b6-9e8461b99889
# ╟─359e688b-9586-42db-9d3b-07fb6cd372f0
# ╠═2da40598-b938-4939-91af-9eab4cb86bd2
# ╠═d05446d8-13fa-4338-b82f-d6db18a818c1
# ╠═b822e3a8-5096-4415-bff9-91a18552dafd
# ╠═a335bd65-a4b4-4f71-b879-26bb8154056e
# ╟─19408d55-1a68-4d5d-95e7-d2ba8c3ae29f
# ╠═b750afa0-b46f-4ae4-88b4-481b61a166a7
# ╠═0b207ae2-f4b6-402d-862c-ab7c39db8eac
# ╟─e73b7d26-05b9-4881-b05a-dc0ff27ece45
# ╟─a01883ac-f370-4bff-a552-b4dca8f915bd
# ╠═48c0d2b9-a827-424f-893e-db7cf0e6288e
# ╠═6de1f6de-2df9-4a07-a168-779c08954461
# ╟─8230a814-3ea0-43e0-93ce-60fbb325d673
# ╠═8131f2cf-07a1-443d-b66f-3de14ab81dc9
# ╟─a9ba9164-990b-4a57-9f75-fcabd5342a64
# ╠═6cfed146-f97c-4678-871b-9d044355f7f0
# ╠═bdc56b81-8b23-4187-8fde-58f9e58aeb20
# ╟─c207f4ca-0af8-40b8-8593-4d7d453787c8
# ╟─29a5522c-4218-4d57-bf82-4170b24ff3f6
# ╠═80b4a9e5-d2de-4b9d-957a-714bea37ece3
# ╟─8b96b18f-d759-41d3-b6b4-624d9c669611
# ╠═379cc9bb-a7f3-4d19-a20e-c64a30d1fff9
# ╟─9f99ee18-545d-4f08-8e31-84e887f9fe42
# ╠═3b476d8c-67cd-4517-931d-9fde0aa061ea
# ╟─a13bdcda-e927-496f-a7d9-d8897ae2973e
# ╠═8ecc8772-d5e7-491d-9865-624f37db1fe8
# ╠═e56cec13-c880-4247-b650-316a2a2e0a6b
# ╠═9221fb9e-42fd-4175-84cb-fcd3bab31363
# ╠═7387975c-4ace-4a03-b1b4-cb1d81113014
# ╟─26ec757a-a941-4233-bb17-7947cdf4d997
# ╟─303d4529-db84-4528-9499-be1a7945875e
# ╠═7cbbe111-b090-46db-a96a-d4f46b75ea55
# ╠═7a903155-a3db-48e2-9446-7b67f86b9f8d
# ╠═a878cab5-8c59-453b-9690-a0d153e99b41
# ╟─7074259e-aea1-4fe3-bba9-b2296678824c
# ╠═320b096c-c8ea-4513-a9b6-130fb86fad94
# ╠═225fb3a2-482d-41a7-85b6-97ca5913eaf0
# ╟─516b1a26-66e1-40c2-8cf9-e9ec5e432bb9
# ╠═482387d6-0a23-48c4-9273-6106052bfe87
# ╟─c152587e-bf86-4332-ae21-cd6e68c5c4cc
# ╠═4ebe991e-89d9-45a6-8a6e-4112514c995a
# ╟─d0d263a1-d74d-4c44-8c44-aaa9a7ab7fb2
# ╠═6d96c95a-c7ea-4fe3-aae1-9f5283d4ac6f
# ╠═b8a792aa-dfdf-4dfa-adef-977450772e25
# ╟─65e66e17-58bd-4140-aa71-aad491599375
# ╠═cae12504-2fb4-4f03-8531-a4038bddf4c4
# ╟─b7530092-10b2-4bef-bc03-7c578c50b5f3
# ╠═38e5b0de-276c-4cbd-a088-da2325297f38
# ╠═bb47be0b-f06d-429a-89f6-f617c7fb04b9
# ╠═59297ba3-dfb7-4931-8058-1ec9e935a939
# ╟─506a9c65-62d5-4da5-9c0a-4fc7c5f30813
# ╟─fd65201d-84e1-40ec-85eb-9c81cc23bfb0
# ╠═4495bfe6-4b55-4ff7-ae8f-5e45f21b4948
# ╠═5077c94a-4a7c-4d4a-85f4-0861bb25d528
# ╟─8d34c616-c78d-4074-90fd-f682e5d95221
# ╠═2e3e06e3-4d34-4da0-bf54-efba8dcd2677
# ╠═b296da43-5eb8-4b17-b441-aa2a5582be39
# ╟─dc87201f-9e6d-493a-9ef5-31319921f9ac
# ╠═884e7911-05b6-4022-8925-63dfc8405bb8
# ╠═39756550-3e70-4aac-94e6-6bc0a9a1d617
# ╠═95da77be-fb64-47a6-9939-b49facb0bf5c
# ╠═b961a8ed-8375-4464-8ef9-9919f445cbb5
# ╟─d3584169-87b2-4cdf-8c66-9f8586595a1e
# ╠═8018f9b0-77f0-4351-ac0c-2f0bdea24bc4
# ╠═963a113f-9df3-4e26-9ef3-129faa7e12de
# ╠═4910361b-0379-479c-b172-dbf28462e800
# ╟─5e48b79d-a78b-40ce-9fc3-02de6f3c42a3
# ╠═2008988a-b4d2-45d3-ac5e-c6d71a07003d
# ╟─4e338d0f-9ac2-4648-bd42-c20363beeb7f
# ╟─c46b8549-a14b-45b8-9bb1-3ddb5c88f235
# ╠═5f0cee80-b39b-43bc-9165-61873fb6dbca
# ╠═8394cf6b-72ac-46de-afd5-3b66e9f72f16
# ╟─b5e018cb-5402-4c3b-bf0b-7a26f6d37a7c
# ╠═5ed17dc1-2e7c-44d8-a8d6-f844b4980c53
# ╠═7bcd8b57-ce1a-47bf-9660-51231dcac1cf
# ╠═0d489c25-47d6-4e97-9669-48b4bd5f0123
# ╟─fcb6a38b-9509-437e-a706-db3f6e41a981
# ╠═c272a2f9-de68-471a-bc35-f20d3368e44b
# ╠═4a620cb6-4103-4f43-bb41-95fe1421a1db
# ╠═1ec36105-8167-4e69-a6f6-684d45213311
# ╟─110d28ce-9356-42f4-a448-cc57ef0cee2b
# ╟─88958f32-e0da-4217-be3c-d048a12dc042
# ╠═05e8954f-8b5d-4bbf-a61f-49004fa0a392
# ╠═a81e2732-3d65-4cbc-88ad-7ea3a18fb6bb
# ╟─c45ab603-2cc8-42d8-a66d-8d936596e919
# ╠═b9b89763-cf67-4a7e-bd9c-4bb1c9608e1c
# ╠═16498902-7ab2-40f4-b5d8-7a7084960347
# ╟─b32e13c2-cccd-44f6-adee-eb6aaa6573a0
# ╠═cce54c8f-bfe2-4857-90d6-c5a3a34a3d7b
# ╟─76de3c07-d235-4df9-abdf-bcb77c8d3001
# ╠═9ac88e71-a3da-4ee6-a610-8cff33869376
# ╟─a1699676-77ad-43e9-879d-910f74e1c2f2
# ╟─65d75c55-ef19-4666-baed-6e74620e7e21
# ╠═980b03c0-aee0-43c7-9cf0-fadfcc6dd9a8
# ╠═c98d5e2b-1116-4c05-b78f-2b5c27ff816a
# ╟─bfdcb17b-5116-4f91-bea2-c33aec506c7e
# ╟─fc4516ed-02b4-4b60-a987-284c98205eb9
# ╟─8b40830b-024d-42db-8a9e-ff73d5580b90
# ╠═80d38842-5c78-4257-971b-7035d93200fe
# ╠═c8187820-08e6-4cdf-b4c4-9e95f394223e
# ╠═0c94526f-1228-47a2-8154-4032712ec251
# ╟─3991a333-8b83-4ac6-8175-c0f960ecd18e
# ╟─e8b0f2dc-285c-45f9-9cd2-59b8dab6342e
# ╠═36cbfcc0-696c-49ca-a0e2-f6b5bd853377
# ╠═48cad5e4-3c95-4fc5-a9a2-5b39fe5ecfac
# ╟─72e96dac-03b0-4951-84dc-54ee6580709a
# ╠═36598984-a90f-4469-9b12-87b85fb8c7e6
# ╠═7bea7d51-530e-4f61-9a4f-df2fa32cbc33
# ╟─37c5f31a-c052-4255-b57e-34ae0cd9a693
# ╠═68dc25e9-6740-4479-9df4-147067f959c9
# ╠═e4a10bdc-126f-4f7e-ae97-a22988698692
# ╠═a472b4ee-ce7e-4b6f-93e5-22dfc5a52fba
# ╟─24b9b2b2-5734-4300-afe2-c7f83702ed38
# ╠═adad9262-923e-478a-b1bf-b34f36fe7777
# ╠═3e21fd57-4a8f-4ce5-ab74-2db80d2ca778
# ╟─b506ead8-dbbc-4c96-a045-9ae5a5617f03
# ╠═39591e4d-f7f0-4e85-82f4-df294ac72317
# ╟─fe2e0928-2cfc-4b7f-b77a-fc2a98a12645
# ╠═e0b5953f-d5ef-4a04-9b9f-1200d38a192f
# ╠═be79ef4c-7a63-413a-a4e5-fcf2e35baab5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
