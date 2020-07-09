abstract type HeAttributes end


"""
He is a mutable composite type that is describe the attributes of the data contained
in the Helium format file..

"""
mutable struct HeInfo  <: HeAttributes
    fileName::String
    matType::DataType
    numCols::Int64
    numRows::Int64
    hasColNames::Bool
    hasRowNames::Bool
    strMiss::String
    sep::String
    skipCol::Int64
end
