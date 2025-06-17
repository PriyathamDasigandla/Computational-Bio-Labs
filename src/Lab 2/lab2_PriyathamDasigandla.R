
# -----------------------------
# Exercise 1: rmval function
# -----------------------------

rmval <- function(x, p) {
    (x[-p])
}

# to test the function
x <- c(1, 2, 3, 4, 5)
result <- rmval(x, 3)
print(result)


# -----------------------------
# Exercise 2: Random matrix
# -----------------------------

matrix_data <- matrix(runif(6 * 15, min = 0, max = 1), nrow = 15, ncol = 6)
print(matrix_data)


# -----------------------------
# Exercise 3: RNA-seq Data Frame
# -----------------------------

expression_data <- matrix(rnorm(12 * 6, mean = 10, sd = 2), nrow = 12, ncol = 6)
patients <- paste0("P", 1:12)
condition <- c(rep("treated", 6), rep("control", 6))

# Combine into a data frame
rna_df <- data.frame(
    Patient = patients,
    Condition = condition,
    expression_data
)

colnames(rna_df)[3:8] <- paste0("Gene", 1:6)

print(rna_df)