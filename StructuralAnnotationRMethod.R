
#Load libraries
library(seqinr)
library(Biostrings)
library(rentrez)
library(compbio4all)
library(ggplot2)

#Vec of known CRP sequences
seqs <- c('ATTCGTGATAGCTGTCGTAAAG', 'TTTTGTTACCTGCCTCTAACTT', 'AAGTGTGACGCCGTGCAAATAA', 'TGCCGTGATTATAGACACTTTT', 
              'ATTTGCGATGCGTCGCGCATTT', 'TAATGAGATTCAGATCACATAT', 'TAATGTGACGTCCTTTGCATAC', 'GAAGGCGACCTGGGTCATGCTG', 
              'AGGTGTTAAATTGATCACGTTT', 'CGATGCGAGGCGGATCGAAAAA', 'AAATTCAATATTCATCACACTT', 'AGATGTGAGCCAGCTCACCATA',
              'AGATGTGATTAGATTATTATTC', 'AATTGTGATGTGTATCGAAGTG', 'TTATTTGAACCAGATCGCATTA', 'AAATGTAAGCTGTGCCACGTTT', 
              'AAGTGTGACATGGAATAAATTA', 'TTGTTTGATTTCGCGCATATTC', 'AAACGTGATTTCATGCGTCATT', 'ATGTGTGCGGCAATTCACATTT')

# -> Code utilized from Dr. Mehta (THANK YOU!!!) - For each position, count the number of A, C, G, and T 
counts <- c()
for(i in 1:22){
  all_char <- sapply(seqs, function(x){return(s2c(x)[i])})
  names(all_char) <- NULL
  base_table <- table(all_char)[c('A', 'C', 'G', 'T')]
  names(base_table) <- c('A', 'C', 'G', 'T')
  base_table[which(is.na(base_table))] <- 0
  counts <- rbind(counts, base_table)
}
rownames(counts) <- NULL
counts

# Turn counts into fractions
freqs <- apply(counts, 1, function(x){
  return((x+0.25)/(sum(x)+1)) # For Q14
})
freqs

#Condense all seqs into a single line, then use strsplit to get counts
baseCounts <-table(strsplit(paste(seqs, collapse = ""), "")[[1]])
baseCounts

#Get total number of bases
total <- sum(baseCounts)
total

#Calc freq of each base
baseFreq <- baseCounts / total
baseFreq

#TY REPLICATE...otherwise gives out of bounds error
baseFreqMatrix <- replicate(22,baseFreq)
baseFreqMatrix

#Calculate PSSM
pssm <- log10(freqs/baseFreqMatrix)
pssm

#Code adapted from Dr. Mehta (THANK YOU!!!) - Calculate score for seq1
test_sequence <- 'ATGTGTGCGGCAATTCACATTT'
# split sequence into chunks
chunks1 <- c()
chunk_size <- 22
for(i in 1:(nchar(test_sequence)-chunk_size+1)){
  chunk1 <- substr(test_sequence, i, i+chunk_size-1)
  chunks1 <- rbind(chunks1, c(i, chunk1))
}
chunks1 <- data.frame(chunks1)
names(chunks1) <- c('pos', 'seq')
#score each chunk
for(i in 1:dim(chunks1)[1]){
  chars <- s2c(chunks1$seq[i])
  which_base <- match(chars, rownames(pssm))
  which_pos <- 1:chunk_size
  indices <- cbind(which_pos, which_base)
  logodds <- apply(indices, 1, function(x){
    return(pssm[x[2], x[1]])
  })
  score <- sum(logodds)
  chunks1$score[i] <- score
}
chunks1$pos <- as.numeric(chunks1$pos)
chunks1

#Calculate score for seq2
test_sequence <- 'AACTGTCATACTGCGAATTCAG'
# split sequence into chunks
chunks2 <- c()
chunk_size <- 22
for(i in 1:(nchar(test_sequence)-chunk_size+1)){
  chunk2 <- substr(test_sequence, i, i+chunk_size-1)
  chunks2 <- rbind(chunks2, c(i, chunk2))
}
chunks2 <- data.frame(chunks2)
names(chunks2) <- c('pos', 'seq')
#score each chunk
for(i in 1:dim(chunks2)[1]){
  chars <- s2c(chunks2$seq[i])
  which_base <- match(chars, rownames(pssm))
  which_pos <- 1:chunk_size
  indices <- cbind(which_pos, which_base)
  logodds <- apply(indices, 1, function(x){
    return(pssm[x[2], x[1]])
  })
  score <- sum(logodds)
  chunks2$score[i] <- score
}
chunks2$pos <- as.numeric(chunks2$pos)
chunks2

#Calculate score for seq3
test_sequence <- 'TTTTGCCATGCGACGCGTTTTT'
# split sequence into chunks
chunks3 <- c()
chunk_size <- 22
for(i in 1:(nchar(test_sequence)-chunk_size+1)){
  chunk3 <- substr(test_sequence, i, i+chunk_size-1)
  chunks3 <- rbind(chunks3, c(i, chunk3))
}
chunks3 <- data.frame(chunks3)
names(chunks3) <- c('pos', 'seq')
#score each chunk
for(i in 1:dim(chunks3)[1]){
  chars <- s2c(chunks3$seq[i])
  which_base <- match(chars, rownames(pssm))
  which_pos <- 1:chunk_size
  indices <- cbind(which_pos, which_base)
  logodds <- apply(indices, 1, function(x){
    return(pssm[x[2], x[1]])
  })
  score <- sum(logodds)
  chunks3$score[i] <- score
}
chunks3$pos <- as.numeric(chunks3$pos)
chunks3
chunks3$score

#Plot each sequence against their scores
data <- c("Seq1", "Seq2", "Seq3")
score <- c(chunks1$score, chunks2$score, chunks3$score)
ggplot() + geom_point(mapping = aes(x = data, y = score)) + xlab("Sequences") + ylab("Score")

