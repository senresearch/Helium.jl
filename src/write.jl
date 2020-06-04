"""
This module provides a function to convert a CSV file containning a matrix of data
into Helium binary file format

    Helium.csv2he(file) => file

"""

function writehe(heFile::String, mat)
    # Create a dictionnary to map size, data type and endianness in integer
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
    matCtrl = convert(Array{Float64}, matCtrl)

    # Write header
    open(heFile, "w") do file
             write(file, matCtrl)
    end
    # Write data
    open(heFile, "a") do file
             write(file, mat)
    end

end
