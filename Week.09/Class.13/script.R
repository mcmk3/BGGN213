
# Read file

blast <- read.table("mm-second.x.zebrafish.tsv", header = FALSE)

colnames(blast) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")

# Load packages
library("ggplot2")

# Plot a histogram

ggplot(blast, aes(bitscore)) +
  geom_histogram()


# Plot bitscore against pident
ggplot(blast, aes(pident, bitscore)) + geom_point(alpha=0.1) 

ggplot(blast, aes((blast$pident * (blast$qend - blast$qstart)), bitscore)) + geom_point(alpha=0.1) + geom_smooth()
