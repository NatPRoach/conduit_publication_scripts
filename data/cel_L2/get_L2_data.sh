#!/bin/bash

fastq-dump --split-files SRR8882159
fastq-dump --split-files SRR8882160
fastq-dump --split-files SRR8882161
fastq-dump --split-files SRR8882162

cat SRR8882159_1.fastq SRR8882160_1.fastq SRR8882161_1.fastq SRR8882162_1.fastq > L2_1.fastq
rm  SRR8882159_1.fastq SRR8882160_1.fastq SRR8882161_1.fastq SRR8882162_1.fastq
gzip --keep -9 L2_1.fastq

cat SRR8882159_2.fastq SRR8882160_2.fastq SRR8882161_2.fastq SRR8882162_2.fastq > L2_2.fastq
rm  SRR8882159_2.fastq SRR8882160_2.fastq SRR8882161_2.fastq SRR8882162_2.fastq
gzip --keep -9 L2_2.fastq


wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245466/L2_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245467/L2_rep2.fastq.gz
gunzip L2_rep1.fastq.gz
gunzip L2_rep2.fastq.gz

cat L2_rep1.fastq L2_rep2.fastq > L2_nano.fastq
rm L2_rep1.fastq
rm L2_rep2.fastq

sed 's/U/T/g' L2_nano.fastq > L2_nano.UtoT.fastq
rm L2_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' L2_nano.UtoT.fastq > L2_nano.UtoT.filtered.fastq
rm L2_nano.UtoT.fastq
