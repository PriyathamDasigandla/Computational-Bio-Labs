# Lab 1 - Introduction to R
# Name: Priyatham Dasigandla
# Date: June 7, 2025

# Exercice 1

#First code snippet
x <- c(TRUE, FALSE, NA, TRUE)
if (any(x)) {
  print("At least one TRUE")
} else {
  print("No TRUE values")
}

#Second code snippet
x <- c(TRUE, FALSE, NA, TRUE)
if (any(x, na.rm = TRUE)) {
  print("At least one TRUE (ignoring NA)") #Added "ignoring NA" for clarity
} else {
  print("No TRUE values")
}


# Exercice 2
sum <- 0
values <- c(1, 2, 3, 4, 5)
for (i in values){
  sum <- sum + i
  print(i)
  i <- 3
  cat(paste("i = ", i, "\n"))
  cat(paste("sum = ", sum, "\n"))
}