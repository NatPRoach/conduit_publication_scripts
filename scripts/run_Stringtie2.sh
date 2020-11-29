#!/bin/bash

THREADS=$1

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking


THREADS=$1

SAMPLE_LIST=( cel_L1 cel_L2 cel_L3 cel_L4 cel_YA cel_GA smaller_NA12878 nivar )
GENOME_LIST=( 0 0 0 0 0 0 1 2 )
GENOMES=( ../../data/references/ce11 ../../data/references/hg38 ../../data/references/nivar_r9.contigs )

for GENOME in "${GENOMES[@]}"
do
    hisat2-build ${GENOME}.fa ${GENOME}
done


for IDX in "${!SAMPLE_LIST[@]}";
do
    SAMPLE=${SAMPLE_LIST[$IDX]}
    GENOME=${GENOMES[${GENOME_LIST[$IDX]}]}
    ONT="../../data/${SAMPLE}/raw_${SAMPLE}_reads.bam"
    ILLUMINA="../../data/${SAMPLE}/${SAMPLE}_illumina.bam"

    minimap2 -t "${THREADS}" -ax splice "${GENOME}.fa" "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" > "../../data/${SAMPLE}/raw_${SAMPLE}_reads.sam"
    samtools sort -@ "${THREADS}" "../../data/${SAMPLE}/raw_${SAMPLE}_reads.sam" > "${ONT}"
    samtools index "${ONT}"

    hisat2 -p "${THREADS}" -x "${GENOME}" -1 "../../data/${SAMPLE}/${SAMPLE}_1.fastq.gz" -2 "../../data/${SAMPLE}/${SAMPLE}_2.fastq.gz" -S "../../data/${SAMPLE}/${SAMPLE}_illumina.sam"
    samtools sort -@ "${THREADS}" "../../data/${SAMPLE}/${SAMPLE}_illumina.sam" > "${ILLUMINA}"
    samtools index "${ILLUMINA}"

    stringtie -L -o "../../analysis/Stringtie2/${SAMPLE}/ont.gtf" "${ONT}" 
    stringtie -o "../../analysis/Stringtie2/${SAMPLE}/illumina.gtf" "${ILLUMINA}"
    stringtie -o "../../analysis/Stringtie2/${SAMPLE}/merged.gtf" --merge "../../analysis/Stringtie2/${SAMPLE}/ont.gtf" "../../analysis/Stringtie2/${SAMPLE}/illumina.gtf"

    gtfToGenePred "../../analysis/Stringtie2/${SAMPLE}/ont.gtf" "../../analysis/Stringtie2/${SAMPLE}/ont.genePred"
    gtfToGenePred "../../analysis/Stringtie2/${SAMPLE}/illumina.gtf" "../../analysis/Stringtie2/${SAMPLE}/illumina.genePred"
    gtfToGenePred "../../analysis/Stringtie2/${SAMPLE}/merged.gtf" "../../analysis/Stringtie2/${SAMPLE}/merged.genePred"

    genePredToBed "../../analysis/Stringtie2/${SAMPLE}/ont.genePred" "../../analysis/Stringtie2/${SAMPLE}/ont.bed"
    genePredToBed "../../analysis/Stringtie2/${SAMPLE}/illumina.genePred" "../../analysis/Stringtie2/${SAMPLE}/illumina.bed"
    genePredToBed "../../analysis/Stringtie2/${SAMPLE}/merged.genePred" "../../analysis/Stringtie2/${SAMPLE}/merged.bed"

    bedtools getfasta -split -fo "../../analysis/Stringtie2/${SAMPLE}/ont.fa" -fi ../../data/references/ce11.fa -bed "../../analysis/Stringtie2/${SAMPLE}/ont.bed"
    bedtools getfasta -split -fo "../../analysis/Stringtie2/${SAMPLE}/illumina.fa" -fi ../../data/references/ce11.fa -bed "../../analysis/Stringtie2/${SAMPLE}/illumina.bed"
    bedtools getfasta -split -fo "../../analysis/Stringtie2/${SAMPLE}/merged.fa" -fi ../../data/references/ce11.fa -bed "../../analysis/Stringtie2/${SAMPLE}/merged.bed"
done

SAMPLE_LIST=( cel_male )
GENOME_LIST=( 0 )

for IDX in "${!SAMPLE_LIST[@]}";
do 
    SAMPLE=${SAMPLE_LIST[$IDX]}
    GENOME=${GENOMES[${GENOME_LIST[$IDX]}]}
    ONT="../../data/${SAMPLE}/raw_${SAMPLE}_reads.bam"
    ILLUMINA="../../data/${SAMPLE}/${SAMPLE}_illumina.bam"

    minimap2 -t "${THREADS}" -ax splice "${GENOME}.fa" "../../data/${SAMPLE}/${SAMPLE}_nano.UtoT.filtered.fastq" > "../../data/${SAMPLE}/raw_${SAMPLE}_reads.sam"
    samtools sort -@ "${THREADS}" "../../data/${SAMPLE}/raw_${SAMPLE}_reads.sam" > "${ONT}"
    samtools index "${ONT}"

    hisat2 -p "${THREADS}" -x "${GENOME}" -U "../../data/${SAMPLE}/${SAMPLE}.fastq.gz" -S "../../data/${SAMPLE}/${SAMPLE}_illumina.sam"
    samtools sort -@ "${THREADS}" "../../data/${SAMPLE}/${SAMPLE}_illumina.sam" > "${ILLUMINA}"
    samtools index "${ILLUMINA}"

    stringtie -L -o "../../analysis/Stringtie2/${SAMPLE}/ont.gtf" "${ONT}" 
    stringtie -o "../../analysis/Stringtie2/${SAMPLE}/illumina.gtf" "${ILLUMINA}"
    stringtie -o "../../analysis/Stringtie2/${SAMPLE}/merged.gtf" --merge "../../analysis/Stringtie2/${SAMPLE}/ont.gtf" "../../analysis/Stringtie2/${SAMPLE}/illumina.gtf"

    gtfToGenePred "../../analysis/Stringtie2/${SAMPLE}/ont.gtf" "../../analysis/Stringtie2/${SAMPLE}/ont.genePred"
    gtfToGenePred "../../analysis/Stringtie2/${SAMPLE}/illumina.gtf" "../../analysis/Stringtie2/${SAMPLE}/illumina.genePred"
    gtfToGenePred "../../analysis/Stringtie2/${SAMPLE}/merged.gtf" "../../analysis/Stringtie2/${SAMPLE}/merged.genePred"

    genePredToBed "../../analysis/Stringtie2/${SAMPLE}/ont.genePred" "../../analysis/Stringtie2/${SAMPLE}/ont.bed"
    genePredToBed "../../analysis/Stringtie2/${SAMPLE}/illumina.genePred" "../../analysis/Stringtie2/${SAMPLE}/illumina.bed"
    genePredToBed "../../analysis/Stringtie2/${SAMPLE}/merged.genePred" "../../analysis/Stringtie2/${SAMPLE}/merged.bed"

    bedtools getfasta -split -fo "../../analysis/Stringtie2/${SAMPLE}/ont.fa" -fi ../../data/references/ce11.fa -bed "../../analysis/Stringtie2/${SAMPLE}/ont.bed"
    bedtools getfasta -split -fo "../../analysis/Stringtie2/${SAMPLE}/illumina.fa" -fi ../../data/references/ce11.fa -bed "../../analysis/Stringtie2/${SAMPLE}/illumina.bed"
    bedtools getfasta -split -fo "../../analysis/Stringtie2/${SAMPLE}/merged.fa" -fi ../../data/references/ce11.fa -bed "../../analysis/Stringtie2/${SAMPLE}/merged.bed"
done

conda deactivate

