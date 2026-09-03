library(dada2)
library(Biostrings)
library(ShortRead)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(phyloseq)

path1 <- "/work/jal138/Helene_sampling/demultiplexed_16S/" # CHANGE ME to location of the First Replicate fastq files
# path2 <- "~/Desktop/LRAS/Data/Fecal2" # CHANGE ME to location of the Second Replicate fastq files
path.out<- "../16S/Figures/"
path.rds <- "../16S/RDS/"
fns1 <- list.files(path1, pattern="fastq.gz", full.names=TRUE)
# fns2 <- list.files(path2, pattern="fastq.gz", full.names=TRUE)
F27 <- "AGRGTTYGATYMTGGCTCAG"
R1492 <- "RGYTACCTTGTTACGACTT"
rc <- dada2:::rc
theme_set(theme_bw())

nops1 <- file.path(path1, "noprimers", basename(fns1))
prim1 <- removePrimers(fns1, nops1, primer.fwd=F27, primer.rev=dada2:::rc(R1492), orient=TRUE, verbose = TRUE)

lens.fn <- lapply(nops1, function(fn) nchar(getSequences(fn)))
lens <- do.call(c, lens.fn)
data.frame(length = lens) %>%
  ggplot(aes(x = length)) +
  geom_histogram() -> g
ggsave(file.path(path.out, "read_lengths_post_filt.pdf"), g, width = 6, height = 6)

filts1 <- file.path(path1, "noprimers", "filtered", basename(fns1))
track1 <- filterAndTrim(nops1, filts1, minQ=3, minLen=1000, maxLen=1600, maxN=0, rm.phix=FALSE, maxEE=2, multithread=TRUE)
drp1 <- derepFastq(filts1, verbose=TRUE)
err1 <- learnErrors(drp1, errorEstimationFunction=PacBioErrfun, BAND_SIZE=32, multithread=TRUE)
saveRDS(err1, file.path(path.rds, "Fecal_err1.rds"))

pdf(file.path(path.out, "seq_errors_plot.pdf"))
plotErrors(err1)
dev.off()
