#!/bin/bash

SAMPLE="cel_L3"

fastq-dump --split-files SRR6799135
fastq-dump --split-files SRR6799153
fastq-dump --split-files SRR6799177
fastq-dump --split-files SRR6799194

cat SRR6799135_1.fastq > L3_1.fastq
cat  SRR6799135_1.fastq SRR6799153_1.fastq SRR6799177_1.fastq SRR6799194_1.fastq > ${SAMPLE}_1.fastq
rm  SRR6799135_1.fastq SRR6799153_1.fastq SRR6799177_1.fastq SRR6799194_1.fastq
gzip --keep -9 ${SAMPLE}_1.fastq

cat SRR6799135_2.fastq > L3_2.fastq
cat SRR6799135_2.fastq SRR6799153_2.fastq SRR6799177_2.fastq SRR6799194_2.fastq > ${SAMPLE}_2.fastq
rm  SRR6799135_2.fastq SRR6799153_2.fastq SRR6799177_2.fastq SRR6799194_2.fastq
gzip --keep -9 ${SAMPLE}_2.fastq

wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245468/L3_rep1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR324/ERR3245469/L3_rep2.fastq.gz
gunzip L3_rep1.fastq.gz
gunzip L3_rep2.fastq.gz

cat L3_rep1.fastq L3_rep2.fastq > ${SAMPLE}_nano.fastq
rm L3_rep1.fastq
rm L3_rep2.fastq

sed 's/U/T/g' ${SAMPLE}_nano.fastq > ${SAMPLE}_nano.UtoT.fastq
rm ${SAMPLE}_nano.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' ${SAMPLE}_nano.UtoT.fastq > ${SAMPLE}_nano.UtoT.filtered.fastq
rm ${SAMPLE}_nano.UtoT.fastq
