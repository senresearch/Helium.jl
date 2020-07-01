"""
**`Helium.he2csv`** -*Function*.

    `Helium.he2csv(source, outputFile, DataType;
                   strMiss::String = "NaN", nameColRows::String="ID")` => `file`

Convert a Helium binary file into a CSV format.
The function gather all information from the helium file to generate a CSV file.
It is possible to map the `NaN` elements of the matrx into a new string,
 `strMiss`. By default, if the column and row names exist, the name of the
 sample column is called "ID".

"""
function he2csv(heFile::String, csvFile::String;
                strMiss::String="NaN", nameColRows::String="ID")

    # Get header helium dimension
    hdrHe = Helium.readheader(heFile)
    nrows = hdrHe.numrows + hdrHe.hascolnames
    ncols = hdrHe.numcols + hdrHe.hasrownames + hdrHe.numcolsupp

    csvTab = Array{String}(undef, nrows, ncols)

    # Check row names
    if hdrHe.hasrownames
           if hdrHe.hascolnames
                   csvTab[1,1] = nameColRows
           end
           csvTab[1+hdrHe.hascolnames:end,1] = Helium.getrownames(heFile)
    end

    # Check column names
    if hdrHe.hascolnames
            csvTab[1, 1+hdrHe.hasrownames+hdrHe.numcolsupp:end] = Helium.getcolnames(heFile)
    end

    # Check supplemental data
    if hdrHe.numcolsupp != 0
            csvTab[:, (1+hdrHe.hasrownames):(hdrHe.hasrownames+hdrHe.numcolsupp)] = Helium.getsupp(heFile)
    end

    # Get data matrix
    csvTab[hdrHe.hascolnames+1:end, 1+hdrHe.hasrownames+hdrHe.numcolsupp:end] = string.(Helium.readhe(heFile))

    if strMiss != "NaN"
            idxR = hdrHe.hascolnames+1
            idxC = 1 + hdrHe.hasrownames + hdrHe.numcolsupp
            csvTab[idxR:end, idxC:end] = eval(Meta.parse(string("""replace.($csvTab[$idxR:end, $idxC:end], r"NaN"i => "$(strMiss)")""")))
    end

    # Helium to CSV
    open(csvFile, "w") do io
             writedlm(io, csvTab, ',')
    end

end
