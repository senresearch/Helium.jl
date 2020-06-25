"""
**`Helium.csv2he`** -*Function*.

    `Helium.csv2he(source, outputFile, DataType; hasColNames::Bool=true,
                   hasRowNames::Bool=false, strMiss::String = "na")` => `file`

Convert a CSV file that contains a matrix into the Helium binary file format.
The function first evaluate the size of the matrix, then read the data and save
it in Helium format. If no output path is provided then a Helium file will be
created with the same CSV file name.
If there are not column names, set `isHeader = false`. If
there are row names, set `isRowNames = true`.

"""
function csv2he(csvFile::String, heFile::String, matType::DataType;
                hasColNames::Bool=true, hasRowNames::Bool=false,
                strMiss::String="na", skipCol::Int64 =0)

    # HeInfo constructor
    he = HeInfo(abspath(csvFile), matType, 1, 1,
                hasColNames, hasRowNames,
                strMiss, skipCol)

    # Convert CSV to matrix
    mat, cNames, rNames, supp = csv2mat(he)

    writehe(mat, heFile, colNames = cNames, rowNames = rNames, supplement = supp)

end


"""
**`Helium.csv2he`** -*Function*.

    `Helium.csv2he(source, DataType; hasColNames::Bool=true,
                   hasRowNames::Bool=false, strMiss::String = "na")` => `file`

Convert a CSV file that contains a matrix into the Helium binary file format.
The function first evaluate the size of the matrix, then read the data and save
it in Helium format. If no output path is provided then a Helium file will be
created with the same CSV file name.
If there are not column names, set `hasColNames = false`. If
there are row names, set `hasRowNames = true`.

"""
function csv2he(csvFile::String, matType::DataType;
                hasColNames::Bool=true, hasRowNames::Bool=false,
                strMiss::String = "na", skipCol::Int64 =0)

    heFile = string(csvFile[1:end-3], "he")

    csv2he(csvFile, heFile, matType,
                    hasColNames = hasColNames, hasRowNames = hasRowNames,
                    strMiss = strMiss, skipCol = skipCol)

    println("Location of the Helium file:")
    println(realpath(heFile))
end

"""
**`Helium.csv2mat`** -*Function*.

    `Helium.csv2mat(HeAttributes)` => `matrix, column names, row names`

Extract data matrix, column and row names from a CSV file.
The function first evaluate the size of the matrix, then read the data.
If there are not column names, set `hasColNames = false`. If
there are row names, set `hasRowNames = true`.

"""
function csv2mat(he::HeAttributes)

    # Get the number of columns
    frstRow = readline(he.fileName)
    he.numCols = length(split(frstRow, ","))

    # Get the number of rows
    global nRows = 0
    open(he.fileName) do io
        while !eof(io)
            readline(io)
            nRows += 1
        end
    end
    he.numRows = nRows

    # Get matrix
    mat, colNames, rowNames, matXtra = Dict(true=>getmat,
                                            false=>getskipmat)[he.skipCol == 0](he)
    return mat, colNames, rowNames, matXtra

end
