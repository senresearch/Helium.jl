# Helium.jl

A Julia matrix serialization format with the following goals

* Fast save and load times
* Light storage on disk

It is still a common practice, in some fields, to generate very large tabular data sets (matrix-like) in CSV file format. Due to the inherent CSV files structure, it usually takes a very long time to load them, mainly due to the parsing process. Helium format offers an alternative to read and write those kinds of data set with a much faster IO processing.

## Installation

In a Julia REPL, enter `pkg` mode (by pressing `]`) and run:

```julia
pkg>add Helium
```


## Usage

The helium format is basically a binary file where we have compartmented all the potential following information:

```   
Design of the Helium meta format  

 CHUNK 1 ___ [NROWS NCOLS TYPE ENDIAN HASCOLNAMES HASROWNAMES NUMCOLSUPP]   
        |   
        |   
 CHUNK 2 ___ [DATA]   
        |   
        |   
 CHUNK 3 ___ [COLNAMES] (optional)  
        |  
        |   
 CHUNK 4 ___ [ROWNAMES] (optional)
        |  
        |   
CHUNK 5 ___ [SUPPLEMENT] (optional)
```

The Helium format is compatible with any OS and any endianness.


## Example

Here are some simple examples of converting CSV files to Helium format with various arguments.

### Write and read helium file

The function `writehe()` includes only two arguments: the matrix and the file's path. And, the function `readhe()` requires only one argument: the file's path. It returns the matrix from the helium file.



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

### Convert a CSV file to Helium file
`Helium.csv2he` converts a CSV file that contains a matrix like data into the Helium format.

```julia
csv2he(csvFile::String, heFile::String, matType::DataType;
                hasColNames::Bool=true, hasRowNames::Bool=false,
                strMiss::String="na", skipCol::Int64 =0)
```
**Arguments**  

- `csvFile`:  a string that indicates the path of the CSV file.   
- `heFile`: a string that indicates the path of the helium `.he` file.   
- `matType`: the type of data (*e.g.,* `Float64`,`Int64`,...).   
- `hasColNames`: a boolean. If `true` (default: `true`) we assume that the CSV file includes the column names.    
- `hasRowNames`: a boolean. If `true` (default:`false`) we assume that the CSV file includes the row names.
- `strMiss`: a string    

#### Example 1

In this example, we consider a simple CSV file without column names and without row names. Our CSV file, for instance, looks like the following:

> 1.5,3,12,24   
7,22,24,70



```julia
julia> using Helium

julia> Helium.csv2he("~/Project/data/testFile.csv", "~/Project/data/testFile.he", Float64,
       hasColNames = false)

julia> Helium.readhe("~/Project/data/testFile.he")       
2×4 Array{Float64,2}:
 1.5   3.0  12.0  24.0
 7.0  22.0  24.0  70.0

```

#### Example 2

In the next example, we consider a CSV file that includes the column names and the row names. Here what the CSV file looks like in our example:

> ID,col1,col2,col3,col4  
  1,1.5,8,12,24   
  2,7,22,24,70



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

#### Example 3

Next, we give an example where we specify what string corresponds to a missing data. By default, "NA"s and "NaN"s are checked in as `NaN` in our matrix of float or integer, but we can also add a customized string representing missing data. In our CSV file, we consider that "X" is a missing data:

> 1.5,8,12,X,24   
  7,22,24,NA,70



```julia
julia> using Helium

julia> Helium.csv2he("~/Project/data/testFile.csv", "~/Project/data/testFile.he", Float64,
       hasColNames = false,  strMiss = "X")

julia> Helium.readhe("~/Project/data/testFile.he")   
2×5 Array{Float64,2}:
 1.5   8.0  12.0  NaN  24.0
 7.0  22.0  24.0  NaN  70.0    
```

#### Example 4

The argument `skipCol` gives the option to skip an arbitrary number of columns before reading the matrix data. The skipped columns are preserved as supplemental `Array{String,2}` built-in the Helium file. To obtain this supplemental data, we use the function `getsupp()`. Let consider the following CSV file as an example, where we will skip 2 columns after the sample IDs:

> ID,var1,var2,var3,var4,var5,var6,   
  ID1,Xtra1,3,1.5,X,12,24   
  ID2,Xtra2,10,7.0,22,24,70



```julia
julia> using Helium

julia> Helium.csv2he("~/Project/data/testFile.csv", "~/Project/data/testFile.he", Float64,
       hasRowNames = true, strMiss = "x", skipCol = 1)

julia> Helium.readhe("~/Project/data/testFile.he")   
2×5 Array{Float64,2}:
 1.5   8.0  12.0  NaN  24.0
 7.0  22.0  24.0  NaN  70.0

 julia> Helium.getcolnames("~/Project/data/testFile.he")   
 4-element Array{String,1}:
  "var3"
  "var4"
  "var5"
  "var6"

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
