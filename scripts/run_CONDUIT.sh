#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

THREADS=$1
#Paired Illumina, antisense Illumina strands
SAMPLE_LIST=( cel_L1 cel_L4 cel_GA smaller_NA12878 )
for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/conduit_log.txt"
    echo "RATTLE gene cluster" > "${LOG}"
    { time rattle cluster  -i "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" \
        -t "${THREADS}" \
        --rna \
        --fastq \
        -o "../../data/${SAMPLE}/gene_clusters/" 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "RATTLE extract_clusters" >> "${LOG}"
    { time rattle extract_clusters -i "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" \
        -c "../../data/${SAMPLE}/gene_clusters/clusters.out" \
        --fastq \
        -m 1 \
        -o "../../data/${SAMPLE}/gene_clusters/" 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "CONDUIT correct" >> "${LOG}"
    { time conduit hybrid --unstranded \
        -s \
        -t:"${THREADS}" \
        --samtools-thread-memory 3G \
        -o "../../analysis/conduit/${SAMPLE}/stringent_output_dir/" \
        --tmp-dir "../../analysis/conduit/${SAMPLE}/stringent_tmp_dir/" \
        "../../data/${SAMPLE}/gene_clusters/" \
        -1 "../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz" \
        -2 "../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz"  2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"
done


#Paired Illumina, matching strands
SAMPLE_LIST=( cel_L2 )
for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/conduit_log.txt"
    echo "RATTLE gene cluster" > "${LOG}"
    { time rattle cluster  -i "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" \
        -t "${THREADS}" \
        --rna \
        --fastq \
        -o "../../data/${SAMPLE}/gene_clusters/" 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "RATTLE extract_clusters" >> "${LOG}"
    { time rattle extract_clusters -i "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" \
        -c "../../data/${SAMPLE}/gene_clusters/clusters.out" \
        --fastq \
        -m 1 \
        -o "../../data/${SAMPLE}/gene_clusters/" 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "CONDUIT correct" >> "${LOG}"
    { time conduit hybrid --unstranded \
        -s \
        --fwd-stranded \
        -t:"${THREADS}" \
        --samtools-thread-memory 3G \
        -o "../../analysis/conduit/${SAMPLE}/stringent_output_dir/" \
        --tmp-dir "../../analysis/conduit/${SAMPLE}/stringent_tmp_dir/" \
        "../../data/${SAMPLE}/gene_clusters/" \
        -1 "../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz" \
        -2 "../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz"  2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"
done


#Paired & unstranded Illumina
SAMPLE_LIST=( cel_L3 cel_YA nivar )
for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/conduit_log.txt"
    echo "RATTLE gene cluster" > "${LOG}"
    { time rattle cluster  -i "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" \
        -t "${THREADS}" \
        --rna \
        --fastq \
        -o "../../data/${SAMPLE}/gene_clusters/" 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "RATTLE extract_clusters" >> "${LOG}"
    { time rattle extract_clusters -i "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" \
        -c "../../data/${SAMPLE}/gene_clusters/clusters.out" \
        --fastq \
        -m 1 \
        -o "../../data/${SAMPLE}/gene_clusters/" 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "CONDUIT correct" >> "${LOG}"
    { time conduit hybrid --unstranded \
        -s \
        --unstranded \
        -t:"${THREADS}" \
        --samtools-thread-memory 3G \
        -o "../../analysis/conduit/${SAMPLE}/stringent_output_dir/" \
        --tmp-dir "../../analysis/conduit/${SAMPLE}/stringent_tmp_dir/" \
        "../../data/${SAMPLE}/gene_clusters/" \
        -1 "../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz" \
        -2 "../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz"  2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"
done


#Unpaired Illumina, mismatching strands
SAMPLE_LIST=( cel_male )

for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    LOG="logs/${SAMPLE}/conduit_log.txt"
    echo "RATTLE gene cluster" > "${LOG}"
    { time rattle cluster  -i "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" \
        -t "${THREADS}" \
        --rna \
        --fastq \
        -o "../../data/${SAMPLE}/gene_clusters/" 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "RATTLE extract_clusters" >> "${LOG}"
    { time rattle extract_clusters -i "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" \
        -c "../../data/${SAMPLE}/gene_clusters/clusters.out" \
        --fastq \
        -m 1 \
        -o "../../data/${SAMPLE}/gene_clusters/" 2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"

    echo "CONDUIT correct" >> "${LOG}"
    { time conduit hybrid --unstranded \
        -s \
        -t:"${THREADS}" \
        --samtools-thread-memory 3G \
        -o "../../analysis/conduit/${SAMPLE}/stringent_output_dir/" \
        --tmp-dir "../../analysis/conduit/${SAMPLE}/stringent_tmp_dir/" \
        "../../data/${SAMPLE}/gene_clusters/" \
        -U "../../data/${SAMPLE}/${SAMPLE}.fastq.gz"  2>&1 ; } 2>> "${LOG}"
    echo " " >> "${LOG}"
done

conda deactivate
