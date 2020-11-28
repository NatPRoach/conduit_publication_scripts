#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

SAMPLE_LIST=( cel_L1 cel_L2 cel_L3 cel_L4 cel_YA cel_GA cel_male smaller_NA12878 nivar )
THREADS=$1

for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/rattle_log.txt"
    echo "RATTLE cluster" > "${LOG}"
    { time rattle cluster  -i ../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq \
                           -t ${THREADS} \
                           --rna \
                           --fastq \
                           --iso  \
                           -o ../../data/${SAMPLE}/isoform_clusters/ 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "RATTLE correct" >> "${LOG}"
    { time rattle correct -i ../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq \
                          -t ${THREADS} \
                          -r 1 \
                          -c ../../data/${SAMPLE}/isoform_clusters/clusters.out \
                          -o ../../analysis/rattle/${SAMPLE}/ 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    mv ../../analysis/rattle/${SAMPLE}/consensi.fq ../../analysis/rattle/${SAMPLE}/rattle_consensi.fq

    echo "RATTLE polish" >> "${LOG}"
    { time rattle polish -i ../../analysis/rattle/${SAMPLE}/rattle_consensi.fq \
        -t ${THREADS} \
        --rna \
        -o ../../analysis/rattle/${SAMPLE}/ 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"
done

conda deactivate