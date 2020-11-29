#!/bin/bash

SAMPLE="smaller_NA12878"

fastq-dump --split-files SRR1153470

mv SRR1153470_1.fastq ${SAMPLE}_1.fastq
mv SRR1153470_2.fastq ${SAMPLE}_2.fastq

wget https://s3.amazonaws.com/nanopore-human-wgs/rna/fastq/Bham_Run1_20171009_DirectRNA.pass.dedup.fastq

sed 's/U/T/g' Bham_Run1_20171009_DirectRNA.pass.dedup.fastq > ${SAMPLE}.UtoT.fastq
rm Bham_Run1_20171009_DirectRNA.pass.dedup.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' ${SAMPLE}.UtoT.fastq > ${SAMPLE}.UtoT.filtered.fastq
rm ${SAMPLE}.UtoT.fastq
