library(dada2)
library(dplyr)
library(tibble)

st <- readRDS("/work/jal138/Helene_sampling/RDS/16S_seq_table_no_chim.rds")
data.frame(seq = getSequences(st)) %>%
  rowid_to_column(var = "OTU_num") %>%
  mutate(OTU_ID = paste0(">OTU_", OTU_num)) %>%
  dplyr::select(OTU_ID, seq) %>%
  write.table("../16S/16S_rep-seqs.fasta", sep = "\n",
              quote=F, row.names=F, col.names=F)
colnames(st) <- paste0("OTU_", seq(1,dim(st)[2]))
st %>%
  write.table("../16S/16S_otu-table.txt", quote = F, sep = "\t")
