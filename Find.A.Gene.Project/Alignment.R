#Alignment script

#set-up
library(bio3d)
library(ggplot2)

aln.L <- read.fasta("gene.project.multiple.seqs.aln.long.fa")
aln.S <- read.fasta("gene.project.multiple.seqs.aln.short.fa")

#choose which file to use
aln <- aln.S


#Conservation
##score positional conservation
sim <- conserv(aln)

##plot conservation along the sequence
plot(sim, typ="h", xlab="Alignment position", ylab="Conservation score")

#improve the previous plot
gg_sim <- as.data.frame(cbind(1:length(sim), sim))
colnames(gg_sim) <- c("Alignment_position", "Conservation_Score")

ggplot(gg_sim, aes(Alignment_position, Conservation_Score, col = Conservation_Score)) +
  geom_col(show.legend = FALSE) +
  labs(title = "Conservation across the alignment", x = "Alignment position", y = "Conservation Score")

##order the sim vector of conservation 
inds <- order(sim, decreasing=TRUE)
head(sim[inds])

##make a data frame of position in alignment, aa and conservation score
positions <- data.frame(pos=1:length(sim), aa=aln$ali[1,], score=sim)
head(positions)

##order the positions in the data frame by conservation
head(positions[inds,] )

##convert one letter code to three letter code
aa123(positions[inds,]$aa)[1:3]



#Heatmap
##set-up
library(pheatmap)

##??
ide <- seqidentity(aln)
pheatmap((1-ide))
pheatmap(ide)





