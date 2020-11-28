#!/bin/bash

fastq-dump --split-files SRR3160428
fastq-dump --split-files SRR3160429
fastq-dump --split-files SRR3160430

cat SRR3160428_1.fastq SRR3160429_1.fastq SRR3160430_1.fastq > GA_1.fastq
rm  SRR3160428_1.fastq SRR3160429_1.fastq SRR3160430_1.fastq
gzip --keep -9 GA_1.fastq

cat SRR3160428_2.fastq SRR3160429_2.fastq SRR3160430_2.fastq > GA_2.fastq
rm  SRR3160428_2.fastq SRR3160429_2.fastq SRR3160430_2.fastq
gzip --keep -9 GA_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245474/adult_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245475/adult_rep2.fastq.gz
gunzip adult_rep1.fastq.gz
gunzip adult_rep2.fastq.gz

cat adult_rep1.fastq adult_rep2.fastq > GA_nano.fastq
rm adult_rep1.fastq
rm adult_rep2.fastq

sed 's/U/T/g' GA_nano.fastq > GA_nano.UtoT.fastq
rm GA_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' GA_nano.UtoT.fastq > GA_nano.UtoT.filtered.fastq
rm GA_nano.UtoT.fastq
