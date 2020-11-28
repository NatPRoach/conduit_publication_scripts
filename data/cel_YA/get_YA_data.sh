#!/bin/bash

fastq-dump --split-files SRR10574840
fastq-dump --split-files SRR10574841
fastq-dump --split-files SRR10574842

cat SRR10574840_1.fastq SRR10574841_1.fastq SRR10574842_1.fastq > YA_1.fastq
rm  SRR10574840_1.fastq SRR10574841_1.fastq SRR10574842_1.fastq
gzip --keep -9 YA_1.fastq

cat SRR10574840_2.fastq SRR10574841_2.fastq SRR10574842_2.fastq > YA_2.fastq
rm  SRR10574840_2.fastq SRR10574841_2.fastq SRR10574842_2.fastq
gzip --keep -9 YA_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245472/young_adult_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245473/young_adult_rep2.fastq.gz
gunzip young_adult_rep1.fastq.gz
gunzip young_adult_rep2.fastq.gz

cat young_adult_rep1.fastq young_adult_rep2.fastq > YA_nano.fastq
rm young_adult_rep1.fastq
rm young_adult_rep2.fastq

sed 's/U/T/g' YA_nano.fastq > YA_nano.UtoT.fastq
rm YA_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' YA_nano.UtoT.fastq > YA_nano.UtoT.filtered.fastq
rm YA_nano.UtoT.fastq
