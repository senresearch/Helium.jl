"""
Main module for `Helium.jl` -- a binary format writer and reader for matrix.
Three functions are exported from this module for public use:
- [`csv2he`](@ref). Convert a CSV file containing a matrix to the binary Helium format.
- [`writehe`](@ref). Write matrix in Helium format.
- [`readhe`](@ref). Read file in Helium format.

"""



module Helium

using DelimitedFiles


include("he.jl")
export HeAttributes
export HeInfo

include("writehe.jl")
export writehe

include("readhe.jl")
export readhe, getcolnames, getrownames, getsupp, readheader

include("csv2helium.jl")
export csv2he, csv2mat

include("xtract.jl")
export getskipmat, getmat

include("helium2csv.jl")
export he2csv


end # module
