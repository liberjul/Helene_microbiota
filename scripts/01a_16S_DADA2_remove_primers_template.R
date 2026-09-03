library(dada2)
library(Biostrings)
library(ShortRead)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(phyloseq)

path1 <- "/work/jal138/Helene_sampling/demultiplexed_16S/" # CHANGE ME to location of the First Replicate fastq files
path.out<- "../16S/Figures/"
path.rds <- "../16S/RDS/"
fns1 <- list.files(path1, pattern=".*Fwd_XXX.*fastq.gz", full.names=TRUE)
F27 <- "AGRGTTYGATYMTGGCTCAG"
R1492 <- "RGYTACCTTGTTACGACTT"
rc <- dada2:::rc
theme_set(theme_bw())
finished1 <- list.files(file.path(path1, "noprimers/"), pattern=".*Fwd_XXX.*fastq.gz", full.names=TRUE)
to_do1 <- setdiff(basename(fns1), basename(finished1))
print(to_do1)
nops1 <- file.path(path1, "noprimers", basename(to_do1))
prim1 <- removePrimers(file.path(path1, basename(to_do1)), nops1, primer.fwd=F27, primer.rev=dada2:::rc(R1492), orient=TRUE, verbose = TRUE)