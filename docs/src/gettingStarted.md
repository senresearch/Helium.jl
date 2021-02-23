# Getting Started

Here are some simple examples of converting CSV files to Helium format with various arguments.

## Write and Read Helium file

### Key function

The function `writehe()` requires at least two arguments: the matrix and the file's path. And, the function `readhe()` requires only one argument: the file's path. It returns the matrix from the Helium file.

```julia
writehe(mat, heFile::String; colNames::Array{String,1} = [""],
         rowNames::Array{String,1} = [""],
         supplement::Array{String,2} = ["" ""])
```
**Arguments**  

- `mat`:  data matrix.   
- `heFile`: a string that indicates the path of the helium `.he` file.   
- `colNames`: an array of strings that contains the names of the columns associated to the data matrix.    
- `rowNames`: an array of strings that contains the names of the rows associated to the data matrix.    
- `supplement`: a matrix of strings that is a supplemental information associated to the data matrix. Its number of rows is identical to the data matrix. It may include column names only if there exist column names associated to the data matrix.



```julia
readhe(heFile::String)
```
**Arguments**  

- `heFile`: a string that indicates the path of the helium `.he` file.   

### Example


```julia
julia> using Helium  

julia> toymat = [1.5 8 12 24;7 22 24 70]
2×4 Array{Float64,2}:
 1.5   8.0  12.0  24.0
 7.0  22.0  24.0  70.0

julia> Helium.writehe(toymat, "~/Project/data/testFile.he")

julia> Helium.readhe("~/Project/data/testFile.he")       
2×4 Array{Float64,2}:
 1.5   8.0  12.0  24.0
 7.0  22.0  24.0  70.0

```

## Convert CSV to Helium format Key function
`Helium.csv2he` converts a CSV file that contains a matrix like data into the Helium format.

```julia
csv2he(csvFile::String, heFile::String, matType::DataType;
                hasColNames::Bool=true, hasRowNames::Bool=false,
                strMiss::String="na", sep::String=",", skipCol::Int64=0)
```
**Arguments**  

- `csvFile`:  a string that indicates the path of the CSV file.   
- `heFile`: a string that indicates the path of the helium `.he` file.   
- `matType`: the type of data (*e.g.,* `Float64`,`Int64`,...).   
- `hasColNames`: a boolean. If `true` (default: `true`) we assume that the CSV file includes the column names.    
- `hasRowNames`: a boolean. If `true` (default:`false`) we assume that the CSV file includes the row names.
- `strMiss`: a string in the CSV file that identifies missing elements in the matrix. By default "NA" and "missing" are considered as missing data and they will be mapped as `NaN` inside the matrix. The string `strMiss` represents an additional possibility to look for missing or NA element. It is not case sensitive.  
- `sep`: a string delimiter that separates the elements. By defaults, the delimiter is a comma ",".
- `skipCol`: the number of columns to skip before to start reading the matrix in the CSV file. By default, its value is 0. If its value is greater than zero then the skipped columns will be saved as supplemental data in the helium file.

## CSV to Helium: no metadata

In this example, we consider a simple CSV file without column names and without row names. Our CSV file, for instance, looks like the following:

```text
1.5,3,12,24
7,22,24,70
```


```julia
julia> using Helium

julia> Helium.csv2he("~/Project/data/testFile.csv", "~/Project/data/testFile.he", Float64,
       hasColNames = false)

julia> Helium.readhe("~/Project/data/testFile.he")       
2×4 Array{Float64,2}:
 1.5   3.0  12.0  24.0
 7.0  22.0  24.0  70.0

```

## CSV to Helium: with row and column names

In the next example, we consider a CSV file that includes the column names and the row names. Here what the CSV file looks like in our example:

```text
ID,col1,col2,col3,col4   
1,1.5,8,12,24   
2,7,22,24,70   
```


```julia
julia> using Helium

julia> Helium.csv2he("~/Project/data/testFile.csv", "~/Project/data/testFile.he", Float64,
       hasRowNames = true)

julia> Helium.readhe("~/Project/data/testFile.he")
2×4 Array{Float64,2}:
 1.5   8.0  12.0  24.0
 7.0  22.0  24.0  70.0      

```

During the conversion to He format, the variables names and the sample IDs are embedded if the helium format file. Once the helium file is created, it is also possible to get the column and row names by using the functions `getcolnames()` and `getrownames()`. Both functions take the file's path as an argument and return an `Array{String, 1}`.  

```julia

julia> Helium.getcolnames("~/Project/data/testFile.he")   
4-element Array{String,1}:
 "col1"
 "col2"
 "col3"
 "col4"

julia> Helium.getrownames("~/Project/data/testFile.he")   
2-element Array{String,1}:
 "1"
 "2"

```

## CSV to Helium: missing data

Next, we give an example where we specify what string corresponds to a missing data. By default, "NA"s and "NaN"s are checked in as `NaN` in our matrix of float or integer, but we can also add a customized string representing missing data. In our CSV file, we consider that "X" is a missing data:

```text
1.5,8,12,X,24   
7,22,24,NA,70
```


```julia
julia> using Helium

julia> Helium.csv2he("~/Project/data/testFile.csv", "~/Project/data/testFile.he", Float64,
       hasColNames = false,  strMiss = "X")

julia> Helium.readhe("~/Project/data/testFile.he")   
2×5 Array{Float64,2}:
 1.5   8.0  12.0  NaN  24.0
 7.0  22.0  24.0  NaN  70.0    
```

## CSV to Helium: extra columns

The argument `skipCol` gives the option to skip an arbitrary number of columns before reading the matrix data. The skipped columns are preserved as supplemental `Array{String,2}` built-in the Helium file. To obtain this supplemental data, we use the function `getsupp()`. Let consider the following CSV file as an example, where we will skip 2 columns after the sample IDs:

```text
ID,var1,var2,var3,var4,var5  
ID1,Xtra1,3,1.5,X,12   
ID2,Xtra2,10,7.0,22,70
```


```julia
julia> using Helium

julia> Helium.csv2he("~/Project/data/testFile.csv", "~/Project/data/testFile.he", Float64,
     hasRowNames = true, strMiss = "x", skipCol = 2)

julia> Helium.readhe("~/Project/data/testFile.he")   
2×3 Array{Float64,2}:
1.5   NaN  12.0  
7.0  22.0  70.0  

julia> Helium.getcolnames("~/Project/data/testFile.he")   
3-element Array{String,1}:
"var3"
"var4"
"var5"

julia> Helium.getrownames("~/Project/data/testFile.he")   
2-element Array{String,1}:
"ID1"
"ID2"

julia> Helium.getsupp("~/Project/data/testFile.he")   
3×2 Array{String,2}:
"var1"   "var2"
"Xtra1"  "3"
"Xtra2"  "10"

```

## Convert Helium into a CSV format

### Key function

`Helium.he2csv` converts a Helium file into a CSV file.

```julia
he2csv(heFile::String, csvFile::String;
               strMiss::String="NaN", nameColRows::String="ID", sep::String=",")

```
**Arguments**  

- `heFile`: a string that indicates the path of the helium `.he` file.   
- `csvFile`:  a string that indicates the path of the CSV file.
- `strMiss`: a string that will be used in the CSV file to indicates missing or NA elements in the matrix. By default "NaN" is used. It is case sensitive.   
- `nameColRows`: a string that assigns a column name for the row names in the CSV file. By default, the name is "ID", if the data has row names. `nameColRows` is used only if there exists row names and column names in the helium file.   
- `sep`: a string delimiter that separates the elements. By defaults, the delimiter is a comma ",".  


### Example

In this example, let suppose that the file *testFile.he* contains a data matrix with row and column names. By using the functions `readhe`, `getrownames`, `getcolnames` we can check their contents. By using the function `he2csv`, we are able to convert the helium file into a CSV file.

```julia
julia> using Helium

julia> Helium.readhe("~/Project/data/testFile.he")   
2×5 Array{Float64,2}:
 NaN   3.0  12.0
 7.0  22.0  70.0

julia> Helium.getcolnames("~/Project/data/testFile.he")   
4-element Array{String,1}:
  "var1"
  "var2"
  "var3"

julia> Helium.getrownames("~/Project/data/testFile.he")   
2-element Array{String,1}:
  "ID1"
  "ID2"

julia> Helium.he2csv("~/Project/data/testFile.he", "~/Project/data/testFile.csv", strMiss = "X")

```
Our CSV file would look like the following:

```text
ID,var1,var2,var3   
ID1,X,3.0,12.0   
ID2,7.0,22.0,70.0
```
