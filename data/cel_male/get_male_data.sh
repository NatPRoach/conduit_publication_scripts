#!/bin/bash

fastq-dump SRR1056307
fastq-dump SRR1056308
fastq-dump SRR1056309
fastq-dump SRR1056310
fastq-dump SRR1056311
fastq-dump SRR1056312
fastq-dump SRR1056313
fastq-dump SRR1056314

cat SRR1056307.fastq SRR1056308.fastq SRR1056309.fastq SRR1056310.fastq SRR1056311.fastq SRR1056312.fastq SRR1056313.fastq SRR1056314.fastq > male.fastq
rm SRR1056307.fastq SRR1056308.fastq SRR1056309.fastq SRR1056310.fastq SRR1056311.fastq SRR1056312.fastq SRR1056313.fastq SRR1056314.fastq
gzip -9 male.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245476/male_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245477/male_rep2.fastq.gz
gunzip male_rep1.fastq.gz
gunzip male_rep2.fastq.gz

cat male_rep1.fastq male_rep2.fastq > male_nano.fastq
rm male_rep1.fastq
rm male_rep2.fastq

sed 's/U/T/g' male_nano.fastq > male_nano.UtoT.fastq
rm male_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' male_nano.UtoT.fastq > male_nano.UtoT.filtered.fastq
rm male_nano.UtoT.fastq
