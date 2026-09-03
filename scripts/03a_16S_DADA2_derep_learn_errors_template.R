library(dada2)
library(Biostrings)
library(ShortRead)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(phyloseq)

path.rds <- "/work/jal138/Helene_sampling/RDS/"

err1 <- readRDS(file.path(path.rds, "16S_err1.rds"))
drp1 <- readRDS(file.path(path.rds, "16S_drp1_Fwd_XXX.rds"))
dd1 <- dada(drp1, err=err1, BAND_SIZE=32, multithread=TRUE)
saveRDS(dd1, file.path(path.rds, "16S_dd1_Fwd_XXX.rds"))

