"""
**`Helium.readhe`** -*Function*.

    `Helium.readhe(source)` => `Matrix`

Parse a binary file into a matrix. The binary files .he format includes a
header that describes the size and the data type of the matrix, as well as the
endianness of the file.
The first 56 bytes contains:
[number of rows, number of columns, data type, endianness,
 if column names exists, if row names exists, number of column of supplement]


"""
function readhe(heFile::String)
        # Get data properties
        matInfo = readheader(heFile)

        # Pre-allocate matrix
        mat = Array{matInfo.datatype}(undef, matInfo.numrows, matInfo.numcols);

        open(heFile) do file
            seek(file, 56);
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
**`Helium.getcolnames`** -*Function*.

    `Helium.getcolnames(source)` => `Array{String, 1}`

Return an array of string containing the column names associated to the data.

"""
function getcolnames(heFile::String)
        # Get data properties
        matInfo = readheader(heFile)

        if matInfo.hascolnames
                # Read COL NAMES
                global cNames =  Array{String,1}[]
                open(heFile, "r") do file
                        seek(file, (7 + matInfo.numrows*matInfo.numcols)*matInfo.bytesize)
                        cNames  = readline(file)
                end
                cNames = string.(split(cNames, ","));

                return cNames
        else
                error("No column names in the file!!!")
        end
end


"""
**`Helium.getrownames`** -*Function*.

    `Helium.getrownames(source)` => `Array{String, 1}`

Return an array of string containing the row names associated with the data.

"""
function getrownames(heFile::String)
        # Get data properties
        matInfo = readheader(heFile)

        if matInfo.hasrownames
                # Read ROW NAMES
                global rNames =  Array{String,1}[]
                open(heFile, "r") do file
                        seek(file, (7 + matInfo.numrows*matInfo.numcols)*matInfo.bytesize)
                        if matInfo.hascolnames
                                rNames= readline(file)
                        end
                        rNames  = readline(file)
                end
                rNames = string.(split(rNames, ","));

                return rNames
        else
                error("No row names in the file!!!")
        end
end

"""
**`Helium.getsupp`** -*Function*.

    `Helium.getsupp(source)` => `Array{String, 2}`

Return an array of string containing the supplement data associated with the
matrix data.

"""
function getsupp(heFile::String)
        # Get data properties
        matInfo = readheader(heFile)

        if matInfo.numcolsupp != 0
                # Read ROW NAMES
                global supp =  Array{String}(undef, matInfo.numrows+matInfo.hascolnames, matInfo.numcolsupp)
                global i = 1
                open(heFile, "r") do file
                        seek(file, (7 + matInfo.numrows*matInfo.numcols)*matInfo.bytesize)

                        if matInfo.hascolnames
                                tmp = readline(file)
                        end

                        if matInfo.hasrownames
                                tmp = readline(file)
                        end

                        while !eof(file)
                                tmp = readline(file)
                                supp[:, i] = string.(split(tmp, ","));
                                i += 1
                        end
                end

                supp #return supp
        else
                error("No supplement in the file!!!")
        end
end

"""
**`Helium.readheader`** -*Function*.

    `Helium.readheader(source)` => `NamedTuple{(:numrows, :numcols,
                                                :datatype, :endianness,
                                                 :hascolnames, :hasrownames,
                                                 :bytesize),
                                                 Tuple{Int64,Int64,
                                                       DataType,String,
                                                       Bool,Bool,
                                                       Int64}}`

Return a tuple containing respectively number of rows, number of columns,
data type, endianness, if there is column names , and if if there is row
names.

"""
function readheader(heFile::String)

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

        dictDataSize =  Dict("f64"=>8,
                        "e64"=>8,
                        "f32"=>4,
                        "e32"=>4,
                        "b00"=>1);


        # Read control information
        matCtrl = Array{Int64}(undef, 1 ,7);
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
                endianness = dictCtrl[string(matCtrl[4], base = 16)],
                hascolnames = Bool(matCtrl[5]), hasrownames = Bool(matCtrl[6]),
                numcolsupp = matCtrl[7],
                bytesize = dictDataSize[string(matCtrl[3], base = 16)])

end
