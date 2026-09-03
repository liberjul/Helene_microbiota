library(dada2)
library(Biostrings)
library(ShortRead)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(phyloseq)

path1 <- "/work/jal138/Helene_sampling/demultiplexed_ITS/" # CHANGE ME to location of the First Replicate fastq files
path.out<- "../ITS/Figures/"
path.rds <- "../ITS/RDS/"
fns1 <- list.files(path1, pattern=".*Fwd_XXX.*fastq.gz", full.names=TRUE)
print(fns1)
ITS1catta <- "ACCWGCGGARGGATCATTA"
ITS4ngsUni <- "CCTSCSCTTANTDATATGC"
rc <- dada2:::rc
finished1 <- list.files(file.path(path1, "noprimers/"), pattern=".*Fwd_XXX.*fastq.gz", full.names=TRUE)
to_do1 <- setdiff(basename(fns1), basename(finished1))
print(to_do1)
nops1 <- file.path(path1, "noprimers", basename(to_do1))
prim1 <- removePrimers(file.path(path1, basename(to_do1)), nops1, primer.fwd=ITS1catta, primer.rev=dada2:::rc(ITS4ngsUni), orient=TRUE, verbose = TRUE)