library(dada2)
library(Biostrings)
library(ShortRead)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(phyloseq)

path1 <- "/work/jal138/Helene_sampling/demultiplexed_16S/noprimers/filtered/" # CHANGE ME to location of the First Replicate fastq files
fns1 <- list.files(path1, pattern=".*fastq.gz", full.names=TRUE)
theme_set(theme_bw())
path.out<- "~/Helene_sampling/figs/"
path.rds <- "/work/jal138/Helene_sampling/RDS/"

filts1 <- file.path(path1, basename(fns1))
drp1 <- derepFastq(filts1, verbose=TRUE)
err1 <- learnErrors(drp1, errorEstimationFunction=PacBioErrfun, BAND_SIZE=32, multithread=TRUE)
saveRDS(err1, file.path(path.rds, "16S_err1.rds"))

pdf(file.path(path.out, "16S_seq_errors_plot.pdf"))
plotErrors(err1)
dev.off()

dd1 <- dada(drp1, err=err1, BAND_SIZE=32, multithread=TRUE)
saveRDS(dd1, file.path(path.rds, "dd1.rds"))