"""
**`Helium.csv2he`** -*Function*.

    `Helium.csv2he(source, DataType; isHeader::Bool=true, isRowNames::Bool=false)` => `file`

Convert a CSV file that conatains a matrix into the Helium binary file format.
The function first evaluate the siaze of the matrix, then read the data and save
it in Helium format. If there are not column names, set `isHeader = false`. If
there are row names, set `isRowNames = true`.

"""

function csv2he(csvFile::String, matType::DataType;
                isHeader::Bool=true, isRowNames::Bool=false)
    # Get the number of columns
    frstRow = readline(csvFile)
    numCols = length(split(frstRow, ","))

    # Get the number of rows
    global numRows = 0
    open(csvFile) do io
        while !eof(io)
            readline(io)
            numRows += 1
        end
    end

    # Get matrix
    mat, hdr, rowNames = getmat(csvFile, matType,
                                numRows, numCols,
                                isHeader, isRowNames)

    heFile = string(csvFile[1:end-3], "he")
    writehe(heFile, mat)

    if isHeader
        csvColNames = string(heFile, "/", basename(heFile)[1:end-3], "_colnames.csv")
        open(csvColNames, "w") do io
            writedlm(io, hdr, ',')
        end
    end

    if isRowNames
        csvRowNames = string(heFile, "/", basename(heFile)[1:end-3], "_rownames.csv")
        open(csvRowNames, "w") do io
            writedlm(io, rowNames, ',')
        end
    end
    println("Location of the Helium directory:")
    println(realpath(heFile))
end


"""
**`Helium.getmat`** -*Function*.

    `Helium.getmat(source, DataType, numRows::Int64, numCols::Int64,
    isHeader::Bool, isRowNames::BoolnumRows)` => `matrix, column names, row names`

Read the data matrix and extract column and row names if they exist.

"""
function getmat(csvFile::String, matType::DataType,
                numRows::Int64, numCols::Int64,
                isHeader::Bool, isRowNames::Bool)

    if isHeader
        numRows -= 1
    end

    if isRowNames
        numCols -= 1
    end

    # Pre-allocation
    mat = Array{matType}(undef, numRows, numCols)
    if isRowNames
        rowNames = Array{String}(undef, numRows, 1)
    else
        rowNames = nothing
    end

    # Fill the matrix
    global i = 0
    open(csvFile) do io

        if isHeader
            global hdr = split(readline(io), ",")
        else
            global hdr = nothing
        end

        if !isRowNames
            while !eof(io)
                myLine = split(replace(readline(io), r"x|NA|MISSING"i => "NaN"), ",")
                global i += 1
                global mat[i, :] = parse.(matType, myLine)
            end
        else
            while !eof(io)
                myLine = split(replace(readline(io), r"x|NA|MISSING"i => "NaN"), ",")
                global i += 1
                global rowNames[i] = myLine[1]
                myLine = myLine[2:end]
                global mat[i, :] = parse.(matType, myLine)
            end
            hdr = hdr[2:end]
        end

    end

    return mat, hdr, rowNames
end
