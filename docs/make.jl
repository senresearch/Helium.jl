# Inside make.jl
push!(LOAD_PATH,"../src/")
using Helium
using Documenter

const src = "https://github.com/senresearch/Helium.jl"
const dst = "https://senresearch.github.io/Helium.jl/stable"

makedocs(
         sitename = "Helium.jl",
         authors = "Gregory Farage",
         modules  = [Helium],
         pages=[
                "Home" => "index.md",
                "Function Documentation" => "functionDoc.md"
               ])
deploydocs(;
    repo="github.com/senresearch/Helium.jl",
    devurl="stable",
)
