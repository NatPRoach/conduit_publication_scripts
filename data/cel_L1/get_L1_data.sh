#!/bin/bash

fastq-dump --split-files SRR7530950
fastq-dump --split-files SRR7530951
fastq-dump --split-files SRR7530952

cat SRR7530950_1.fastq SRR7530951_1.fastq SRR7530952_1.fastq > L1_1.fastq
rm SRR7530950_1.fastq SRR7530951_1.fastq SRR7530952_1.fastq
gzip -9 L1_1.fastq

cat SRR7530950_2.fastq SRR7530951_2.fastq SRR7530952_2.fastq > L1_2.fastq
rm SRR7530950_2.fastq SRR7530951_2.fastq SRR7530952_2.fastq
gzip -9 L1_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245464/L1_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245465/L1_rep2.fastq.gz
gunzip L1_rep1.fastq.gz
gunzip L1_rep2.fastq.gz

cat L1_rep1.fastq L1_rep2.fastq > L1_nano.fastq
rm L1_rep1.fastq
rm L1_rep2.fastq

sed 's/U/T/g' L1_nano.fastq > L1_nano.UtoT.fastq
rm L1_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' L1_nano.UtoT.fastq > L1_nano.UtoT.filtered.fastq
rm L1_nano.UtoT.fastq
