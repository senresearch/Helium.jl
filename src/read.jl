"""
**`Helium.readhe`** -*Function*.

    `Helium.readhe(source)` => `Matrix`

Parse a binary file into a matrix. The binary files .he format includes a
header that describes the size and the data type of the matrix, as well as the
endianness of the file.
The first 32 bytes contains:
[number of rows, number of columns, data type, endianness]


"""

function readhe(heFile::String)

        heFile = string(heFile, "/", basename(heFile))

        # Generate dictionnary for reading type and endianness
        dictCtrl =  Dict("f64"=>Float64,
                    "e64"=>Int64,
                    "f32"=>Float32,
                    "e32"=>Int32,
                    "b00"=>Bool,
                    "4030201"=>"Little-endian",
                    "1020304"=>"Big-endian");

        # Read control information
        matCtrl = Array{Float64}(undef, 1 ,4);
        open(heFile) do file
                read!(file, matCtrl)
        end

        matCtrl = convert(Array{Int64}, matCtrl)

        # Get the DataType and endianness
        dataType = dictCtrl[string(matCtrl[3], base = 16)]
        endianness = dictCtrl[string(matCtrl[4], base = 16)]

        # Pre-allocate matrix
        mat = Array{dataType}(undef, matCtrl[1], matCtrl[2]);

        open(heFile) do file
            seek(file, 32);
            read!(file, mat)
        end

        return mat
end


"""
**`Helium.getcolnames`** -*Function*.

    `Helium.getcolnames(source)` => `Array{String, 2}`

Return an array of string containing the column names of the original CSV files.

"""
function getcolnames(heFile::String)

        fileName =realpath(string(heFile, "/", basename(heFile)[1:end-3], "_colnames.csv"))

        if isfile(fileName)
            open(fileName, "r") do io
               global colNames = readdlm(io,',', String)
            end
        else
            println("Column names file does not exist!!!!")
        end

        return colNames[:,1]
end


"""
**`Helium.getrownames`** -*Function*.

    `Helium.getrownames(source)` => `Array{String, 2}`

Return an array of string containing the row names of the original CSV files.

"""
function getrownames(heFile::String)

        fileName =realpath(string(heFile, "/", basename(heFile)[1:end-3], "_rownames.csv"))

        if isfile(fileName)
            open(fileName, "r") do io
               global rowNames = readdlm(io,',', String)
            end
        else
            println("Row names file does not exist!!!!")
        end

        return rowNames[:,1]
end
