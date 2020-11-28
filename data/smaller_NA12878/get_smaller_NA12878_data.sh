#!/bin/bash

fastq-dump --split-files SRR1153470

wget https://s3.amazonaws.com/nanopore-human-wgs/rna/fastq/Bham_Run1_20171009_DirectRNA.pass.dedup.fastq

sed 's/U/T/g' Bham_Run1_20171009_DirectRNA.pass.dedup.fastq > NA12878.UtoT.fastq
rm Bham_Run1_20171009_DirectRNA.pass.dedup.fastq
awk 'BEGIN{OFS="\n"} /^@/ {getline s; getline a; getline q; if (length(s) >= 150) {print $0,s,a,q}}' NA12878.UtoT.fastq > NA12878.UtoT.filtered.fastq
rm NA12878.UtoT.fastq
