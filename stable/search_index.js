var documenterSearchIndex = {"docs":
[{"location":"functionDoc/#Functions","page":"Types and Functions","title":"Functions","text":"","category":"section"},{"location":"functionDoc/","page":"Types and Functions","title":"Types and Functions","text":"","category":"page"},{"location":"functionDoc/","page":"Types and Functions","title":"Types and Functions","text":"Modules = [Helium]","category":"page"},{"location":"functionDoc/#Helium.HeInfo","page":"Types and Functions","title":"Helium.HeInfo","text":"He is a mutable composite type that is describe the attributes of the data contained in the Helium format file..\n\n\n\n\n\n","category":"type"},{"location":"functionDoc/#Helium.csv2he-Tuple{String,DataType}","page":"Types and Functions","title":"Helium.csv2he","text":"Helium.csv2he -Function.\n\n`Helium.csv2he(source, DataType; hasColNames::Bool=true,\n               hasRowNames::Bool=false, strMiss::String = \"na\",\n               sep::String =\",\", skipCol::Int64=0)` => `file`\n\nConvert a CSV file that contains a matrix into the Helium binary file format. The function first evaluate the size of the matrix, then read the data and save it in Helium format. If no output path is provided then a Helium file will be created with the same CSV file name. If there are not column names, set hasColNames = false. If there are row names, set hasRowNames = true.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.csv2he-Tuple{String,String,DataType}","page":"Types and Functions","title":"Helium.csv2he","text":"Helium.csv2he -Function.\n\n`Helium.csv2he(source, outputFile, DataType; hasColNames::Bool=true,\n               hasRowNames::Bool=false, strMiss::String=\"na\",\n               sep::String =\",\", skipCol::Int64=0)` => `file`\n\nConvert a CSV file that contains a matrix into the Helium binary file format. The function first evaluate the size of the matrix, then read the data and save it in Helium format. If no output path is provided then a Helium file will be created with the same CSV file name. If there are not column names, set hasColNames = false. If there are row names, set hasRowNames = true.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.csv2mat-Tuple{HeAttributes}","page":"Types and Functions","title":"Helium.csv2mat","text":"Helium.csv2mat -Function.\n\n`Helium.csv2mat(HeAttributes)` => `matrix, column names, row names`\n\nExtract data matrix, column and row names from a CSV file. The function first evaluate the size of the matrix, then read the data. If there are not column names, set hasColNames = false. If there are row names, set hasRowNames = true.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.getcolnames-Tuple{String}","page":"Types and Functions","title":"Helium.getcolnames","text":"Helium.getcolnames -Function.\n\n`Helium.getcolnames(source)` => `Array{String, 1}`\n\nReturn an array of string containing the column names associated to the data.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.getcolnamesdir-Tuple{String}","page":"Types and Functions","title":"Helium.getcolnamesdir","text":"Helium.getcolnamesdir -Function.\n\n`Helium.getcolnamesdir(source)` => `Array{String, 2}`\n\nReturn an array of string containing the column names of the original CSV files.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.getmat-Tuple{HeAttributes}","page":"Types and Functions","title":"Helium.getmat","text":"Helium.getmat -Function.\n\n`Helium.getmat(source, DataType, numRows::Int64, numCols::Int64,\nisHeader::Bool, isRowNames::BoolnumRows)` => `matrix, column names, row names`\n\nRead the data matrix and extract column and row names if they exist.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.getrownames-Tuple{String}","page":"Types and Functions","title":"Helium.getrownames","text":"Helium.getrownames -Function.\n\n`Helium.getrownames(source)` => `Array{String, 1}`\n\nReturn an array of string containing the row names associated with the data.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.getrownamesdir-Tuple{String}","page":"Types and Functions","title":"Helium.getrownamesdir","text":"Helium.getrownamesdir -Function.\n\n`Helium.getrownamesdir(source)` => `Array{String, 2}`\n\nReturn an array of string containing the row names of the original CSV files.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.getskipmat-Tuple{HeAttributes}","page":"Types and Functions","title":"Helium.getskipmat","text":"Helium.getskipmat -Function.\n\n`Helium.getskipmat(source, DataType, numRows::Int64, numCols::Int64,\nisHeader::Bool, isRowNames::BoolnumRows)` => `matrix, column names, row names`\n\nRead the data matrix and extract column and row names if they exist.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.getsupp-Tuple{String}","page":"Types and Functions","title":"Helium.getsupp","text":"Helium.getsupp -Function.\n\n`Helium.getsupp(source)` => `Array{String, 2}`\n\nReturn an array of string containing the supplement data associated with the matrix data.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.getsuppdir-Tuple{String}","page":"Types and Functions","title":"Helium.getsuppdir","text":"Helium.getrownamesdir -Function.\n\n`Helium.getrownamesdir(source)` => `Array{String, 2}`\n\nReturn an array of string containing the row names of the original CSV files.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.he2csv-Tuple{String,String}","page":"Types and Functions","title":"Helium.he2csv","text":"Helium.he2csv -Function.\n\n`Helium.he2csv(source, outputFile, DataType;\n               strMiss::String = \"NaN\", nameColRows::String=\"ID\",\n               sep::String = \",\")` => `file`\n\nConvert a Helium binary file into a CSV format. The function gather all information from the helium file to generate a CSV file. It is possible to map the NaN elements of the matrx into a new string,  strMiss. By default, if the column and row names exist, the name of the  sample column is called \"ID\".\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.readhe-Tuple{String}","page":"Types and Functions","title":"Helium.readhe","text":"Helium.readhe -Function.\n\n`Helium.readhe(source)` => `Matrix`\n\nParse a binary file into a matrix. The binary files .he format includes a header that describes the size and the data type of the matrix, as well as the endianness of the file. The first 56 bytes contains: [number of rows, number of columns, data type, endianness,  if column names exists, if row names exists, number of column of supplement]\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.readheader-Tuple{String}","page":"Types and Functions","title":"Helium.readheader","text":"Helium.readheader -Function.\n\n`Helium.readheader(source)` => `NamedTuple{(:numrows, :numcols,\n                                            :datatype, :endianness,\n                                             :hascolnames, :hasrownames,\n                                             :bytesize),\n                                             Tuple{Int64,Int64,\n                                                   DataType,String,\n                                                   Bool,Bool,\n                                                   Int64}}`\n\nReturn a tuple containing respectively number of rows, number of columns, data type, endianness, if there is column names , and if if there is row names.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.readheaderdir-Tuple{String}","page":"Types and Functions","title":"Helium.readheaderdir","text":"Helium.readheaderdir -Function.\n\n`Helium.readheaderdir(source)` => `NamedTuple{(:numrows, :numcols,\n                                               :datatype, :endianness),\n                                             Tuple{Int64,Int64,\n                                                   DataType,String}}`\n\nReturn a tuple containing respectively number of rows, number of columns, data type, endianness.\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.readhedir-Tuple{String}","page":"Types and Functions","title":"Helium.readhedir","text":"Helium.readhedir -Function.\n\n`Helium.readhedir(source)` => `Matrix`\n\nParse a binary file into a matrix. The binary files .he format includes a header that describes the size and the data type of the matrix, as well as the endianness of the file. The first 32 bytes contains: [number of rows, number of columns, data type, endianness]\n\n\n\n\n\n","category":"method"},{"location":"functionDoc/#Helium.writehe-Tuple{Any,String}","page":"Types and Functions","title":"Helium.writehe","text":"Helium.writehe -Function.\n\n`Helium.writehe(matrix, source;\n                colNames::Array{String,1} = [\"\"],\n                rowNames::Array{String,1} = [\"\"],\n                supplement::Array{String,2} = [\"\" \"\"])` => `file`\n\nWrite a matrix (2D array) to a binary .he file, given as an IO argument or String/FilePaths.jl type representing the file name to write. The binary files Helium format includes a header that describes the size and the data type of the matrix, as well as the endianness of the file. The first 56 bytes contains: [number of rows, number of columns, data type, endianness,  if column names exists, if row names exists, number of column of supplement]\n\n\n\n\n\n","category":"method"},{"location":"#Helium.jl","page":"Home","title":"Helium.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Helium.jl package proposes a tabular data serialization format with the following goals: light (i.e., on storage disk), fast (i.e., saving and loading times), and flexible(i.e., accommodating simplicity in metadata). Helium format is designed for numerical matrix-like data with metadata such as row names, column names, and extra columns of a different type.","category":"page"},{"location":"","page":"Home","title":"Home","text":"In some research fields, such as in omics data analysis, it remains common to read and write very large tabular data sets in CSV file format (> 10Gb) that embed matrix-like data. CSV format indeed offers numerous advantages. CSV files are easy to create. CSV format is human-readable. One can use almost any text editor to read it. It is easy to parse with most of the platforms. The inherent simplicity of the CSV format makes it a popular choice for a vast number of datasets. However, even if manipulating CSV files is straightforward, the CSV format may come at a price for large files. The CSV format is not memory efficient. Moreover, as the file size grows, load times can become impractical. The CSV format's nature makes it an excellent option for small datasets (~ < 2 Gb), but it is very inefficient for managing larger datasets (> 10Gb).","category":"page"},{"location":"","page":"Home","title":"Home","text":"What makes Helium format light and fast reading/writing is that it is binary based. The Helium format is compatible with any OS and any endianness.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The Helium.jl package permits reading and writing helium format and offers functions to convert Helium to CSV and vice versa. Conversion preserves all metadata, including row names, column names, and extra columns.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"In a Julia REPL, enter pkg mode (by pressing ]) and run:","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg>add Helium","category":"page"},{"location":"#Usage","page":"Home","title":"Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The helium format is basically a binary file where we have compartmented all the potential following information:","category":"page"},{"location":"","page":"Home","title":"Home","text":"Design of the Helium meta format  \n\n CHUNK 1 ___ [NROWS NCOLS TYPE ENDIAN HASCOLNAMES HASROWNAMES NUMCOLSUPP]   \n        |   \n        |   \n CHUNK 2 ___ [DATA]   \n        |   \n        |   \n CHUNK 3 ___ [COLNAMES] (optional)  \n        |  \n        |   \n CHUNK 4 ___ [ROWNAMES] (optional)\n        |  \n        |   \nCHUNK 5 ___ [SUPPLEMENT] (optional)","category":"page"},{"location":"gettingStarted/#Getting-Started","page":"Getting Started","title":"Getting Started","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Here are some simple examples of converting CSV files to Helium format with various arguments.","category":"page"},{"location":"gettingStarted/#Write-and-Read-Helium-file","page":"Getting Started","title":"Write and Read Helium file","text":"","category":"section"},{"location":"gettingStarted/#Key-function","page":"Getting Started","title":"Key function","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"The function writehe() requires at least two arguments: the matrix and the file's path. And, the function readhe() requires only one argument: the file's path. It returns the matrix from the Helium file.","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"writehe(mat, heFile::String; colNames::Array{String,1} = [\"\"],\n         rowNames::Array{String,1} = [\"\"],\n         supplement::Array{String,2} = [\"\" \"\"])","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Arguments  ","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"mat:  data matrix.   \nheFile: a string that indicates the path of the helium .he file.   \ncolNames: an array of strings that contains the names of the columns associated to the data matrix.    \nrowNames: an array of strings that contains the names of the rows associated to the data matrix.    \nsupplement: a matrix of strings that is a supplemental information associated to the data matrix. Its number of rows is identical to the data matrix. It may include column names only if there exist column names associated to the data matrix.","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"readhe(heFile::String)","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Arguments  ","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"heFile: a string that indicates the path of the helium .he file.   ","category":"page"},{"location":"gettingStarted/#Example","page":"Getting Started","title":"Example","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"julia> using Helium  \n\njulia> toymat = [1.5 8 12 24;7 22 24 70]\n2×4 Array{Float64,2}:\n 1.5   8.0  12.0  24.0\n 7.0  22.0  24.0  70.0\n\njulia> Helium.writehe(toymat, \"~/Project/data/testFile.he\")\n\njulia> Helium.readhe(\"~/Project/data/testFile.he\")       \n2×4 Array{Float64,2}:\n 1.5   8.0  12.0  24.0\n 7.0  22.0  24.0  70.0\n","category":"page"},{"location":"gettingStarted/#Convert-CSV-to-Helium-format-Key-function","page":"Getting Started","title":"Convert CSV to Helium format Key function","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Helium.csv2he converts a CSV file that contains a matrix like data into the Helium format.","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"csv2he(csvFile::String, heFile::String, matType::DataType;\n                hasColNames::Bool=true, hasRowNames::Bool=false,\n                strMiss::String=\"na\", sep::String=\",\", skipCol::Int64=0)","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Arguments  ","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"csvFile:  a string that indicates the path of the CSV file.   \nheFile: a string that indicates the path of the helium .he file.   \nmatType: the type of data (e.g., Float64,Int64,...).   \nhasColNames: a boolean. If true (default: true) we assume that the CSV file includes the column names.    \nhasRowNames: a boolean. If true (default:false) we assume that the CSV file includes the row names.\nstrMiss: a string in the CSV file that identifies missing elements in the matrix. By default \"NA\" and \"missing\" are considered as missing data and they will be mapped as NaN inside the matrix. The string strMiss represents an additional possibility to look for missing or NA element. It is not case sensitive.  \nsep: a string delimiter that separates the elements. By defaults, the delimiter is a comma \",\".\nskipCol: the number of columns to skip before to start reading the matrix in the CSV file. By default, its value is 0. If its value is greater than zero then the skipped columns will be saved as supplemental data in the helium file.","category":"page"},{"location":"gettingStarted/#CSV-to-Helium:-no-metadata","page":"Getting Started","title":"CSV to Helium: no metadata","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"In this example, we consider a simple CSV file without column names and without row names. Our CSV file, for instance, looks like the following:","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"1.5,3,12,24\n7,22,24,70","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"julia> using Helium\n\njulia> Helium.csv2he(\"~/Project/data/testFile.csv\", \"~/Project/data/testFile.he\", Float64,\n       hasColNames = false)\n\njulia> Helium.readhe(\"~/Project/data/testFile.he\")       \n2×4 Array{Float64,2}:\n 1.5   3.0  12.0  24.0\n 7.0  22.0  24.0  70.0\n","category":"page"},{"location":"gettingStarted/#CSV-to-Helium:-with-row-and-column-names","page":"Getting Started","title":"CSV to Helium: with row and column names","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"In the next example, we consider a CSV file that includes the column names and the row names. Here what the CSV file looks like in our example:","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"ID,col1,col2,col3,col4   \n1,1.5,8,12,24   \n2,7,22,24,70   ","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"julia> using Helium\n\njulia> Helium.csv2he(\"~/Project/data/testFile.csv\", \"~/Project/data/testFile.he\", Float64,\n       hasRowNames = true)\n\njulia> Helium.readhe(\"~/Project/data/testFile.he\")\n2×4 Array{Float64,2}:\n 1.5   8.0  12.0  24.0\n 7.0  22.0  24.0  70.0      \n","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"During the conversion to He format, the variables names and the sample IDs are embedded if the helium format file. Once the helium file is created, it is also possible to get the column and row names by using the functions getcolnames() and getrownames(). Both functions take the file's path as an argument and return an Array{String, 1}.  ","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"\njulia> Helium.getcolnames(\"~/Project/data/testFile.he\")   \n4-element Array{String,1}:\n \"col1\"\n \"col2\"\n \"col3\"\n \"col4\"\n\njulia> Helium.getrownames(\"~/Project/data/testFile.he\")   \n2-element Array{String,1}:\n \"1\"\n \"2\"\n","category":"page"},{"location":"gettingStarted/#CSV-to-Helium:-missing-data","page":"Getting Started","title":"CSV to Helium: missing data","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Next, we give an example where we specify what string corresponds to a missing data. By default, \"NA\"s and \"NaN\"s are checked in as NaN in our matrix of float or integer, but we can also add a customized string representing missing data. In our CSV file, we consider that \"X\" is a missing data:","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"1.5,8,12,X,24   \n7,22,24,NA,70","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"julia> using Helium\n\njulia> Helium.csv2he(\"~/Project/data/testFile.csv\", \"~/Project/data/testFile.he\", Float64,\n       hasColNames = false,  strMiss = \"X\")\n\njulia> Helium.readhe(\"~/Project/data/testFile.he\")   \n2×5 Array{Float64,2}:\n 1.5   8.0  12.0  NaN  24.0\n 7.0  22.0  24.0  NaN  70.0    ","category":"page"},{"location":"gettingStarted/#CSV-to-Helium:-extra-columns","page":"Getting Started","title":"CSV to Helium: extra columns","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"The argument skipCol gives the option to skip an arbitrary number of columns before reading the matrix data. The skipped columns are preserved as supplemental Array{String,2} built-in the Helium file. To obtain this supplemental data, we use the function getsupp(). Let consider the following CSV file as an example, where we will skip 2 columns after the sample IDs:","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"ID,var1,var2,var3,var4,var5  \nID1,Xtra1,3,1.5,X,12   \nID2,Xtra2,10,7.0,22,70","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"julia> using Helium\n\njulia> Helium.csv2he(\"~/Project/data/testFile.csv\", \"~/Project/data/testFile.he\", Float64,\n     hasRowNames = true, strMiss = \"x\", skipCol = 2)\n\njulia> Helium.readhe(\"~/Project/data/testFile.he\")   \n2×3 Array{Float64,2}:\n1.5   NaN  12.0  \n7.0  22.0  70.0  \n\njulia> Helium.getcolnames(\"~/Project/data/testFile.he\")   \n3-element Array{String,1}:\n\"var3\"\n\"var4\"\n\"var5\"\n\njulia> Helium.getrownames(\"~/Project/data/testFile.he\")   \n2-element Array{String,1}:\n\"ID1\"\n\"ID2\"\n\njulia> Helium.getsupp(\"~/Project/data/testFile.he\")   \n3×2 Array{String,2}:\n\"var1\"   \"var2\"\n\"Xtra1\"  \"3\"\n\"Xtra2\"  \"10\"\n","category":"page"},{"location":"gettingStarted/#Convert-Helium-into-a-CSV-format","page":"Getting Started","title":"Convert Helium into a CSV format","text":"","category":"section"},{"location":"gettingStarted/#Key-function-2","page":"Getting Started","title":"Key function","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Helium.he2csv converts a Helium file into a CSV file.","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"he2csv(heFile::String, csvFile::String;\n               strMiss::String=\"NaN\", nameColRows::String=\"ID\", sep::String=\",\")\n","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Arguments  ","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"heFile: a string that indicates the path of the helium .he file.   \ncsvFile:  a string that indicates the path of the CSV file.\nstrMiss: a string that will be used in the CSV file to indicates missing or NA elements in the matrix. By default \"NaN\" is used. It is case sensitive.   \nnameColRows: a string that assigns a column name for the row names in the CSV file. By default, the name is \"ID\", if the data has row names. nameColRows is used only if there exists row names and column names in the helium file.   \nsep: a string delimiter that separates the elements. By defaults, the delimiter is a comma \",\".  ","category":"page"},{"location":"gettingStarted/#Example-2","page":"Getting Started","title":"Example","text":"","category":"section"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"In this example, let suppose that the file testFile.he contains a data matrix with row and column names. By using the functions readhe, getrownames, getcolnames we can check their contents. By using the function he2csv, we are able to convert the helium file into a CSV file.","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"julia> using Helium\n\njulia> Helium.readhe(\"~/Project/data/testFile.he\")   \n2×5 Array{Float64,2}:\n NaN   3.0  12.0\n 7.0  22.0  70.0\n\njulia> Helium.getcolnames(\"~/Project/data/testFile.he\")   \n4-element Array{String,1}:\n  \"var1\"\n  \"var2\"\n  \"var3\"\n\njulia> Helium.getrownames(\"~/Project/data/testFile.he\")   \n2-element Array{String,1}:\n  \"ID1\"\n  \"ID2\"\n\njulia> Helium.he2csv(\"~/Project/data/testFile.he\", \"~/Project/data/testFile.csv\", strMiss = \"X\")\n","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"Our CSV file would look like the following:","category":"page"},{"location":"gettingStarted/","page":"Getting Started","title":"Getting Started","text":"ID,var1,var2,var3   \nID1,X,3.0,12.0   \nID2,7.0,22.0,70.0","category":"page"}]
}
