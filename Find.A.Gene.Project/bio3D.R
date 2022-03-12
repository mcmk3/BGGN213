
# Set-up
library("bio3d")
library("ggplot2")
library("ggrepel")
library("msa")
library("devtools")
library("Grantlab/bio3d-view")

# Load sequence of POI
seqL <- read.fasta("long.ORF.fa")
seqS <- read.fasta("short.ORF.fa")

#Choose which sequence to use
seq <- seqL

# Blast search
blast <- blast.pdb(seq, database = "pdb")


# Plot summary statistics of results
hits <- plot(blast)

# Print the IDs of the hits above the threshold
hits$pdb.id

# Download related PDB files
files <- get.pdb(hits$pdb.id, path="pdbs", split=TRUE, gzip=TRUE)

# Align related PDBs
pdbs <- pdbaln(files, fit = TRUE, exefile="msa")

# Vector containing PDB codes for figure axis
ids <- basename.pdb(pdbs$id)

# Annotate hits for more information on the hits
anno <- pdb.annotate(ids)
unique(anno$source)
anno


# Draw schematic alignment
plot(pdbs, labels=ids)

###### Not yet on rmd

# Set up
library(bio3d.view)
library(rgl)

# Plot
view.pdbs(pdbs)


# Conservation
##score positional conservation
sim <- conserv(pdbs$ali)

##plot conservation along the sequence
plot(sim, typ="h", xlab="Alignment position", ylab="Conservation score")

#improve the previous plot
gg_sim <- as.data.frame(cbind(1:length(sim), sim))
colnames(gg_sim) <- c("Alignment_position", "Conservation_Score")

ggplot(gg_sim, aes(Alignment_position, Conservation_Score, col = Conservation_Score)) +
  geom_col(show.legend = FALSE) +
  labs(title = "Conservation across the PDB hits", x = "Alignment position", y = "Conservation Score")

##order the sim vector of conservation 
inds <- order(sim, decreasing=TRUE)
head(sim[inds])

##make a data frame of position in alignment, aa and conservation score
positions <- data.frame(pos=1:length(sim), aa=pdbs$ali[1,], score=sim)
head(positions)



##order the positions in the data frame by conservation
head(positions[inds,] )

##convert one letter code to three letter code
aa123(positions[inds,]$aa)[1:3]

# Get positiosn object ready to write out to csv
#positions$t <- aa123(positions$aa)
#head(positions)
#positions$t.aa.pos <- paste(positions$t, positions$pos, sep = "")

pos1 <- cbind(positions, t(pdbs$resid), t(pdbs$resno))
head(pos1)

colnames(pos1) <- c("MSA.pos", "MSA.aa", "MSA.score", "MSA.three.letter.aa", "MSA.three.letter.aa.pos", "7BMH_A.aa", "5AWZ_A.aa", "6GYH_A.aa", "7BMH_A.pos", "5AWZ_A.pos", "6GYH_A.pos")
head(pos1)

pos1$`6GYH_A.aa.pos` <- paste(pos1$`6GYH_A.aa`, pos1$`6GYH_A.pos`, sep = "")
head(pos1)

write.csv(pos1, file = "pdb.hits.conservation.csv")

#Heatmap
##set-up
library(pheatmap)

##??
ide <- seqidentity(pdbs$ali)
pheatmap((1-ide))
pheatmap(ide)



