#!/bin/bash


source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

SAMPLE_LIST=( cel_L1 cel_L2 cel_L3 cel_L4 cel_YA cel_GA cel_male smaller_NA12878 nivar )
THREADS=$1


for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/spades_log.txt"
    LTREADS="../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq"
    SRFQGZ1="../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz"
    SRFQGZ2="../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz"
    SRFQ1="../../data/${SAMPLE}/${SAMPLE}_1.fastq"
    SRFQ2="../../data/${SAMPLE}/${SAMPLE}_2.fastq"

    gunzip --keep "${SRFQGZ1}"
    gunzip --keep "${SRFQGZ2}"

    echo "SPAdes:" > "${LOG}"
    { time ../../../SPAdes-3.14.1-Linux/bin/rnaspades.py \
        -t "${THREADS}" \
        --nanopore "${LTREADS}" \
        -1 "${SRFQ1}" \
        -2 "${SRFQ2}" \
        -o "../../analysis/SPAdes/${SAMPLE}/" 2>&1 ; } 2>> "${LOG}"
done

SAMPLE_LIST=( cel_male )
for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/spades_log.txt"
    LTREADS="../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq"
    SRFQGZ="../../data/${SAMPLE}/${SAMPLE}.fastq.gz"
    SRFQ="../../data/${SAMPLE}/${SAMPLE}.fastq"

    gunzip --keep ${SRFQGZ}

    echo "SPAdes:" > "${LOG}"
    { time ../../../SPAdes-3.14.1-Linux/bin/rnaspades.py \
        -t "${THREADS}" \
        --nanopore "${LTREADS}" \
        -s "${SRFQ}" \
        -o "../../analysis/SPAdes/${SAMPLE}/" 2>&1 ; } 2>> "${LOG}"
done


conda deactivate


