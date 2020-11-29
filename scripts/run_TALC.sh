#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

THREADS=$1

#Paired reads, forward
SAMPLE_LIST=( cel_L1 cel_L2 cel_L3 cel_L4 cel_YA cel_GA smaller_NA12878 nivar )
for SAMPLE in "${SAMPLE_LIST[@]}";
do
    LTREADS="../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq"
    SRFQGZ1="../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz"
    SRFQGZ2="../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz"
    SRFQ1="../../data/${SAMPLE}/${SAMPLE}_1.fastq"
    SRFQ2="../../data/${SAMPLE}/${SAMPLE}_2.fastq"
    JF="../../analysis/talc/${SAMPLE}/jf.out"
    DUMP="../../analysis/talc/${SAMPLE}/kmer_dump.out"
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
    { time ../../../TALC/talc ${LTREADS} --SRCounts ${DUMP} -k ${KMERSIZE} -o ../../analysis/talc/${SAMPLE}/${SAMPLE} -t ${THREADS} 2>&1 ; } 2>> logs/talc_log.txt
done

#Paired reads, reverse
SAMPLE_LIST=( cel_L4 cel_GA smaller_NA12878 )
for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LTREADS="../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq"
    SRFQGZ1="../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz"
    SRFQGZ2="../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz"
    SRFQ1="../../data/${SAMPLE}/${SAMPLE}_1.fastq"
    SRFQ2="../../data/${SAMPLE}/${SAMPLE}_2.fastq"
    JF="../../analysis/talc/${SAMPLE}/jf.out"
    DUMP="../../analysis/talc/${SAMPLE}/kmer_dump.out"
    KMERSIZE=21
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
    { time talc ${LTREADS} --SRCounts ${DUMP} -k ${KMERSIZE} -o ../../analysis/talc/${SAMPLE}/${SAMPLE} -t ${THREADS} --reverse 2>&1 ; } 2>> logs/talc_log.txt
done

#Single reads, reverse
SAMPLE_LIST=( cel_male )

for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LTREADS="../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq"
    SRFQGZ1="../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz"
    SRFQGZ2="../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz"
    SRFQ1="../../data/${SAMPLE}/${SAMPLE}_1.fastq"
    SRFQ2="../../data/${SAMPLE}/${SAMPLE}_2.fastq"
    JF="../../analysis/talc/${SAMPLE}/jf.out"
    DUMP="../../analysis/talc/${SAMPLE}/kmer_dump.out"
    KMERSIZE=21
    THREADS=$1
    gunzip --keep ${SRFQGZ1}
    gunzip --keep ${SRFQGZ2}

    echo "Jellyfish K-mer counting count" > logs/talc_log.txt
    { time jellyfish count --mer ${KMERSIZE} -s 100M -o ${JF} -t ${THREADS} $SRFQ1 2>&1 ; } 2>> logs/talc_log.txt
    echo " " >> logs/talc_log.txt
    echo "Jellyfish K-mer counting dump" >> logs/talc_log.txt
    { time jellyfish dump -c ${JF} > ${DUMP} ; } 2>> logs/talc_log.txt
    echo " " >> logs/talc_log.txt
    rm ${JF}
    rm ${SRFQ1}

    echo "TALC proper" >> logs/talc_log.txt
    { time talc ${LTREADS} --SRCounts ${DUMP} -k ${KMERSIZE} -o ../../analysis/talc/${SAMPLE}/${SAMPLE} -t ${THREADS} --reverse 2>&1 ; } 2>> logs/talc_log.txt

done

conda deactivate