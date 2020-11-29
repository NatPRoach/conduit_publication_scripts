#!/bin/bash

SAMPLE="cel_L1"

fastq-dump --split-files SRR7530950
fastq-dump --split-files SRR7530951
fastq-dump --split-files SRR7530952

cat SRR7530950_1.fastq SRR7530951_1.fastq SRR7530952_1.fastq > ${SAMPLE}_1.fastq
rm SRR7530950_1.fastq SRR7530951_1.fastq SRR7530952_1.fastq
gzip -9 ${SAMPLE}_1.fastq

cat SRR7530950_2.fastq SRR7530951_2.fastq SRR7530952_2.fastq > ${SAMPLE}_2.fastq
rm SRR7530950_2.fastq SRR7530951_2.fastq SRR7530952_2.fastq
gzip -9 ${SAMPLE}_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245464/L1_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245465/L1_rep2.fastq.gz
gunzip L1_rep1.fastq.gz
gunzip L1_rep2.fastq.gz

cat L1_rep1.fastq L1_rep2.fastq > ${SAMPLE}_nano.fastq
rm L1_rep1.fastq
rm L1_rep2.fastq

sed 's/U/T/g' ${SAMPLE}_nano.fastq > ${SAMPLE}_nano.UtoT.fastq
rm ${SAMPLE}_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' ${SAMPLE}_nano.UtoT.fastq > ${SAMPLE}_nano.UtoT.filtered.fastq
rm ${SAMPLE}_nano.UtoT.fastq
