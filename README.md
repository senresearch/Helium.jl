# Helium.jl

A Julia matrix serialization format with the following goals

* Fast save and load times
* Light storage on disk

It is still standard in certain field to generate very large data set (matrix like)
in CSV file format. Due to the inherent type of CSV files, it usually takes a very long time to load them, mainly due to the parsing process. Helium format offers an alternative to read and write those kind of data set with a much faster IO processing.
