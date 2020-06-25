using Helium, DelimitedFiles


# Create testing matrix
testmat = [1.5 8 12 24;
           7 22 24 75]

# File name in .he format
fileName = string(@__DIR__,"/data/testDir.he")

########################
# Test Writing/Reading #
########################
# TEST 1

# Write the matrix in .he format
Helium.writehedir(testmat, abspath(fileName))

# Read the .he file and compare with original matrix
newmat = Helium.readhedir(fileName)
println("IO test 1: ", @test newmat == testmat)

#############################
# Test Converting CSV to He #
#############################
# TEST 2
# Test function to convert CSV to He, without header nor row names

# Create CSV file
csvFileName = string(fileName[1:end-2], "csv")
open(csvFileName, "w") do io
    writedlm(io, testmat, ',')
end;

# Convert CSV to He
Helium.csv2hedir(csvFileName, fileName, Float64, hasColNames = false)

# Read the .he file and compare with original matrix
newmat = Helium.readhedir(fileName)
println("CSV to He test 2: ", @test newmat == testmat)


# TEST 3
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
 Helium.csv2hedir(csvFileName, fileName, Float64)

 # Read the .he file and compare with original matrix
 newmat = Helium.readhedir(fileName)
 println("CSV to He with column names test 3: ",
         @test newmat == testmat[2:end, :])


 # TEST 4
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
 Helium.csv2hedir(csvFileName, fileName, Float64, hasRowNames = true)

 # Read the .he file and compare with original matrix
 newmat = Helium.readhedir(fileName)
 println("CSV to He with column and row names test 4: ",
         @test newmat == testmat[2:end, 2:end])


 #####################################
 # Test Getting column and row names #
 #####################################
# TEST 5
# Get column names
 colnames = Helium.getcolnamesdir(fileName);
 println("Get column names test 5: ",
         @test colnames == string.(testmat[1,2:end]))

# TEST 6
# Get row names
 rownames = Helium.getrownamesdir(fileName);
 println("Get row names test 6: ",
         @test rownames == string.(testmat[2:end, 1]))

 #############################################
 # Test Missing option during CSV conversion #
 #############################################
 # TEST 7
 # Test option for replacing missing data

 # Create testing matrix
 testmat = [
     "X"     1.5    8      12     24
     "NA"     7      22     24     75
 ]

 # Create CSV file
 csvFileName = string(fileName[1:end-2], "csv")
 open(csvFileName, "w") do io
          writedlm(io, testmat, ',')
 end;

 # Convert CSV to He
 Helium.csv2hedir(csvFileName, fileName, Float64, hasColNames = false, strMiss = "x")

 # Read the .he file and compare with original matrix
 newmat = Helium.readhedir(fileName)
 println("Missing customization test 7: ",
         @test isnan(newmat[1,1]) & isnan(newmat[2,1]))

 ##############################################
 # Test Skipping option during CSV conversion #
 ##############################################
 # TEST 8
 # Test option for Skipping some column

 # Create testing matrix
 testmat = [
     "ID1"    "Xtra1"    "X"    1.5      8      12     24
     "ID2"    "Xtra2"    "NA"   7.0      22     24     75
 ]

 # Create CSV file
 csvFileName = string(fileName[1:end-2], "csv")
 open(csvFileName, "w") do io
          writedlm(io, testmat, ',')
 end;

 # Convert CSV to He
 Helium.csv2hedir(csvFileName, fileName, Float64, hasColNames = false, hasRowNames = true,
               strMiss = "x", skipCol = 1)

 # Read the .he file and compare with original matrix
 newmat = Helium.readhedir(fileName)
 println("Skipping columns test 8: ",
         @test newmat[:,2:end] == convert(Array{Float64,2}, testmat[:, 4:end]))



 ###########################
 # Test getting supplement #
 ###########################
 # TEST 9

 # Create testing matrix
 testmat = [
         "ID"     "var1" "var2"  "var3"  "var4"  "var5"  "var6"
        "ID1"    "Xtra1"      3     1.5     "X"      12      24
        "ID2"    "Xtra2"     10     7.0      22      24      75
 ]

 # Create CSV file
 csvFileName = string(fileName[1:end-2], "csv")
 open(csvFileName, "w") do io
          writedlm(io, testmat, ',')
 end;

 # Convert CSV to He
 Helium.csv2hedir(csvFileName, fileName, Float64, hasRowNames = true,
               strMiss = "x", skipCol = 2)

 # Read the .he file and compare with original matrix
 newmat = Helium.getsuppdir(fileName)
 println("Getting supplement test 9: ",
         @test newmat == convert(Array{String,2}, string.(testmat[:, 2:3])))
