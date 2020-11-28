#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

SAMPLE_LIST=( cel_L1 cel_L2 cel_L3 cel_L4 cel_YA cel_GA cel_male smaller_NA12878 nivar )
THREADS=$1

for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/conduit_log.txt"
    echo "RATTLE gene cluster" > "${LOG}"
    { time rattle cluster  -i ../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq \
        -t ${THREADS} \
        --rna \
        --fastq \
        -o ../../data/${SAMPLE}/gene_clusters/ 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "RATTLE extract_clusters" >> "${LOG}"
    { time rattle extract_clusters -i ../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq \
        -c ../../data/${SAMPLE}/gene_clusters/clusters.out \
        --fastq \
        -m 1 \
        -o ../../data/${SAMPLE}/gene_clusters/ 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "CONDUIT correct" >> "${LOG}"
    { time conduit hybrid --unstranded \
        -s \
        -t:"${THREADS}" \
        --samtools-thread-memory 3G \
        -o ../../analysis/conduit/${SAMPLE}/stringent_output_dir/ \
        --tmp-dir ../../analysis/conduit/${SAMPLE}/stringent_tmp_dir/ \
        ../../data/${SAMPLE}/gene_clusters/ \
        -1 ../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz \
        -2 ../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz  2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"
done

conda deactivate
