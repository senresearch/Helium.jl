"""
**`Helium.csv2hedir`** -*Function*.

    `Helium.csv2hedir(source, DataType; hasColNames::Bool=true,
                   hasRowNames::Bool=false, strMiss::String = "na")` => `file`

Convert a CSV file that contains a matrix into the Helium binary file format.
The function first evaluate the size of the matrix, then read the data and save
it in Helium directory style format.
If there are not column names, set `hasColNames = false`. If
there are row names, set `hasRowNames = true`.


"""

function csv2hedir(csvFile::String, heFile::String, matType::DataType;
                hasColNames::Bool=true, hasRowNames::Bool=false,
                strMiss::String = "na", sep=",", skipCol::Int64 =0)

    # HeInfo constructor
    he = HeInfo(abspath(csvFile), matType, 1, 1,
                hasColNames, hasRowNames,
                strMiss, sep, skipCol)

    # Convert CSV to matrix
    mat, cNames, rNames, supp = csv2mat(he)

    writehedir(mat, heFile)

    # Write COL NAMES
    if hasColNames
        csvColNames = string(heFile, "/", basename(heFile)[1:end-3], "_colnames.csv")
        open(csvColNames, "w") do io
            writedlm(io, cNames, ',')
        end
    end

    # Write ROW NAMES
    if hasRowNames
        csvRowNames = string(heFile, "/", basename(heFile)[1:end-3], "_rownames.csv")
        open(csvRowNames, "w") do io
            writedlm(io, rNames, ',')
        end
    end

    # Write SUPPLEMENT
    if skipCol != 0
        csvSupp = string(heFile, "/", basename(heFile)[1:end-3], "_supplement.csv")
        open(csvSupp, "w") do io
            writedlm(io, supp, ',')
        end
    end

end

"""
**`Helium.csv2hedir`** -*Function*.

    `Helium.csv2hedir(source, DataType; hasColNames::Bool=true,
                   hasRowNames::Bool=false, strMiss::String = "na")` => `file`

Convert a CSV file that contains a matrix into the Helium binary file format.
The function first evaluate the size of the matrix, then read the data and save
it in Helium directory style format.
If there are not column names, set `hasColNames = false`. If
there are row names, set `hasRowNames = true`.


"""

function csv2hedir(csvFile::String, matType::DataType;
                hasColNames::Bool=true, hasRowNames::Bool=false,
                strMiss::String = "na", sep=",", skipCol::Int64 =0)

    heFile = string(csvFile[1:end-3], "he")

    csv2hedir(csvFile, heFile, matType,
           hasColNames = hasColNames, hasRowNames = hasRowNames,
           strMiss = strMiss, skipCol = skipCol)

    println("Location of the Helium directory:")
    println(realpath(heFile))
end
