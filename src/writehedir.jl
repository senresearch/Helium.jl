"""
**`Helium.writehe`** -*Function*.

    `Helium.writehe( matrix, source)` => `file`

Write a matrix (2D array) to a binary .he file, given as an IO argument or
String/FilePaths.jl type representing the file name to write. The binary files
Helium format includes a header that describes the size and the data type of
the matrix, as well as the endianness of the file.
The first 32 bytes contains:
[number of rows, number of columns, data type, endianness]

"""

function writehedir(mat, heFile::String)

    # Check name ending by .he
    if heFile[end-2:end] != ".he"
       heFile = string(heFile, ".he")
    end

    # Create helium format directory
    if !isdir(heFile)
       mkdir(heFile)
    end
    heFile = string(heFile, "/", basename(heFile)[1:end-3], ".dat")

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
    matCtrl = [size(mat)[1] size(mat)[2] dictCtrl[dataType] dictCtrl[endianness]]
    matCtrl = convert(Array{Int64}, matCtrl)

    # Write header
    open(heFile, "w") do file
             write(file, matCtrl)
    end
    # Write data
    open(heFile, "a") do file
             write(file, mat)
    end

    fileInfo = string(dirname(heFile), "/README.txt")
    info = string("Rows: ", matCtrl[1], "\n",
                  "Columns: ", matCtrl[2], "\n",
                  "Type: ", dataType, "\n",
                  "Endianness :", endianness, "\n")
    open(fileInfo, "w") do io
        write(io, info)
    end


end
