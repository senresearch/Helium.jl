using Helium, DelimitedFiles


# Create testing matrix
testmat = [1.5 8 12 24;
           7 22 24 75]

# File name in .he format
fileName = string(@__DIR__,"/data/testFile.he")

########################
# Test Writing/Reading #
########################


# Write the matrix in .he format
Helium.writehe(fileName, testmat)

# Read the .he file and compare with original matrix
newmat = Helium.readhe(fileName)
if newmat == testmat
      println("IO Success!")
else
      println("IO Something went wrong!")
end

#############################
# Test Converting CSV to He #
#############################

# TEST 1
# Test function to convert CSV to He, without header nor row names

# Create CSV file
csvFileName = string(fileName[1:end-2], "csv")
open(csvFileName, "w") do io
    writedlm(io, testmat, ',')
end;

# Convert CSV to He
Helium.csv2he(csvFileName, Float64, isHeader = false)

# Read the .he file and compare with original matrix
newmat = Helium.readhe(fileName)
if newmat == testmat
      println("Test 1: Converting is a success!")
else
      println("Test 1: Something went wrong during conversion!")
end


# TEST 2
# Test function to convert CSV to He, with header but no row names

# Create testing matrix
testmat = [
     "col1" "col2" "col3" "col4"
     1.5    8      12     24
     7      22     24     75
]

 # Create CSV file
 csvFileName = string(fileName[1:end-2], "csv")
 open(csvFileName, "w") do io
          writedlm(io, testmat, ',')
 end;

 # Convert CSV to He
 Helium.csv2he(csvFileName, Float64)

 # Read the .he file and compare with original matrix
 newmat = Helium.readhe(fileName)
 if newmat == testmat[2:end, :]
       println("Test 2: Converting is a success!")
 else
       println("Test 2: Something went wrong during conversion!")
 end


 # TEST 3
 # Test function to convert CSV to He, with header and row names

 # Create testing matrix
 testmat = [
     "ID" "col1" "col2" "col3" "col4"
     1     1.5    8      12     24
     2     7      22     24     75
 ]

 # Create CSV file
 csvFileName = string(fileName[1:end-2], "csv")
 open(csvFileName, "w") do io
          writedlm(io, testmat, ',')
 end;

 # Convert CSV to He
 Helium.csv2he(csvFileName, Float64, isRowNames = true)

 # Read the .he file and compare with original matrix
 newmat = Helium.readhe(fileName)
 if newmat == testmat[2:end, 2:end]
       println("Test 3: Converting is a success!")
 else
       println("Test 3: Something went wrong during conversion!")
 end
