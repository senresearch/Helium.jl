"""
**`Helium.readhedir`** -*Function*.

    `Helium.readhedir(source)` => `Matrix`

Parse a binary file into a matrix. The binary files .he format includes a
header that describes the size and the data type of the matrix, as well as the
endianness of the file.
The first 32 bytes contains:
[number of rows, number of columns, data type, endianness]


"""
function readhedir(heFile::String)

        heFile = abspath(string(heFile, "/",  basename(heFile)[1:end-3], ".dat"))

        # Get data properties
        matInfo = readheaderdir(heFile)

        # Pre-allocate matrix
        mat = Array{matInfo.datatype}(undef, matInfo.numrows, matInfo.numcols);

        open(heFile) do file
            seek(file, 32);
            read!(file, mat)
        end

        # Check endianness
        dictEndian = Dict("Little-endian"=>ntoh,
                          "Big-endian"=>ltoh,
                          "4030201"=>"Little-endian",
                          "1020304"=>"Big-endian");
        hostendian =  dictEndian[string(ENDIAN_BOM, base = 16)]

        if hostendian != matInfo.endianness
                mat .= dictEndian[hostendian].(mat)
        end

        return mat
end


"""
**`Helium.getcolnamesdir`** -*Function*.

    `Helium.getcolnamesdir(source)` => `Array{String, 2}`

Return an array of string containing the column names of the original CSV files.

"""
function getcolnamesdir(heFile::String)

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
**`Helium.getrownamesdir`** -*Function*.

    `Helium.getrownamesdir(source)` => `Array{String, 2}`

Return an array of string containing the row names of the original CSV files.

"""
function getrownamesdir(heFile::String)

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
"""
**`Helium.getrownamesdir`** -*Function*.

    `Helium.getrownamesdir(source)` => `Array{String, 2}`

Return an array of string containing the row names of the original CSV files.

"""
function getsuppdir(heFile::String)

        fileName =realpath(string(heFile, "/", basename(heFile)[1:end-3], "_supplement.csv"))

        if isfile(fileName)
            open(fileName, "r") do io
               global supp = readdlm(io,',', String)
            end
        else
            println("Row names file does not exist!!!!")
        end

        return supp
end

"""
**`Helium.readheaderdir`** -*Function*.

    `Helium.readheaderdir(source)` => `NamedTuple{(:numrows, :numcols,
                                                   :datatype, :endianness),
                                                 Tuple{Int64,Int64,
                                                       DataType,String}}`

Return a tuple containing respectively number of rows, number of columns,
data type, endianness.

"""
function readheaderdir(heFile::String)

        try
           realpath(abspath(heFile))
        catch e
           error("File name or path incorrect!!!")
        end

        heFile =  realpath(abspath(heFile))

        # Generate dictionary for reading type and endianness
        dictCtrl =  Dict("f64"=>Float64,
                    "e64"=>Int64,
                    "f32"=>Float32,
                    "e32"=>Int32,
                    "b00"=>Bool,
                    "4030201"=>"Little-endian",
                    "1020304"=>"Big-endian");

        # Read control information
        matCtrl = Array{Int64}(undef, 1 ,4);
        open(heFile) do file
                read!(file, matCtrl)
        end

        # Check endianness
        dictEndian = Dict("Little-endian"=>ntoh,
                          "Big-endian"=>ltoh);

        if ENDIAN_BOM != matCtrl[4]
                hostendian =  dictCtrl[string(ENDIAN_BOM, base = 16)]
                matCtrl .= dictEndian[hostendian].(matCtrl)
        end

        return (numrows = matCtrl[1], numcols = matCtrl[2],
                datatype = dictCtrl[string(matCtrl[3], base = 16)],
                endianness = dictCtrl[string(matCtrl[4], base = 16)])

end
