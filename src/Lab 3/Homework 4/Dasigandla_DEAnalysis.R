# Question 1 & 2: DE Analysis with Simulated Data (No GEO download)
library(limma)
library(edgeR)

# Simulate RNA-seq count data: 1000 genes x 9 samples
set.seed(42)
counts <- matrix(rnbinom(1000*9, mu=10, size=1), ncol=9)
rownames(counts) <- paste0("Gene", 1:1000)
colnames(counts) <- paste0("Sample", 1:9)

# Sample info
group <- factor(c("LP", "ML", "Basal", "Basal", "ML", "Basal", "LP", "ML", "LP"))
lane <- factor(rep(c("L004", "L006", "L008"), c(3,4,2)))

# Create DGEList
x <- DGEList(counts=counts)
x$samples$group <- group
x$samples$lane <- lane

# Filter lowly expressed genes
keep <- filterByExpr(x, group=group)
x <- x[keep, , keep.lib.sizes=FALSE]

# Normalize
x <- calcNormFactors(x)

# Design matrix
design <- model.matrix(~0 + group + lane)
colnames(design) <- gsub("group", "", colnames(design))

# Contrasts
contr.matrix <- makeContrasts(
  Basal_vs_LP = Basal - LP,
  Basal_vs_ML = Basal - ML,
  LP_vs_ML = LP - ML,
  levels=design
)

### --------------------------------
### Question 1: limma + voom
### --------------------------------
v <- voom(x, design)
fit <- lmFit(v, design)
fit2 <- contrasts.fit(fit, contr.matrix)
fit2 <- eBayes(fit2)

# Top DE genes
top1 <- topTable(fit2, coef="Basal_vs_LP", adjust="BH", number=10)
top2 <- topTable(fit2, coef="Basal_vs_ML", adjust="BH", number=10)
top3 <- topTable(fit2, coef="LP_vs_ML", adjust="BH", number=10)

# MA plot
plotMA(fit2, coef="Basal_vs_LP", main="Basal vs LP (limma + voom)")

# Show tables
print("Top 10 DE genes (Basal vs LP):")
print(top1)

### --------------------------------
### Question 2: edgeR GLM
### --------------------------------
y <- estimateDisp(x, design)
fit.glm <- glmFit(y, design)

lrt1 <- glmLRT(fit.glm, contrast=contr.matrix[,"Basal_vs_LP"])
lrt2 <- glmLRT(fit.glm, contrast=contr.matrix[,"Basal_vs_ML"])
lrt3 <- glmLRT(fit.glm, contrast=contr.matrix[,"LP_vs_ML"])

# Count DE genes
cat("DE genes (adj p < 0.05):\n")
print(summary(decideTests(lrt1)))
print(summary(decideTests(lrt2)))
print(summary(decideTests(lrt3)))

# Top genes
print("Top 5 genes (Basal vs LP - edgeR):")
print(topTags(lrt1, n=5))