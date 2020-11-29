#!/bin/bash

THREADS=$1

#gunzip -k ../../data/NA12878/SRR1153470_1.fastq.gz
#gunzip -k ../../data/NA12878/SRR1153470_2.fastq.gz

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

THREADS=$1

SAMPLE_LIST=( cel_L1 cel_L2 cel_L3 cel_L4 cel_YA cel_GA smaller_NA12878 nivar )

for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/trinity_log.txt"
    echo "Trinity run" > "${LOG}"
    { time Trinity --seqType fq \
        --output ../../analysis/trinity/${SAMPLE}/trinity_out/ \
        --left ../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz \
        --right ../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz \
        --CPU ${THREADS} \
        --max_memory 60G  \
        2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"
done

SAMPLE_LIST=( cel_male )

for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/trinity_log.txt"
    echo "Trinity run" > "${LOG}"
    { time Trinity --seqType fq \
        --output ../../analysis/trinity/${SAMPLE}/trinity_out/ \
        --single ../../data/${SAMPLE}/${SAMPLE}.fastq.gz \
        --CPU ${THREADS} \
        --max_memory 60G  \
        2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"
done

conda deactivate