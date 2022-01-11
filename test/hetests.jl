using Helium, DelimitedFiles, Test


# Create testing matrix
testmat = [
        1.5   8  12  24
          7  22  24  75
]

# File name in .he format and CSV
fileName = string(@__DIR__,"/data/testFile.he")
csvFileName = string(fileName[1:end-2], "csv")

##########################
# TEST 1 Writing/Reading #
##########################

Helium.writehe(testmat, abspath(fileName))
rsltMat = Helium.readhe(fileName)
println("IO test 1: ", @test rsltMat == testmat)

#############################################################################
# TEST 2 Converting CSV to He: no row names, no column names, no supplement #
#############################################################################

open(csvFileName, "w") do io
    writedlm(io, testmat, ',')
end;

Helium.csv2he(csvFileName, fileName, Float64, hasColNames = false)
rsltMat = Helium.readhe(fileName)
println("CSV to He test 2: ", @test rsltMat == testmat)

##########################################################################
# TEST 3 Converting CSV to He: row names, no column names, no supplement #
##########################################################################
testmat = [
        "ID1"  1.5   8  12  24
        "ID2"    7  22  24  75
]

open(csvFileName, "w") do io
        writedlm(io, testmat, ',')
end;


Helium.csv2he(csvFileName, fileName, Float64, hasColNames = false,
                hasRowNames = true)
rsltMat = Helium.readhe(fileName)
println("CSV to He with row names test 3: ",
        @test rsltMat == testmat[:, 2:end])


##########################################################################
# TEST 4 Converting CSV to He: no row names, column names, no supplement #
##########################################################################
testmat = [
        "col1"  "col2"  "col3"  "col4"
           1.5       8      12      24
             7      22      24      75
]

open(csvFileName, "w") do io
        writedlm(io, testmat, ',')
end;

Helium.csv2he(csvFileName, fileName, Float64)
rsltMat = Helium.readhe(fileName)
println("CSV to He with column names test 4: ",
        @test rsltMat == testmat[2:end, :])

#######################################################################
# TEST 5 Converting CSV to He: row names, column names, no supplement #
#######################################################################
testmat = [
    "ID"  "col1"  "col2"  "col3"  "col4"
   "ID1"     1.5       8      12      24
   "ID2"       7      22      24      75
]

open(csvFileName, "w") do io
        writedlm(io, testmat, ',')
end;

Helium.csv2he(csvFileName, fileName, Float64, hasRowNames = true)
rsltMat = Helium.readhe(fileName)
println("CSV to He with column and row names test 5: ",
        @test rsltMat == testmat[2:end, 2:end])

#####################################################
# TEST 6 Converting CSV to He: getting column names #
#####################################################
colnames = Helium.getcolnames(fileName);
println("Get column names test 6: ",
        @test colnames == string.(testmat[1,2:end]))

###################################################
# TEST 7 Converting CSV to He: getting  row names #
###################################################
rownames = Helium.getrownames(fileName);
 println("Get row names test 7: ",
         @test rownames == string.(testmat[2:end, 1]))

#####################################################################
# TEST 8 Converting CSV to He: missing option during CSV conversion #
#####################################################################
testmat = [
      "X"   1.5    8   12   24
     "NA"     7   22   24   75
]

open(csvFileName, "w") do io
        writedlm(io, testmat, ',')
end;

Helium.csv2he(csvFileName, fileName, Float64, hasColNames = false, strMiss = "x")
rsltMat = Helium.readhe(fileName)
println("Missing customization test 8: ",
        @test isnan(rsltMat[1,1]) && isnan(rsltMat[2,1]))

#######################################################################
# TEST 9 Converting CSV to He: separator option during CSV conversion #
#######################################################################
testmat = [
        "col1"  "col2"  "col3"  "col4"
           1.5       8      12      24
             7      22      24      75
]

open(csvFileName, "w") do io
        writedlm(io, testmat, ' ')
end;

Helium.csv2he(csvFileName, fileName, Float64, sep = " ")
rsltMat = Helium.readhe(fileName)
println("CSV to He with customized delimeter test 9: ",
        @test rsltMat == testmat[2:end, :])

#######################################################################
# TEST 10 Converting CSV to He: skipping option during CSV conversion #
#######################################################################
testmat = [
     "ID1"    "Xtra1"    "X"    1.5      8      12     24
     "ID2"    "Xtra2"    "NA"   7.0      22     24     75
]

open(csvFileName, "w") do io
          writedlm(io, testmat, ',')
end;

Helium.csv2he(csvFileName, fileName, Float64, hasColNames = false,
        hasRowNames = true, strMiss = "x", skipCol = 1)
rsltMat = Helium.readhe(fileName)
println("Skipping columns test 10: ",
         @test rsltMat[:,2:end] == convert(Array{Float64,2}, testmat[:, 4:end]))

###########################################################
# TEST 11 Converting CSV to He: getting supplemental data #
###########################################################
testmat = [
      "ID"     "var1" "var2"  "var3"  "var4"  "var5"  "var6"
     "ID1"    "Xtra1"      3     1.5     "X"      12      24
     "ID2"    "Xtra2"     10     7.0      22      24      75
]

open(csvFileName, "w") do io
        writedlm(io, testmat, ',')
end;

Helium.csv2he(csvFileName, fileName,  Float64, hasRowNames = true,
               strMiss = "x", skipCol = 2)
rsltMat = Helium.getsupp(fileName)
println("Getting supplement test 11: ",
         @test rsltMat == convert(Array{String,2}, string.(testmat[:, 2:3])))

#############################################################################
# TEST 12 Converting CSV to He: getting supplemental data without row names #
#############################################################################
testmat = [
         "var1" "var2"  "var3"  "var4"  "var5"  "var6"
        "Xtra1"    3.0     1.5     "X"      12      24
        "Xtra2"   10.0     7.0    22.0      24      75
]

open(csvFileName, "w") do io
        writedlm(io, testmat, ',')
end;

Helium.csv2he(csvFileName, fileName,  Float64, strMiss = "x", skipCol = 2)
rsltMat = Helium.getsupp(fileName)
println("Getting supplement without row names test 12: ",
        @test rsltMat == convert(Array{String,2}, string.(testmat[:, 1:2])))

###########################################################
# TEST 13 Converting He to CSV: getting supplemental data #
###########################################################
Helium.he2csv( fileName, csvFileName, strMiss = "X")
rsltMat = readdlm(csvFileName, ',')
println("Converting He to CSV test 13: ",
         @test rsltMat == testmat)

 ###########################################################
 # TEST 14 Converting He to CSV: getting supplemental data #
 ###########################################################
 Helium.he2csv( fileName, csvFileName, strMiss = "X", sep = " ")
 rsltMat = readdlm(csvFileName, ' ')
 println("Converting He to CSV with customized delimiter test 14: ",
          @test rsltMat == testmat)

 ###############################################################
 # TEST 15 Writing/Reading array with dimension greater than 2 #
 ###############################################################
 dim4Testmat = rand(1,2,3,4);
 Helium.writehe(dim4Testmat, fileName);
 rsltMat = Helium.readhe(fileName);
 println("Writing/Reading array with dimension greater than 2 test 15: ",
          @test rsltMat == dim4Testmat)          
