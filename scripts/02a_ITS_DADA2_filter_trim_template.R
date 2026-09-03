library(dada2)
library(Biostrings)
library(ShortRead)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(phyloseq)

path1 <- "/work/jal138/Helene_sampling/demultiplexed_ITS/" # CHANGE ME to location of the First Replicate fastq files
fns1 <- list.files(path1, pattern=".*Fwd_XXX.*fastq.gz", full.names=TRUE)
finished1 <- list.files(file.path(path1, "noprimers", "filtered/"), pattern=".*Fwd_XXX.*fastq.gz", full.names=TRUE)
to_do1 <- setdiff(basename(fns1), basename(finished1))
print(to_do1)
rc <- dada2:::rc
theme_set(theme_bw())
nops1 <- file.path(path1, "noprimers", basename(to_do1))
filts1 <- file.path(path1, "noprimers", "filtered", basename(to_do1))
track1 <- filterAndTrim(nops1, filts1, minQ=3, minLen=250, maxLen=1200, maxN=0, rm.phix=FALSE, maxEE=3, multithread=TRUE)
# drp1 <- derepFastq(filts1, verbose=TRUE)
