# Inside make.jl
push!(LOAD_PATH,"../src/")
using Helium
using Documenter
makedocs(
         sitename = "Helium.jl",
         modules  = [Helium],
         pages=[
                "Home" => "index.md"
               ])
deploydocs(;
    repo="github.com/senresearch/Helium.jl",
)
