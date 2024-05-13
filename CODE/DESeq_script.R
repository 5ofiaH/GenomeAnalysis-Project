BiocManager::install("DESeq2")
BiocManager::install("genefilter")
install.packages("readxl")

# Load libraries
library(readxl)
library(DESeq2)
library(tidyverse)
library(pheatmap)
library(gplots)
library(RColorBrewer)
library(genefilter)

# Read in metadata
MetaData <- read_excel("metadata.xls")

# Read in count files
count_files <- c("SRR6040092_Aligned.sortedByCoord.out_counts.txt",
                 "SRR6040093_Aligned.sortedByCoord.out_counts.txt", 
                 "SRR6040094_Aligned.sortedByCoord.out_counts.txt", 
                 "SRR6040096_Aligned.sortedByCoord.out_counts.txt",
                 "SRR6040097_Aligned.sortedByCoord.out_counts.txt", 
                 "SRR6156066_Aligned.sortedByCoord.out_counts.txt", 
                 "SRR6156067_Aligned.sortedByCoord.out_counts.txt", 
                 "SRR6156069_Aligned.sortedByCoord.out_counts.txt")


# Create sampleTable
sampleNames <- c("SRR6040092_Leaf", "SRR6040093_Root", "SRR6040094_Aril", "SRR6040096_Stem", 
                 "SRR6040097_Aril", "SRR6156066_Aril", "SRR6156067_Aril", "SRR6156069_Aril")

sampleTable <- matrix(ncol = 8, nrow = 4069)
colnames(sampleTable) <- sampleNames
rownames_data <- read.table(count_files[1], header = FALSE, colClasses = "character")[, 1]
rownames(sampleTable) <- rownames_data

for (i in seq_along(count_files)) {
  # Read the counts from the second column of each count file
  counts <- read.table(count_files[i], header = FALSE)[, 2]
  # Assign the counts to the corresponding column in the sampleTable matrix
  sampleTable[, i] <- counts
}
rownames(sampleTable)[4060] <- "HSP70"
rownames(sampleTable)[970] <- "IQ,Myosin_head"
rownames(sampleTable)[2181] <- "Myb_DNA-binding"
rownames(sampleTable)[51] <- "Cys_Met_Meta_PP"
rownames(sampleTable)[1747] <- "Arm,U-box"
rownames(sampleTable)[3425] <- "SSF"
rownames(sampleTable)[2587] <- "Exostosin"
rownames(sampleTable)[1341] <- "p450"
rownames(sampleTable)[2988] <- "RRM_1"
rownames(sampleTable)[4022] <- "RNA_pol_Rpb1_1"
rownames(sampleTable)[1624] <- "ABC_membrane"
rownames(sampleTable)[1071] <- "UDPGT"
rownames(sampleTable)[2375] <- "Pyr_redox_2"
rownames(sampleTable)[3969] <- "Pyr_redox_2"
rownames(sampleTable)[2378] <- "Aminotran_1_2" #1-aminocyclopropane-1-carboxylate g3138


# Create DESeq object 
ddsHTSeq_tissue <- DESeqDataSetFromMatrix(countData = sampleTable, colData = MetaData, design = ~ tissue)

ddsHT_seq_cultivar <- DESeqDataSetFromMatrix(countData = sampleTable, colData = MetaData, design = ~ Cultivar)

# Perform DESeq2
dds <- DESeq(ddsHT_seq_cultivar)
results <- results(dds)
normalized_counts <- counts(dds, normalized = TRUE)

# Perform PCA
rld <- rlog(dds)
plotPCA(rld, intgroup = c("Cultivar","tissue"))

# Heatmap

# Extract the row names (gene names) for the top 10 differentially expressed genes
top_10_DE_genes <- head(row.names(results[order(results$padj), ]), 10)

# Extract the row names (gene names) for the top 10 differentially expressed genes
#top_10_DE_genes <- head(row.names(results[order(results$padj), ]), 10)

# Subset rlog data to include only the top 10 differentially expressed genes
#rlog_data_top_10_DE <- rlog_data[top_10_DE_genes, ]

rlog_data_top_10_DE <- assay(rld)[top_10_DE_genes, ]

# Set row names to the data matrix
rownames(rlog_data_top_10_DE) <- top_10_DE_genes

# Extract the tissue types and cultivar from the metadata
tissue_types <- MetaData$tissue
cultivar <- MetaData$Cultivar

# Create column names combining sample names, tissue types, and cultivar
col_names_with_tissue <- paste(colnames(rlog_data_top_10_DE), cultivar, sep = " - ")

# Set column names to include both sample names, tissue types, and cultivar
colnames(rlog_data_top_10_DE) <- col_names_with_tissue

# Create heatmap for the top 10 differentially expressed genes
pheatmap(as.matrix(rlog_data_top_10_DE), 
         scale = "row", 
         col = colorRampPalette(rev(brewer.pal(9, "RdBu")))(100),
         main = "Top 10 Differentially Expressed Genes",
         labRow = TRUE,  # Show row labels (gene names)
         labCol = TRUE,  # Show column labels
         fontsize_row = 10,  # Adjust row label font size
         fontsize_col = 10,
         margins = c(5, 15),  # Add space between title and heatmap
         fontsize_title = 20,  # Set the font size of the title to 16
         width = 10,  # Adjust the width of the heatmap
         height = 6,         
         border_color = "black")# Volcano plo


# Volcano plot

# Calculate the log2 fold change and -log10 adjusted p-values
log2_fold_change <- results$log2FoldChange
adjusted_p_values <- -log10(results$padj)

# Remove non-finite values from both vectors
finite_indices <- is.finite(log2_fold_change) & is.finite(adjusted_p_values)
log2_fold_change <- log2_fold_change[finite_indices]
adjusted_p_values <- adjusted_p_values[finite_indices]

# Create a volcano plot
plot(log2_fold_change, adjusted_p_values,
     main = "Volcano Plot for cultivar design",
     xlab = "Log2 Fold Change",
     ylab = "-Log10 Adjusted P-value",
     xlim = c(-max(abs(log2_fold_change)), max(abs(log2_fold_change))),
     ylim = c(0, max(adjusted_p_values)),
     pch = 20,   # Use filled circles as points
     col = ifelse(abs(log2_fold_change) > 1 & results$padj[finite_indices] < 0.05, "darkgreen", "darkgrey"))  # Highlight significant points

# Add a horizontal line at -log10(0.05) to indicate significance threshold
abline(h = -log10(0.05), col = "red", lty = 4)

###______

# Install EnhancedVolcano package if not already installed
install.packages("EnhancedVolcano")

# Load library
library(EnhancedVolcano)

# Create a volcano plot with EnhancedVolcano
# Create a volcano plot with EnhancedVolcano
EnhancedVolcano(results,
                lab = row.names(results),
                x = 'log2FoldChange',
                y = 'padj',
                selectLab = c("HSP70","IQ,Myosin_head","Cys_Met_Meta_PP","Exostosin","SSF","g2354","Arm,U-box","Myb_DNA-binding","p450","RRM_1","Aminotran_1_2"),
                xlab = bquote(~Log[2]~"fold change"),
                labSize = 4,
                labCol = 'black',
                labFace = 'bold',
                boxedLabels = TRUE,
                colAlpha = 4/5,
                legendPosition = 'right',
                legendLabSize = 10,
                legendIconSize = 1.0,
                drawConnectors = TRUE,
                lengthConnectors = unit(0.01, "npc"),   # Adjust connector length
                widthConnectors = 0.5,
                colConnectors = "black",
                typeConnectors = "open",
                endsConnectors = "first",
                col = c("grey30", "forestgreen", "royalblue", "red2"),
                colCustom = NULL,
                colGradient = NULL,
                colGradientBreaks = c(pCutoff, 1),
                colGradientLabels = c("0", "1.0"),
                colGradientLimits = c(0, 1),
                xlim = c(-max(abs(log2_fold_change)), max(abs(log2_fold_change))),
                title = "Enhanced Volcano Plot for cultivar design",
                pCutoff = 0.05,  # Adjust p-value cutoff
                FCcutoff = 1,    # Adjust fold change cutoff
                pointSize = 3)   # Adjust point size



