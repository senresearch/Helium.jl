"""
**`Helium.getmat`** -*Function*.

    `Helium.getmat(source, DataType, numRows::Int64, numCols::Int64,
    isHeader::Bool, isRowNames::BoolnumRows)` => `matrix, column names, row names`

Read the data matrix and extract column and row names if they exist.

"""
function getmat(he::HeAttributes)

    # Adjust number of columns and rows according to skip option and if there
    # exist column and/or row names.

    #######################
    # Indices adjustement #
    #######################

    if he.hasColNames
        he.numRows -= 1
    end

    if he.hasRowNames
        he.numCols -= 1
    end


    ##################
    # Pre-allocation #
    ##################

    mat = Array{he.matType}(undef, he.numRows, he.numCols)
    if he.hasRowNames
        rowNames = Array{String}(undef, he.numRows, 1)
    else
        rowNames = [""]
    end

    ######################
    # Fill-up the matrix #
    ######################

    global i = 0
    open(he.fileName) do io

        if he.hasColNames
            global colNames = split(readline(io), he.sep)
        else
            global colNames = [""]
        end
        
        if he.hasRowNames
            while !eof(io)
                tmp = [readline(io)]
                newLine = eval(Meta.parse(string("""rslt=split(replace($tmp[1], r"$(he.strMiss)|NA|MISSING"i => "NaN"), "$(he.sep)")""")))
                global i += 1
                global rowNames[i] = newLine[1]
                global mat[i, :] = parse.(he.matType, newLine[2:end])
            end
            if he.hasColNames
                colNames = colNames[2:end]
            end
        else
            while !eof(io)
                tmp = [readline(io)]
                newLine = eval(Meta.parse(string("""rslt=split(replace($tmp[1], r"$(he.strMiss)|NA|MISSING"i => "NaN"), "$(he.sep)")""")))
                global i += 1
                global mat[i, :] = parse.(he.matType, newLine[1:end])
            end
        end
    end

    return mat, string.(colNames)[:], string.(rowNames)[:], ["" ""]
end






"""
**`Helium.getskipmat`** -*Function*.

    `Helium.getskipmat(source, DataType, numRows::Int64, numCols::Int64,
    isHeader::Bool, isRowNames::BoolnumRows)` => `matrix, column names, row names`

Read the data matrix and extract column and row names if they exist.

"""
function getskipmat(he::HeAttributes)

    # Adjust number of columns and rows according to skip option and if there
    # exist column and/or row names.

    #######################
    # Indices adjustement #
    #######################

    if he.hasColNames
        he.numRows -= 1
    end

    if he.hasRowNames
        he.numCols -= 1 + he.skipCol
        global idxStartMat = 2 + he.skipCol
        global idxEndXtra = idxStartMat - 1
    else
        he.numCols -= he.skipCol
        global idxStartMat = 1 + he.skipCol
        global idxEndXtra = idxStartMat - 1
    end

    ##################
    # Pre-allocation #
    ##################

    mat = Array{he.matType}(undef, he.numRows, he.numCols)

    if he.hasRowNames
        rowNames = Array{String}(undef, he.numRows, 1)
    else
        rowNames = [""]
    end

    global matXtra = Array{String}(undef, he.numRows+he.hasColNames, he.skipCol)

    ######################
    # Fill-up the matrix #
    ######################

    global i = 0
    open(he.fileName) do io

        if he.hasColNames
            global colNames = string.(split(readline(io), he.sep)[:])
            global matXtra[1, :] = colNames[(1+he.hasRowNames):idxEndXtra]
            colNames = colNames[idxStartMat:end]
        else
            global colNames = [""]
        end

        if he.hasRowNames
            while !eof(io)
                global i += 1

                tmp = [readline(io)]
                tmp = split(tmp[1], he.sep)

                global rowNames[i] = tmp[1]

                global matXtra[i+he.hasColNames, :] = tmp[2:idxEndXtra]

                newLine = eval(Meta.parse(string("""replace.($tmp[$idxStartMat:end], r"$(he.strMiss)|NA|MISSING"i => "NaN")""")))
                global mat[i, :] = parse.(he.matType, newLine)
            end
        else
            while !eof(io)
                global i += 1

                tmp = [readline(io)]
                tmp = split(tmp[1], he.sep)

                global matXtra[i+he.hasColNames, :] = tmp[1:idxEndXtra]

                newLine = eval(Meta.parse(string("""replace.($tmp[idxStartMat:end], r"$(he.strMiss)|NA|MISSING"i => "NaN")""")))
                global mat[i, :] = parse.(he.matType, newLine)
            end
        end


    end



    return mat, colNames, string.(rowNames)[:], matXtra
end
