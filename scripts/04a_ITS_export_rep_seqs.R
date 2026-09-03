library(dada2)
library(dplyr)
library(tibble)

dd1 <- readRDS("../ITS/ITS_dd1.rds")
st1 <- makeSequenceTable(dd1)
data.frame(seq = getSequences(st1)) %>%
  rowid_to_column(var = "OTU_num") %>%
  mutate(OTU_ID = paste0(">OTU_", OTU_num)) %>%
  dplyr::select(OTU_ID, seq) %>%
  write.table("../ITS/ITS_rep-seqs.fasta", sep = "\n",
              quote=F, row.names=F, col.names=F)
colnames(st1) <- paste0("OTU_", seq(1,dim(st1)[2]))
rownames(st1) <- str_replace(str_extract(rownames(st1),
                                         "Fwd_[0-9]{2}.*_Rev_[0-9]{2}"),
                             "Kinnex16S", "KinnexITS")
write.table("../ITS/ITS_otu-table.txt", quote = F, sep = "\t")
