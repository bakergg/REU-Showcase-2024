### A Pluto.jl notebook ###
# v0.19.45

using Markdown
using InteractiveUtils

# ╔═╡ 5a894fc9-8780-4037-9502-38507da2a768
using LinearAlgebra,GCPDecompositions, TensorCore

# ╔═╡ 1e373ec0-5501-11ef-3950-53bb96fe651e
md"""
# Normalization and Weight Absorption Function
"""

# ╔═╡ f5764676-1dc5-4dda-a6ee-d80d2b6e9293
html"""
<div style="display: flex; justify-content: space-around;">
    <figure style="position: relative; width: 100%; margin: 0;">
        <img src="https://i.postimg.cc/VkqJq035/image.png" alt="Monkey BMI Graphic" style="width: 100%; display: block;">
        

    </figure>
</div>
"""

# ╔═╡ 48da1f48-e471-4248-95bd-17f3433feafc
md"""
## The Function
"""

# ╔═╡ f1a34cec-4618-4a2a-8ccd-890987ee25ea
function cpd_normalize(M::CPD, p::Real = 2)
    weights = M.λ[:]

    for matrix in 1:ndims(M)
        scaling = [norm(M.U[matrix][:, col], p) for col in 1:ncomponents(M)]
        
        weights .*= scaling

        M.U[matrix] .= M.U[matrix] ./ scaling'
    end

    M.λ[:] = weights

    return M
end

# ╔═╡ 6f494c27-6380-4b30-bcf5-79c4fa02aaae
md"""
## Usage and Examples
"""

# ╔═╡ 6f5509a7-031f-4ea5-880c-43abb4a85a8e
md"""
### #1 - L1 norm (Manhattan Geometry)
this norm purely adds up all values in the column and uses the sum as the normalization factor
"""

# ╔═╡ 7da986f3-f336-4ecf-a0e8-d51366fc6f89
X = CPD([1.0], (ones(3,1), ones(4,1), ones(5,1)))

# ╔═╡ e912cb2d-8d17-4e5e-a361-6725f484e84f
X.λ

# ╔═╡ 781ffdfe-57b8-49a1-ab86-4951f33efe21
X.U[:]

# ╔═╡ 9a8fee1d-f83d-4019-a424-9f5e5100c2ab
cpd_normalize(X,1);

# ╔═╡ a7775946-6532-4c1d-aad2-2f43fdabe5e2
X.λ

# ╔═╡ 87fa49b9-72a1-4fc0-b8f1-317d7e60bd0c
X.U[:]

# ╔═╡ 89bef267-6677-4e4f-8a87-b48b15d86126
md"""
Divided the first matrix by 3, second by 4, and third by 5.
"""

# ╔═╡ 3c00f0a7-018b-46e5-b83f-f25c5a113d70
md"""
### #2 - L2 norm (Euclidean)
the default norm (sum the squares of each element and take the square root)
"""

# ╔═╡ d364a4dd-eb80-4a93-a2e2-ae5352e812f0
Y = CPD([1.0,2.0], (ones(3,2), ones(4,2), ones(5,2)))

# ╔═╡ 14e92a0d-5e2d-4648-bfc0-d1729057a86b
Y.λ

# ╔═╡ 4e3c9458-bf9f-4bba-a95b-b2fc2d934852
Y.U[:]

# ╔═╡ 73c2e516-2e6e-4f89-98b0-bc2f5c8652c3
cpd_normalize(Y) # Does not need specification, function defaults to L2

# ╔═╡ 213f277c-ec58-44a2-af67-0441cbdc4f49
Y.λ # lambda weight absorption

# ╔═╡ 0676449b-55bf-467d-aad3-f094776ef5e4
Y.U[:]

# ╔═╡ 4e5fffb0-7a7f-4207-923a-48e3695fd5ee
norm(Y.U[2][:,2])

# ╔═╡ e836904d-6351-4cc1-a6d0-2228520a7ab6
md"""
### #3 - Inf norm
this norm takes the biggest value in that column and uses it as the normalization factor
"""

# ╔═╡ 6a2f5246-4d32-4f46-b3c9-f189461be725
Z =CPD([1.0,1.0,2.0],(float([6  4  2;
	12 8  4;
	18 12 6]),float([1  2  3;
	12 8  3;
	18 12 3]),float([1  1  1;
	1 1  1;
	1 1 1])))

# ╔═╡ d6094fdb-7828-46eb-b798-49228e62d39b
Z.λ

# ╔═╡ 2795a6b9-76eb-44d6-8fee-85f67c0f660d
Z.U[:]

# ╔═╡ 033e8a5d-6272-477a-b37c-444440e767d3
cpd_normalize(Z,Inf);

# ╔═╡ 8827553e-c189-42ca-b4a1-3d634338ef6a
Z.λ

# ╔═╡ 6c9eb704-a0d2-4caf-a8cf-805ef3f7e5ed
Z.U[:]

# ╔═╡ 0139b2ff-e356-476f-8a3c-bc0c7b14d000
md"""
## Functionality
This normalization process provides the user with greater analytical power by offering broader applicability, scale consistency, and numerical stability when dealing with multitudes of data.

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
GCPDecompositions = "f59fb95b-1bc8-443b-b347-5e445a549f37"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
TensorCore = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"

[compat]
GCPDecompositions = "~0.2.0"
TensorCore = "~0.1.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "381c7e8281541c100f3d9fda3009ed6dedeb3d97"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

    [deps.ForwardDiff.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.GCPDecompositions]]
deps = ["Compat", "ForwardDiff", "IntervalSets", "LBFGSB", "LinearAlgebra", "Random"]
git-tree-sha1 = "c29269f9bd5f2617e517fa26fc1ea5f314efa486"
uuid = "f59fb95b-1bc8-443b-b347-5e445a549f37"
version = "0.2.0"

    [deps.GCPDecompositions.extensions]
    LossFunctionsExt = "LossFunctions"

    [deps.GCPDecompositions.weakdeps]
    LossFunctions = "30fc2ffe-d236-52d8-8643-a9d8f7c094a7"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

    [deps.IntervalSets.weakdeps]
    Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.LBFGSB]]
deps = ["L_BFGS_B_jll"]
git-tree-sha1 = "e2e6f53ee20605d0ea2be473480b7480bd5091b5"
uuid = "5be7bae1-8223-5378-bac3-9e7378a2f6e6"
version = "0.4.1"

[[deps.L_BFGS_B_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "77feda930ed3f04b2b0fbb5bea89e69d3677c6b0"
uuid = "81d17ec3-03a1-5e46-b53e-bddc35a13473"
version = "3.0.1+0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

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
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─1e373ec0-5501-11ef-3950-53bb96fe651e
# ╟─f5764676-1dc5-4dda-a6ee-d80d2b6e9293
# ╠═5a894fc9-8780-4037-9502-38507da2a768
# ╟─48da1f48-e471-4248-95bd-17f3433feafc
# ╠═f1a34cec-4618-4a2a-8ccd-890987ee25ea
# ╟─6f494c27-6380-4b30-bcf5-79c4fa02aaae
# ╟─6f5509a7-031f-4ea5-880c-43abb4a85a8e
# ╠═7da986f3-f336-4ecf-a0e8-d51366fc6f89
# ╠═e912cb2d-8d17-4e5e-a361-6725f484e84f
# ╠═781ffdfe-57b8-49a1-ab86-4951f33efe21
# ╠═9a8fee1d-f83d-4019-a424-9f5e5100c2ab
# ╠═a7775946-6532-4c1d-aad2-2f43fdabe5e2
# ╠═87fa49b9-72a1-4fc0-b8f1-317d7e60bd0c
# ╟─89bef267-6677-4e4f-8a87-b48b15d86126
# ╟─3c00f0a7-018b-46e5-b83f-f25c5a113d70
# ╠═d364a4dd-eb80-4a93-a2e2-ae5352e812f0
# ╠═14e92a0d-5e2d-4648-bfc0-d1729057a86b
# ╠═4e3c9458-bf9f-4bba-a95b-b2fc2d934852
# ╠═73c2e516-2e6e-4f89-98b0-bc2f5c8652c3
# ╠═213f277c-ec58-44a2-af67-0441cbdc4f49
# ╠═0676449b-55bf-467d-aad3-f094776ef5e4
# ╠═4e5fffb0-7a7f-4207-923a-48e3695fd5ee
# ╟─e836904d-6351-4cc1-a6d0-2228520a7ab6
# ╠═6a2f5246-4d32-4f46-b3c9-f189461be725
# ╠═d6094fdb-7828-46eb-b798-49228e62d39b
# ╠═2795a6b9-76eb-44d6-8fee-85f67c0f660d
# ╠═033e8a5d-6272-477a-b37c-444440e767d3
# ╠═8827553e-c189-42ca-b4a1-3d634338ef6a
# ╠═6c9eb704-a0d2-4caf-a8cf-805ef3f7e5ed
# ╟─0139b2ff-e356-476f-8a3c-bc0c7b14d000
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
