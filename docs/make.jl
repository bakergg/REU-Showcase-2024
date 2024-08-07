push!(LOAD_PATH,"../src/")
using Documenter
makedocs(
         sitename = "GCP Decompositions Software Contributions",
         
         pages=[
                "Home" => "index.md"
               ])
deploydocs(;
    repo="https://github.com/bakergg/REU-Showcase-2024.git",
)