#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

LTREADS="../../data/cel_L1/L1_nano.UtoT.filtered.fastq"
SRFQGZ1="../../data/cel_L1/L1_1.fastq.gz"
SRFQGZ2="../../data/cel_L1/L1_2.fastq.gz"
SRFQ1="../../data/cel_L1/L1_1.fastq"
SRFQ2="../../data/cel_L1/L1_2.fastq"
JF="../../analysis/talc/cel_L1/jf.out"
DUMP="../../analysis/talc/cel_L1/kmer_dump.out"
KMERSIZE=21
THREADS=$1
gunzip --keep ${SRFQGZ1}
gunzip --keep ${SRFQGZ2}

echo "Jellyfish K-mer counting count" > logs/talc_log.txt
{ time jellyfish count --mer ${KMERSIZE} -s 100M -o ${JF} -t ${THREADS} $SRFQ1 $SRFQ2 2>&1 ; } 2>> logs/talc_log.txt
echo " " >> logs/talc_log.txt
echo "Jellyfish K-mer counting dump" >> logs/talc_log.txt
{ time jellyfish dump -c ${JF} > ${DUMP} ; } 2>> logs/talc_log.txt
echo " " >> logs/talc_log.txt
rm ${JF}
rm ${SRFQ1}
rm ${SRFQ2}

echo "TALC proper" >> logs/talc_log.txt
{ time ../../../TALC/talc ${LTREADS} --SRCounts ${DUMP} -k ${KMERSIZE} -o ../../analysis/talc/cel_L1/cel_L1 -t ${THREADS} 2>&1 ; } 2>> logs/talc_log.txt

conda deactivate

