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
      println("Success!")
else
      println("Something went wrong!")
end

#############################
# Test Converting CSV to He #
#############################

 # Test function to convert CSV to He

 # Create CSV file
 csvFileName = string(fileName[1:end-2], "csv")
 open(csvFileName, "w") do io
          writedlm(io, testmat, ',')
 end;

 # Convert CSV to He
 Helium.csv2he(csvFileName, Float64)

 # Read the .he file and compare with original matrix
 newmat = Helium.readhe(fileName)
 if newmat == testmat
       println("Converting is a success!")
 else
       println("Something went wrong during conversion!")
 end
