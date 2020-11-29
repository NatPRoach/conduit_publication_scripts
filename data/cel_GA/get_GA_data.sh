#!/bin/bash

SAMPLE="cel_GA"

fastq-dump --split-files SRR3160428
fastq-dump --split-files SRR3160429
fastq-dump --split-files SRR3160430

cat SRR3160428_1.fastq SRR3160429_1.fastq SRR3160430_1.fastq > ${SAMPLE}_1.fastq
rm  SRR3160428_1.fastq SRR3160429_1.fastq SRR3160430_1.fastq
gzip --keep -9 ${SAMPLE}_1.fastq

cat SRR3160428_2.fastq SRR3160429_2.fastq SRR3160430_2.fastq > ${SAMPLE}_2.fastq
rm  SRR3160428_2.fastq SRR3160429_2.fastq SRR3160430_2.fastq
gzip --keep -9 ${SAMPLE}_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245474/adult_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245475/adult_rep2.fastq.gz
gunzip adult_rep1.fastq.gz
gunzip adult_rep2.fastq.gz

cat adult_rep1.fastq adult_rep2.fastq > ${SAMPLE}_nano.fastq
rm adult_rep1.fastq
rm adult_rep2.fastq

sed 's/U/T/g' ${SAMPLE}_nano.fastq > ${SAMPLE}_nano.UtoT.fastq
rm ${SAMPLE}_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' ${SAMPLE}_nano.UtoT.fastq > ${SAMPLE}_nano.UtoT.filtered.fastq
rm ${SAMPLE}_nano.UtoT.fastq
