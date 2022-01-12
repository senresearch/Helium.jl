# Helium.jl

`Helium.jl` package proposes a tabular data serialization format with the following goals: light (i.e., on storage disk), fast (i.e., saving and loading times), and flexible(i.e., accommodating simplicity in metadata). Helium format is designed for numerical matrix-like data with metadata such as row names, column names, and extra columns of a different type. Helium format can also store and load n-dimensional numerical matrix-like data (*e.g.*, 3-D dimension matrix). 

In some research fields, such as in omics data analysis, it remains common to read and write very large tabular data sets in CSV file format (> 10Gb) that embed matrix-like data. CSV format indeed offers numerous advantages. CSV files are easy to create. CSV format is human-readable. One can use almost any text editor to read it. It is easy to parse with most of the platforms. The inherent simplicity of the CSV format makes it a popular choice for a vast number of datasets.
However, even if manipulating CSV files is straightforward, the CSV format may come at a price for large files. The CSV format is not memory efficient. Moreover, as the file size grows, load times can become impractical. The CSV format's nature makes it an excellent option for small datasets (~ < 2 Gb), but it is very inefficient for managing larger datasets (> 10Gb).

What makes Helium format light and fast reading/writing is that it is binary based. The Helium format is compatible with any OS and any endianness.

The `Helium.jl` package permits reading and writing helium format and offers functions to convert Helium to CSV and vice versa.
Conversion preserves all metadata, including row names, column names, and extra columns.

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
