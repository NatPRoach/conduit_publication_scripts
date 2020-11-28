#!/bin/bash

fastq-dump --split-files SRR7235738
fastq-dump --split-files SRR7235739
fastq-dump --split-files SRR7235740

cat SRR7235738_1.fastq SRR7235739_1.fastq SRR7235740_1.fastq > L4_1.fastq
rm SRR7235738_1.fastq SRR7235739_1.fastq SRR7235740_1.fastq
gzip -9 L4_1.fastq

cat SRR7235738_2.fastq SRR7235739_2.fastq SRR7235740_2.fastq > L4_2.fastq
rm SRR7235738_2.fastq SRR7235739_2.fastq SRR7235740_2.fastq
gzip -9 L4_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245470/L4_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245471/L4_rep2.fastq.gz
gunzip L4_rep1.fastq.gz
gunzip L4_rep2.fastq.gz

cat L4_rep1.fastq L4_rep2.fastq > L4_nano.fastq
rm L4_rep1.fastq
rm L4_rep2.fastq

sed 's/U/T/g' L4_nano.fastq > L4_nano.UtoT.fastq
rm L4_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' L4_nano.UtoT.fastq > L4_nano.UtoT.filtered.fastq
rm L4_nano.UtoT.fastq
