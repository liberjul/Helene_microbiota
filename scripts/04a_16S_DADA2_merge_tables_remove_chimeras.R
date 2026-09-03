library(dada2)
library(stringr)

path.rds <- "/work/jal138/Helene_sampling/RDS"

st_list <- list()
for (i in 1:11){
  fp <- file.path(path.rds,
                  paste0("16S_dd1_Fwd_",
                         str_pad(i, 2, side="left", pad = "0"),
                  ".rds"))
  print(fp)
  dd_temp <- readRDS(fp)
  st_list[[i]] <- makeSequenceTable(dd_temp)
}
st.all <- mergeSequenceTables(st_list[[1]],
                              st_list[[2]],
                              st_list[[3]],
                              st_list[[4]],
                              st_list[[5]],
                              st_list[[6]],
                              st_list[[7]],
                              st_list[[8]],
                              st_list[[9]],
                              st_list[[10]],
                              st_list[[11]])
saveRDS(st.all, file.path(path.rds, "16S_merged_table.rds"))

seqtab <- removeBimeraDenovo(st.all, method = "consensus", multithread = T)
saveRDS(seqtab, file.path(path.rds, "16S_seq_table_no_chim.rds"))


