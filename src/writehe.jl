"""

**`Helium.writehe`** -*Function*.

    `Helium.writehe(matrix, source;
                    colNames::Array{String,1} = [""],
                    rowNames::Array{String,1} = [""],
                    supplement::Array{String,2} = ["" ""])` => `file`

Write a matrix (2D array) to a binary .he file, given as an IO argument or
String/FilePaths.jl type representing the file name to write. The binary files
Helium format includes a header that describes the size and the data type of
the matrix, as well as the endianness of the file.
The first 56 bytes contains:
[number of rows, number of columns, data type, endianness,
 if column names exists, if row names exists, number of column of supplement]

"""
function writehe(mat, heFile::String;
                 colNames::Array{String,1} = [""],
                 rowNames::Array{String,1} = [""],
                 supplement::Array{String,2} = ["" ""])

    # Check name ending by .he
    if heFile[end-2:end] != ".he"
       heFile = string(heFile, ".he")
    end

    # Check path
    try
      realpath(heFile[1:end-length(basename(heFile))])
    catch e
      error("Path incorrect, check directory!!!")
    end

    # Check if dimension of mat greater than 2
    if (length(size(mat)) > 2)
      matSize = size(mat)
      lenSize = length(matSize)
      # Create an arbitrary name for the vectorized matrix
      # Name includes information about dimensions
      colNames  = chop(join(string.([matSize[dim] for dim in 1:lenSize], "_")))
      colNames  = [join(["@nD-matrix!", colNames], "_")] 

      # Vectorize
      mat = reshape(mat, length(mat), 1)
    end



    # Check for row and column names
    hascolnames = colNames[1] != ""
    hasrownames = rowNames[1] != ""
    hassupplement = supplement != ["" ""]

    if hassupplement
      numcolsupp = size(supplement)[2]
    else
      numcolsupp = 0
    end

    # Create a dictionary to map size, data type and endianness in integer
    dictCtrl =  Dict("Float64"=>Int64(0xf64),
                     "Int64"=>Int64(0xe64),
                     "Float32"=>Int64(0xf32),
                     "Int32"=>Int64(0xe32),
                     "Bool"=>Int64(0xb00),
                     "Little-endian"=>Int64(0x04030201),
                     "Big-endian"=>Int64(0x01020304));

    dataType = string(typeof(mat[1]))

    # Check endianness
    if ENDIAN_BOM == 0x04030201
        endianness = "Little-endian"
    else
        endianness = "Big-endian"
    end

    # Create the header of the binary file
    matCtrl = [size(mat)[1]; size(mat)[2];
               dictCtrl[dataType]; dictCtrl[endianness];
               hascolnames;hasrownames; numcolsupp]
    matCtrl = convert(Array{Int64}, matCtrl)

    # Write HEADER
    open(heFile, "w") do file
             write(file, matCtrl)
    end

    # Write DATA
    open(heFile, "a") do file
             write(file, mat)
    end

    # Write COL NAMES
    if hascolnames
       open(heFile, "a") do file
                write(file, string(join(colNames, ","),"\n" ))
       end
    end

    # Write ROW NAMES
    if hasrownames
       open(heFile, "a") do file
                write(file, string(join(rowNames, ","),"\n" ))
       end
    end

    # Write SUPPLEMENT
    if hassupplement

       global i = 1

       open(heFile, "a") do file
          while i <= size(supplement)[2]
                 write(file, string(join(supplement[:,i], ","),"\n" ))
                 global i += 1
          end
       end
    end

end
