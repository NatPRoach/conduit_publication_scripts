#!/bin/bash

SAMPLE="cel_L4"

fastq-dump --split-files SRR7235738
fastq-dump --split-files SRR7235739
fastq-dump --split-files SRR7235740

cat SRR7235738_1.fastq SRR7235739_1.fastq SRR7235740_1.fastq > ${SAMPLE}_1.fastq
rm SRR7235738_1.fastq SRR7235739_1.fastq SRR7235740_1.fastq
gzip -9 ${SAMPLE}_1.fastq

cat SRR7235738_2.fastq SRR7235739_2.fastq SRR7235740_2.fastq > ${SAMPLE}_2.fastq
rm SRR7235738_2.fastq SRR7235739_2.fastq SRR7235740_2.fastq
gzip -9 ${SAMPLE}_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245470/L4_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245471/L4_rep2.fastq.gz
gunzip L4_rep1.fastq.gz
gunzip L4_rep2.fastq.gz

cat L4_rep1.fastq L4_rep2.fastq > ${SAMPLE}_nano.fastq
rm L4_rep1.fastq
rm L4_rep2.fastq

sed 's/U/T/g' ${SAMPLE}_nano.fastq > ${SAMPLE}_nano.UtoT.fastq
rm ${SAMPLE}_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' ${SAMPLE}_nano.UtoT.fastq > ${SAMPLE}_nano.UtoT.filtered.fastq
rm ${SAMPLE}_nano.UtoT.fastq
