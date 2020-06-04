"""
This module provides a function to convert a CSV file containning a matrix of data
into Helium binary file format

    Helium.csv2he(file) => file

"""

function csv2he(csvFile::String, matType::DataType)
    # Get the number of columns
    frstRow = readline(csvFile)
    numCol = length(split(frstRow, ","))

    # Get the number of rows
    global numRow = 0
    open(csvFile) do io
               while !eof(io)
                   readline(io)
                   numRow += 1
               end
    end

    # Pre-allocation
    mat = Array{matType}(undef, numRow, numCol);

    # Fill the matrix
    global i = 0
    open(csvFile) do io
        while !eof(io)
           myLine = (split(readline(io), ","))
           i += 1
           global mat[i, :] = parse.(matType, myLine)
        end
    end

    writehe(string(csvFile[1:end-3], "he"), mat)

end
