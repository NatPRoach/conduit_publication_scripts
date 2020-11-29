#!/bin/bash

SAMPLE="cel_male"

fastq-dump SRR1056307
fastq-dump SRR1056308
fastq-dump SRR1056309
fastq-dump SRR1056310
fastq-dump SRR1056311
fastq-dump SRR1056312
fastq-dump SRR1056313
fastq-dump SRR1056314

cat SRR1056307.fastq SRR1056308.fastq SRR1056309.fastq SRR1056310.fastq SRR1056311.fastq SRR1056312.fastq SRR1056313.fastq SRR1056314.fastq > ${SAMPLE}.fastq
rm SRR1056307.fastq SRR1056308.fastq SRR1056309.fastq SRR1056310.fastq SRR1056311.fastq SRR1056312.fastq SRR1056313.fastq SRR1056314.fastq
gzip -9 ${SAMPLE}.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245476/male_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245477/male_rep2.fastq.gz
gunzip male_rep1.fastq.gz
gunzip male_rep2.fastq.gz

cat male_rep1.fastq male_rep2.fastq > ${SAMPLE}_nano.fastq
rm male_rep1.fastq
rm male_rep2.fastq

sed 's/U/T/g' ${SAMPLE}_nano.fastq > ${SAMPLE}_nano.UtoT.fastq
rm ${SAMPLE}_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' ${SAMPLE}_nano.UtoT.fastq > ${SAMPLE}_nano.UtoT.filtered.fastq
rm ${SAMPLE}_nano.UtoT.fastq
