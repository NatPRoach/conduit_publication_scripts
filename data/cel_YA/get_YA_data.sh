#!/bin/bash

SAMPLE="cel_YA"

fastq-dump --split-files SRR10574840
fastq-dump --split-files SRR10574841
fastq-dump --split-files SRR10574842

cat SRR10574840_1.fastq SRR10574841_1.fastq SRR10574842_1.fastq > ${SAMPLE}_1.fastq
rm  SRR10574840_1.fastq SRR10574841_1.fastq SRR10574842_1.fastq
gzip --keep -9 ${SAMPLE}_1.fastq

cat SRR10574840_2.fastq SRR10574841_2.fastq SRR10574842_2.fastq > ${SAMPLE}_2.fastq
rm  SRR10574840_2.fastq SRR10574841_2.fastq SRR10574842_2.fastq
gzip --keep -9 ${SAMPLE}_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245472/young_adult_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245473/young_adult_rep2.fastq.gz
gunzip young_adult_rep1.fastq.gz
gunzip young_adult_rep2.fastq.gz

cat young_adult_rep1.fastq young_adult_rep2.fastq > ${SAMPLE}_nano.fastq
rm young_adult_rep1.fastq
rm young_adult_rep2.fastq

sed 's/U/T/g' ${SAMPLE}_nano.fastq > ${SAMPLE}_nano.UtoT.fastq
rm ${SAMPLE}_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' ${SAMPLE}_nano.UtoT.fastq > ${SAMPLE}_nano.UtoT.filtered.fastq
rm ${SAMPLE}_nano.UtoT.fastq
