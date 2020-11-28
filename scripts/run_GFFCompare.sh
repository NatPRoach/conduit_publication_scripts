#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

CONDUIT_L1="../analysis/conduit/cel_L1/stringent_output_dir/conduit_final_consensuses.fa"
FILTERED_CONDUIT_L1="../analysis/conduit/cel_L1/stringent_output_dir/filtered_conduit_final_consensuses.fa"
RATTLE_L1="../analysis/rattle/cel_L1/transcriptome.fq"
TALC_L1="../analysis/talc/cel_L1/cel_L1.fa"
TRINITY_L1="../analysis/trinity/cel_L1/trinity_out/Trinity.fasta"
SPADES_L1="../analysis/SPAdes/cel_L1/transcripts.fasta"

### Strand the approaches that need stranding
conduitUtils strandTranscripts -i ${TRINITY_L1} -o ../analysis/trinity/cel_L1/trinity_out/Trinity_stranded.fasta
conduitUtils strandTranscripts -i ${SPADES_L1} -o ../analysis/SPAdes/cel_L1/transcripts_stranded.fasta

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${CONDUIT_L1} > ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.sam
samtools sort ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.sam > ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.bam
samtools view -b -F 2304 ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.bam > tmp.bam
mv tmp.bam ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.bam
samtools index ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${FILTERED_CONDUIT_L1} > ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.sam
samtools sort ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.sam > ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.bam
samtools view -b -F 2304 ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.bam > tmp.bam
mv tmp.bam ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.bam
samtools index ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${RATTLE_L1} > ../analysis/rattle/cel_L1/rattle_L1.sam
samtools sort ../analysis/rattle/cel_L1/rattle_L1.sam > ../analysis/rattle/cel_L1/rattle_L1.bam
samtools view -b -F 2304 ../analysis/rattle/cel_L1/rattle_L1.bam > tmp.bam
mv tmp.bam ../analysis/rattle/cel_L1/rattle_L1.bam 
samtools index ../analysis/rattle/cel_L1/rattle_L1.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${TALC_L1} > ../analysis/talc/cel_L1/cel_L1.sam
samtools sort ../analysis/talc/cel_L1/cel_L1.sam > ../analysis/talc/cel_L1/cel_L1.bam
samtools view -b -F 2304 ../analysis/talc/cel_L1/cel_L1.bam > tmp.bam
mv tmp.bam ../analysis/talc/cel_L1/cel_L1.bam
samtools index ../analysis/talc/cel_L1/cel_L1.bam

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/trinity/cel_L1/trinity_out/Trinity_stranded.fasta > ../analysis/trinity/cel_L1/trinity.sam
samtools sort ../analysis/trinity/cel_L1/trinity.sam > ../analysis/trinity/cel_L1/trinity.bam
samtools view -b -F 2304 ../analysis/trinity/cel_L1/trinity.bam  > tmp.bam
mv tmp.bam ../analysis/trinity/cel_L1/trinity.bam 
samtools index ../analysis/trinity/cel_L1/trinity.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/SPAdes/cel_L1/transcripts_stranded.fasta > ../analysis/SPAdes/cel_L1/spades.sam
samtools sort ../analysis/SPAdes/cel_L1/spades.sam > ../analysis/SPAdes/cel_L1/spades.bam
samtools view -b -F 2304 ../analysis/SPAdes/cel_L1/spades.bam > tmp.bam
mv tmp.bam ../analysis/SPAdes/cel_L1/spades.bam
samtools index ../analysis/SPAdes/cel_L1/spades.bam 


bedtools bamtobed -bed12 -i ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.bam > ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.bed
bedtools bamtobed -bed12 -i ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.bam > ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.bed
bedtools bamtobed -bed12 -i ../analysis/rattle/cel_L1/rattle_L1.bam > ../analysis/rattle/cel_L1/rattle_L1.bed
bedtools bamtobed -bed12 -i ../analysis/talc/cel_L1/cel_L1.bam > ../analysis/talc/cel_L1/cel_L1.bed
bedtools bamtobed -bed12 -i ../analysis/trinity/cel_L1/trinity.bam > ../analysis/trinity/cel_L1/trinity.bed
bedtools bamtobed -bed12 -i ../analysis/SPAdes/cel_L1/spades.bam > ../analysis/SPAdes/cel_L1/spades.bed

conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.bed -o ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.gtf
conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.bed -o ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.gtf
conduitUtils  bed2gtf -s -i ../analysis/rattle/cel_L1/rattle_L1.bed -o ../analysis/rattle/cel_L1/rattle_L1.gtf
conduitUtils  bed2gtf -s -i ../analysis/talc/cel_L1/cel_L1.bed -o ../analysis/talc/cel_L1/cel_L1.gtf
conduitUtils  bed2gtf -s -i ../analysis/trinity/cel_L1/trinity.bed -o ../analysis/trinity/cel_L1/trinity.gtf
conduitUtils  bed2gtf -s -i ../analysis/SPAdes/cel_L1/spades.bed -o ../analysis/SPAdes/cel_L1/spades.gtf

gffcompare -o ../analysis/GFFcompare/cel_L1/cel_L1_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.gtf ../analysis/rattle/cel_L1/rattle_L1.gtf ../analysis/talc/cel_L1/cel_L1.gtf ../analysis/trinity/cel_L1/trinity.gtf ../analysis/SPAdes/cel_L1/spades.gtf ../analysis/Stringtie2/cel_L1/merged.gtf
gffcompare -o ../analysis/GFFcompare/cel_L1/cel_L1_filtered_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_L1/stringent_output_dir/filtered_stringent_conduit_L1.gtf 

CONDUIT_L2="../analysis/conduit/cel_L2/stringent_output_dir/conduit_final_consensuses.fa"
FILTERED_CONDUIT_L2="../analysis/conduit/cel_L2/stringent_output_dir/filtered_conduit_final_consensuses.fa"
RATTLE_L2="../analysis/rattle/cel_L2/transcriptome.fq"
TALC_L2="../analysis/talc/cel_L2/cel_L2.fa"
TRINITY_L2="../analysis/trinity/cel_L2/trinity_out/Trinity.fasta"
SPADES_L2="../analysis/SPAdes/cel_L2/transcripts.fasta"


conduitUtils strandTranscripts -i ${TRINITY_L2} -o ../analysis/trinity/cel_L2/trinity_out/Trinity_stranded.fasta
conduitUtils strandTranscripts -i ${SPADES_L2} -o ../analysis/SPAdes/cel_L2/transcripts_stranded.fasta


minimap2 -t 40 -ax splice ../data/references/ce11.fa ${CONDUIT_L2} > ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.sam
samtools sort ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.sam > ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.bam
samtools view -b -F 2304 ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.bam 
samtools index ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${FILTERED_CONDUIT_L2} > ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.sam
samtools sort ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.sam > ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.bam
samtools view -b -F 2304 ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.bam 
samtools index ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${RATTLE_L2} > ../analysis/rattle/cel_L2/rattle_L2.sam
samtools sort ../analysis/rattle/cel_L2/rattle_L2.sam > ../analysis/rattle/cel_L2/rattle_L2.bam
samtools view -b -F 2304 ../analysis/rattle/cel_L2/rattle_L2.bam  > tmp.bam
mv tmp.bam ../analysis/rattle/cel_L2/rattle_L2.bam 
samtools index ../analysis/rattle/cel_L2/rattle_L2.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${TALC_L2} > ../analysis/talc/cel_L2/cel_L2.sam
samtools sort ../analysis/talc/cel_L2/cel_L2.sam > ../analysis/talc/cel_L2/cel_L2.bam
samtools view -b -F 2304 ../analysis/talc/cel_L2/cel_L2.bam > tmp.bam
mv tmp.bam ../analysis/talc/cel_L2/cel_L2.bam
samtools index ../analysis/talc/cel_L2/cel_L2.bam

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/trinity/cel_L2/trinity_out/Trinity_stranded.fasta > ../analysis/trinity/cel_L2/trinity.sam
samtools sort ../analysis/trinity/cel_L2/trinity.sam > ../analysis/trinity/cel_L2/trinity.bam
samtools view -b -F 2304 ../analysis/trinity/cel_L2/trinity.bam > tmp.bam
mv tmp.bam ../analysis/trinity/cel_L2/trinity.bam 
samtools index ../analysis/trinity/cel_L2/trinity.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/SPAdes/cel_L2/transcripts_stranded.fasta > ../analysis/SPAdes/cel_L2/spades.sam
samtools sort ../analysis/SPAdes/cel_L2/spades.sam > ../analysis/SPAdes/cel_L2/spades.bam
samtools view -b -F 2304 ../analysis/SPAdes/cel_L2/spades.bam > tmp.bam
mv tmp.bam ../analysis/SPAdes/cel_L2/spades.bam 
samtools index ../analysis/SPAdes/cel_L2/spades.bam 

bedtools bamtobed -bed12 -i ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.bam > ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.bed
bedtools bamtobed -bed12 -i ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.bam > ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.bed
bedtools bamtobed -bed12 -i ../analysis/rattle/cel_L2/rattle_L2.bam > ../analysis/rattle/cel_L2/rattle_L2.bed
bedtools bamtobed -bed12 -i ../analysis/talc/cel_L2/cel_L2.bam > ../analysis/talc/cel_L2/cel_L2.bed
bedtools bamtobed -bed12 -i ../analysis/trinity/cel_L2/trinity.bam > ../analysis/trinity/cel_L2/trinity.bed
bedtools bamtobed -bed12 -i ../analysis/SPAdes/cel_L2/spades.bam > ../analysis/SPAdes/cel_L2/spades.bed

conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.bed -o ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.gtf
conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.bed -o ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.gtf
conduitUtils  bed2gtf -s -i ../analysis/rattle/cel_L2/rattle_L2.bed -o ../analysis/rattle/cel_L2/rattle_L2.gtf
conduitUtils  bed2gtf -s -i ../analysis/talc/cel_L2/cel_L2.bed -o ../analysis/talc/cel_L2/cel_L2.gtf
conduitUtils  bed2gtf -s -i ../analysis/trinity/cel_L2/trinity.bed -o ../analysis/trinity/cel_L2/trinity.gtf
conduitUtils  bed2gtf -s -i ../analysis/SPAdes/cel_L2/spades.bed -o ../analysis/SPAdes/cel_L2/spades.gtf

gffcompare -o ../analysis/GFFcompare/cel_L2/cel_L2_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.gtf ../analysis/rattle/cel_L2/rattle_L2.gtf ../analysis/talc/cel_L2/cel_L2.gtf ../analysis/trinity/cel_L2/trinity.gtf ../analysis/SPAdes/cel_L2/spades.gtf ../analysis/Stringtie2/cel_L2/merged.gtf
gffcompare -o ../analysis/GFFcompare/cel_L2/cel_L2_filtered_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_L2/stringent_output_dir/filtered_stringent_conduit_L2.gtf

CONDUIT_L3="../analysis/conduit/cel_L3/stringent_output_dir/conduit_final_consensuses.fa"
FILTERED_CONDUIT_L3="../analysis/conduit/cel_L3/stringent_output_dir/filtered_conduit_final_consensuses.fa"
RATTLE_L3="../analysis/rattle/cel_L3/transcriptome.fq"
TALC_L3="../analysis/talc/cel_L3/cel_L3.fa"
TRINITY_L3="../analysis/trinity/cel_L3/trinity_out/Trinity.fasta"
SPADES_L3="../analysis/SPAdes/cel_L3/transcripts.fasta"


conduitUtils strandTranscripts -i ${TRINITY_L3} -o ../analysis/trinity/cel_L3/trinity_out/Trinity_stranded.fasta
conduitUtils strandTranscripts -i ${SPADES_L3} -o ../analysis/SPAdes/cel_L3/transcripts_stranded.fasta

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${CONDUIT_L3} > ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.sam
samtools sort ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.sam > ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.bam
samtools view -b -F 2304 ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.bam > tmp.bam
mv tmp.bam ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.bam 
samtools index ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${FILTERED_CONDUIT_L3} > ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.sam
samtools sort ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.sam > ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.bam
samtools view -b -F 2304 ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.bam 
samtools index ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${RATTLE_L3} > ../analysis/rattle/cel_L3/rattle_L3.sam
samtools sort ../analysis/rattle/cel_L3/rattle_L3.sam > ../analysis/rattle/cel_L3/rattle_L3.bam
samtools view -b -F 2304 ../analysis/rattle/cel_L3/rattle_L3.bam  > tmp.bam
mv tmp.bam ../analysis/rattle/cel_L3/rattle_L3.bam 
samtools index ../analysis/rattle/cel_L3/rattle_L3.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${TALC_L3} > ../analysis/talc/cel_L3/cel_L3.sam
samtools sort ../analysis/talc/cel_L3/cel_L3.sam > ../analysis/talc/cel_L3/cel_L3.bam
samtools view -b -F 2304 ../analysis/talc/cel_L3/cel_L3.bam > tmp.bam
mv tmp.bam ../analysis/talc/cel_L3/cel_L3.bam
samtools index ../analysis/talc/cel_L3/cel_L3.bam

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/trinity/cel_L3/trinity_out/Trinity_stranded.fasta > ../analysis/trinity/cel_L3/trinity.sam
samtools sort ../analysis/trinity/cel_L3/trinity.sam > ../analysis/trinity/cel_L3/trinity.bam
samtools view -b -F 2304 ../analysis/trinity/cel_L3/trinity.bam > tmp.bam
mv tmp.bam ../analysis/trinity/cel_L3/trinity.bam 
samtools index ../analysis/trinity/cel_L3/trinity.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/SPAdes/cel_L3/transcripts_stranded.fasta > ../analysis/SPAdes/cel_L3/spades.sam
samtools sort ../analysis/SPAdes/cel_L3/spades.sam > ../analysis/SPAdes/cel_L3/spades.bam
samtools view -b -F 2304 ../analysis/SPAdes/cel_L3/spades.bam > tmp.bam
mv tmp.bam ../analysis/SPAdes/cel_L3/spades.bam 
samtools index ../analysis/SPAdes/cel_L3/spades.bam 

bedtools bamtobed -bed12 -i ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.bam > ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.bed
bedtools bamtobed -bed12 -i ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.bam > ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.bed
bedtools bamtobed -bed12 -i ../analysis/rattle/cel_L3/rattle_L3.bam > ../analysis/rattle/cel_L3/rattle_L3.bed
bedtools bamtobed -bed12 -i ../analysis/talc/cel_L3/cel_L3.bam > ../analysis/talc/cel_L3/cel_L3.bed
bedtools bamtobed -bed12 -i ../analysis/trinity/cel_L3/trinity.bam > ../analysis/trinity/cel_L3/trinity.bed
bedtools bamtobed -bed12 -i ../analysis/SPAdes/cel_L3/spades.bam > ../analysis/SPAdes/cel_L3/spades.bed

conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.bed -o ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.gtf
conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.bed -o ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.gtf
conduitUtils  bed2gtf -s -i ../analysis/rattle/cel_L3/rattle_L3.bed -o ../analysis/rattle/cel_L3/rattle_L3.gtf
conduitUtils  bed2gtf -s -i ../analysis/talc/cel_L3/cel_L3.bed -o ../analysis/talc/cel_L3/cel_L3.gtf
conduitUtils  bed2gtf -s -i ../analysis/trinity/cel_L3/trinity.bed -o ../analysis/trinity/cel_L3/trinity.gtf
conduitUtils  bed2gtf -s -i ../analysis/SPAdes/cel_L3/spades.bed -o ../analysis/SPAdes/cel_L3/spades.gtf

gffcompare -o ../analysis/GFFcompare/cel_L3/cel_L3_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.gtf ../analysis/rattle/cel_L3/rattle_L3.gtf ../analysis/talc/cel_L3/cel_L3.gtf ../analysis/trinity/cel_L3/trinity.gtf ../analysis/SPAdes/cel_L3/spades.gtf ../analysis/Stringtie2/cel_L3/merged.gtf
gffcompare -o ../analysis/GFFcompare/cel_L3/cel_L3_filtered_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_L3/stringent_output_dir/filtered_stringent_conduit_L3.gtf

CONDUIT_L4="../analysis/conduit/cel_L4/stringent_output_dir/conduit_final_consensuses.fa"
FILTERED_CONDUIT_L4="../analysis/conduit/cel_L4/stringent_output_dir/filtered_conduit_final_consensuses.fa"
RATTLE_L4="../analysis/rattle/cel_L4/transcriptome.fq"
TALC_L4="../analysis/talc/cel_L4/cel_L4.fa"
TRINITY_L4="../analysis/trinity/cel_L4/trinity_out/Trinity.fasta"
SPADES_L4="../analysis/SPAdes/cel_L4/transcripts.fasta"

conduitUtils strandTranscripts -i ${TRINITY_L4} -o ../analysis/trinity/cel_L4/trinity_out/Trinity_stranded.fasta
conduitUtils strandTranscripts -i ${SPADES_L4} -o ../analysis/SPAdes/cel_L4/transcripts_stranded.fasta

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${CONDUIT_L4} > ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.sam
samtools sort ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bam
samtools view -b -F 2304 ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bam 
samtools index ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${FILTERED_CONDUIT_L4} > ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.sam
samtools sort ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.bam
samtools view -b -F 2304 ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.bam 
samtools index ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${RATTLE_L4} > ../analysis/rattle/cel_L4/rattle_L4.sam
samtools sort ../analysis/rattle/cel_L4/rattle_L4.sam > ../analysis/rattle/cel_L4/rattle_L4.bam
samtools view -b -F 2304 ../analysis/rattle/cel_L4/rattle_L4.bam  > tmp.bam
mv tmp.bam ../analysis/rattle/cel_L4/rattle_L4.bam 
samtools index ../analysis/rattle/cel_L4/rattle_L4.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${TALC_L4} > ../analysis/talc/cel_L4/cel_L4.sam
samtools sort ../analysis/talc/cel_L4/cel_L4.sam > ../analysis/talc/cel_L4/cel_L4.bam
samtools view -b -F 2304 ../analysis/talc/cel_L4/cel_L4.bam > tmp.bam
mv tmp.bam ../analysis/talc/cel_L4/cel_L4.bam
samtools index ../analysis/talc/cel_L4/cel_L4.bam

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/trinity/cel_L4/trinity_out/Trinity_stranded.fasta > ../analysis/trinity/cel_L4/trinity.sam
samtools sort ../analysis/trinity/cel_L4/trinity.sam > ../analysis/trinity/cel_L4/trinity.bam
samtools view -b -F 2304  ../analysis/trinity/cel_L4/trinity.bam > tmp.bam
mv tmp.bam ../analysis/trinity/cel_L4/trinity.bam
samtools index ../analysis/trinity/cel_L4/trinity.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/SPAdes/cel_L4/transcripts_stranded.fasta > ../analysis/SPAdes/cel_L4/spades.sam
samtools sort ../analysis/SPAdes/cel_L4/spades.sam > ../analysis/SPAdes/cel_L4/spades.bam
samtools view -b -F 2304 ../analysis/SPAdes/cel_L4/spades.bam > tmp.bam
mv tmp.bam ../analysis/SPAdes/cel_L4/spades.bam 
samtools index ../analysis/SPAdes/cel_L4/spades.bam 

bedtools bamtobed -bed12 -i ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bam > ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bed
bedtools bamtobed -bed12 -i ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.bam > ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.bed
bedtools bamtobed -bed12 -i ../analysis/rattle/cel_L4/rattle_L4.bam > ../analysis/rattle/cel_L4/rattle_L4.bed
bedtools bamtobed -bed12 -i ../analysis/talc/cel_L4/cel_L4.bam > ../analysis/talc/cel_L4/cel_L4.bed
bedtools bamtobed -bed12 -i ../analysis/trinity/cel_L4/trinity.bam > ../analysis/trinity/cel_L4/trinity.bed
bedtools bamtobed -bed12 -i ../analysis/SPAdes/cel_L4/spades.bam > ../analysis/SPAdes/cel_L4/spades.bed


conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bed -o ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.gtf
conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.bed -o ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.gtf
conduitUtils  bed2gtf -s -i ../analysis/rattle/cel_L4/rattle_L4.bed -o ../analysis/rattle/cel_L4/rattle_L4.gtf
conduitUtils  bed2gtf -s -i ../analysis/talc/cel_L4/cel_L4.bed -o ../analysis/talc/cel_L4/cel_L4.gtf
conduitUtils  bed2gtf -s -i ../analysis/trinity/cel_L4/trinity.bed -o ../analysis/trinity/cel_L4/trinity.gtf
conduitUtils  bed2gtf -s -i ../analysis/SPAdes/cel_L4/spades.bed -o ../analysis/SPAdes/cel_L4/spades.gtf

gffcompare -o ../analysis/GFFcompare/cel_L4/cel_L4_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.gtf ../analysis/rattle/cel_L4/rattle_L4.gtf ../analysis/talc/cel_L4/cel_L4.gtf ../analysis/trinity/cel_L4/trinity.gtf ../analysis/SPAdes/cel_L4/spades.gtf ../analysis/Stringtie2/cel_L4/merged.gtf
gffcompare -o ../analysis/GFFcompare/cel_L4/cel_L4_filtered_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_L4/stringent_output_dir/filtered_stringent_conduit_L4.gtf 

CONDUIT_YA="../analysis/conduit/cel_YA/stringent_output_dir/conduit_final_consensuses.fa"
FILTERED_CONDUIT_YA="../analysis/conduit/cel_YA/stringent_output_dir/filtered_conduit_final_consensuses.fa"
RATTLE_YA="../analysis/rattle/cel_YA/transcriptome.fq"
TALC_YA="../analysis/talc/cel_YA/cel_YA.fa"
TRINITY_YA="../analysis/trinity/cel_YA/trinity_out/Trinity.fasta"
SPADES_YA="../analysis/SPAdes/cel_YA/transcripts.fasta"

conduitUtils strandTranscripts -i ${TRINITY_YA} -o ../analysis/trinity/cel_YA/trinity_out/Trinity_stranded.fasta
conduitUtils strandTranscripts -i ${SPADES_YA} -o ../analysis/SPAdes/cel_YA/transcripts_stranded.fasta

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${CONDUIT_YA} > ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.sam
samtools sort ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.sam > ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.bam
samtools view -b -F 2304 ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.bam > tmp.bam
mv tmp.bam ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.bam
samtools index ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${FILTERED_CONDUIT_YA} > ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.sam
samtools sort ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.sam > ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.bam
samtools view -b -F 2304 ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.bam 
samtools index ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${RATTLE_YA} > ../analysis/rattle/cel_YA/rattle_YA.sam
samtools sort ../analysis/rattle/cel_YA/rattle_YA.sam > ../analysis/rattle/cel_YA/rattle_YA.bam
samtools view -b -F 2304 ../analysis/rattle/cel_YA/rattle_YA.bam > tmp.bam
mv tmp.bam ../analysis/rattle/cel_YA/rattle_YA.bam
samtools index ../analysis/rattle/cel_YA/rattle_YA.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${TALC_YA} > ../analysis/talc/cel_YA/cel_YA.sam
samtools sort ../analysis/talc/cel_YA/cel_YA.sam > ../analysis/talc/cel_YA/cel_YA.bam
samtools view -b -F 2304 ../analysis/talc/cel_YA/cel_YA.bam > tmp.bam
mv tmp.bam ../analysis/talc/cel_YA/cel_YA.bam
samtools index ../analysis/talc/cel_YA/cel_YA.bam

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/trinity/cel_YA/trinity_out/Trinity_stranded.fasta > ../analysis/trinity/cel_YA/trinity.sam
samtools sort ../analysis/trinity/cel_YA/trinity.sam > ../analysis/trinity/cel_YA/trinity.bam
samtools view -b -F 2304 ../analysis/trinity/cel_YA/trinity.bam  > tmp.bam
mv tmp.bam ../analysis/trinity/cel_YA/trinity.bam 
samtools index ../analysis/trinity/cel_YA/trinity.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/SPAdes/cel_YA/transcripts_stranded.fasta > ../analysis/SPAdes/cel_YA/spades.sam
samtools sort ../analysis/SPAdes/cel_YA/spades.sam > ../analysis/SPAdes/cel_YA/spades.bam
samtools view -b -F 2304 ../analysis/SPAdes/cel_YA/spades.bam > tmp.bam
mv tmp.bam ../analysis/SPAdes/cel_YA/spades.bam
samtools index ../analysis/SPAdes/cel_YA/spades.bam 

bedtools bamtobed -bed12 -i ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.bam > ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.bed
bedtools bamtobed -bed12 -i ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.bam > ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.bed
bedtools bamtobed -bed12 -i ../analysis/rattle/cel_YA/rattle_YA.bam > ../analysis/rattle/cel_YA/rattle_YA.bed
bedtools bamtobed -bed12 -i ../analysis/talc/cel_YA/cel_YA.bam > ../analysis/talc/cel_YA/cel_YA.bed
bedtools bamtobed -bed12 -i ../analysis/trinity/cel_YA/trinity.bam > ../analysis/trinity/cel_YA/trinity.bed
bedtools bamtobed -bed12 -i ../analysis/SPAdes/cel_YA/spades.bam > ../analysis/SPAdes/cel_YA/spades.bed

conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.bed -o ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.gtf
conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.bed -o ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.gtf
conduitUtils  bed2gtf -s -i ../analysis/rattle/cel_YA/rattle_YA.bed -o ../analysis/rattle/cel_YA/rattle_YA.gtf
conduitUtils  bed2gtf -s -i ../analysis/talc/cel_YA/cel_YA.bed -o ../analysis/talc/cel_YA/cel_YA.gtf
conduitUtils  bed2gtf -s -i ../analysis/trinity/cel_YA/trinity.bed -o ../analysis/trinity/cel_YA/trinity.gtf
conduitUtils  bed2gtf -s -i ../analysis/SPAdes/cel_YA/spades.bed -o ../analysis/SPAdes/cel_YA/spades.gtf

gffcompare -o ../analysis/GFFcompare/cel_YA/cel_YA_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.gtf ../analysis/rattle/cel_YA/rattle_YA.gtf ../analysis/talc/cel_YA/cel_YA.gtf ../analysis/trinity/cel_YA/trinity.gtf ../analysis/SPAdes/cel_YA/spades.gtf ../analysis/Stringtie2/cel_YA/merged.gtf
gffcompare -o ../analysis/GFFcompare/cel_YA/cel_YA_filtered_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_YA/stringent_output_dir/filtered_stringent_conduit_YA.gtf

CONDUIT_GA="../analysis/conduit/cel_GA/stringent_output_dir/conduit_final_consensuses.fa"
FILTERED_CONDUIT_GA="../analysis/conduit/cel_GA/stringent_output_dir/filtered_conduit_final_consensuses.fa"
RATTLE_GA="../analysis/rattle/cel_GA/transcriptome.fq"
TALC_GA="../analysis/talc/cel_GA/cel_GA.fa"
TRINITY_GA="../analysis/trinity/cel_GA/trinity_out/Trinity.fasta"
SPADES_GA="../analysis/SPAdes/cel_GA/transcripts.fasta"

conduitUtils strandTranscripts -i ${TRINITY_GA} -o ../analysis/trinity/cel_GA/trinity_out/Trinity_stranded.fasta
conduitUtils strandTranscripts -i ${SPADES_GA} -o ../analysis/SPAdes/cel_GA/transcripts_stranded.fasta

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${CONDUIT_GA} > ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.sam
samtools sort ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.sam > ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.bam
samtools view -b -F 2304 ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.bam 
samtools index ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${FILTERED_CONDUIT_GA} > ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.sam
samtools sort ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.sam > ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.bam
samtools view -b -F 2304 ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.bam 
samtools index ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${RATTLE_GA} > ../analysis/rattle/cel_GA/rattle_GA.sam
samtools sort ../analysis/rattle/cel_GA/rattle_GA.sam > ../analysis/rattle/cel_GA/rattle_GA.bam
samtools view -b -F 2304 ../analysis/rattle/cel_GA/rattle_GA.bam  > tmp.bam
mv tmp.bam ../analysis/rattle/cel_GA/rattle_GA.bam 
samtools index ../analysis/rattle/cel_GA/rattle_GA.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${TALC_GA} > ../analysis/talc/cel_GA/cel_GA.sam
samtools sort ../analysis/talc/cel_GA/cel_GA.sam > ../analysis/talc/cel_GA/cel_GA.bam
samtools view -b -F 2304 ../analysis/talc/cel_GA/cel_GA.bam > tmp.bam
mv tmp.bam ../analysis/talc/cel_GA/cel_GA.bam
samtools index ../analysis/talc/cel_GA/cel_GA.bam

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/trinity/cel_GA/trinity_out/Trinity_stranded.fasta > ../analysis/trinity/cel_GA/trinity.sam
samtools sort ../analysis/trinity/cel_GA/trinity.sam > ../analysis/trinity/cel_GA/trinity.bam
samtools view -b -F 2304 ../analysis/trinity/cel_GA/trinity.bam  > tmp.bam
mv tmp.bam ../analysis/trinity/cel_GA/trinity.bam 
samtools index ../analysis/trinity/cel_GA/trinity.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/SPAdes/cel_GA/transcripts_stranded.fasta > ../analysis/SPAdes/cel_GA/spades.sam
samtools sort ../analysis/SPAdes/cel_GA/spades.sam > ../analysis/SPAdes/cel_GA/spades.bam
samtools view -b -F 2304 ../analysis/SPAdes/cel_GA/spades.bam > tmp.bam
mv tmp.bam ../analysis/SPAdes/cel_GA/spades.bam
samtools index ../analysis/SPAdes/cel_GA/spades.bam 

bedtools bamtobed -bed12 -i ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.bam > ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.bed
bedtools bamtobed -bed12 -i ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.bam > ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.bed
bedtools bamtobed -bed12 -i ../analysis/rattle/cel_GA/rattle_GA.bam > ../analysis/rattle/cel_GA/rattle_GA.bed
bedtools bamtobed -bed12 -i ../analysis/talc/cel_GA/cel_GA.bam > ../analysis/talc/cel_GA/cel_GA.bed
bedtools bamtobed -bed12 -i ../analysis/trinity/cel_GA/trinity.bam > ../analysis/trinity/cel_GA/trinity.bed
bedtools bamtobed -bed12 -i ../analysis/SPAdes/cel_GA/spades.bam > ../analysis/SPAdes/cel_GA/spades.bed

conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.bed -o ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.gtf
conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.bed -o ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.gtf
conduitUtils  bed2gtf -s -i ../analysis/rattle/cel_GA/rattle_GA.bed -o ../analysis/rattle/cel_GA/rattle_GA.gtf
conduitUtils  bed2gtf -s -i ../analysis/talc/cel_GA/cel_GA.bed -o ../analysis/talc/cel_GA/cel_GA.gtf
conduitUtils  bed2gtf -s -i ../analysis/trinity/cel_GA/trinity.bed -o ../analysis/trinity/cel_GA/trinity.gtf
conduitUtils  bed2gtf -s -i ../analysis/SPAdes/cel_GA/spades.bed -o ../analysis/SPAdes/cel_GA/spades.gtf

gffcompare/gffcompare -o ../analysis/GFFcompare/cel_GA/cel_GA_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.gtf ../analysis/rattle/cel_GA/rattle_GA.gtf ../analysis/talc/cel_GA/cel_GA.gtf ../analysis/trinity/cel_GA/trinity.gtf ../analysis/SPAdes/cel_GA/spades.gtf ../analysis/Stringtie2/cel_GA/merged.gtf
gffcompare/gffcompare -o ../analysis/GFFcompare/cel_GA/cel_GA_filtered_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_GA/stringent_output_dir/filtered_stringent_conduit_GA.gtf

CONDUIT_MALE="../analysis/conduit/cel_male/stringent_output_dir/conduit_final_consensuses.fa"
FILTERED_CONDUIT_MALE="../analysis/conduit/cel_male/stringent_output_dir/filtered_conduit_final_consensuses.fa"
RATTLE_MALE="../analysis/rattle/cel_male/transcriptome.fq"
TALC_MALE="../analysis/talc/cel_male/cel_male.fa"
TRINITY_MALE="../analysis/trinity/cel_male/trinity_out/Trinity.fasta"
SPADES_MALE="../analysis/SPAdes/cel_male/transcripts.fasta"

conduitUtils strandTranscripts -i ${TRINITY_MALE} -o ../analysis/trinity/cel_male/trinity_out/Trinity_stranded.fasta
conduitUtils strandTranscripts -i ${SPADES_MALE} -o ../analysis/SPAdes/cel_male/transcripts_stranded.fasta

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${CONDUIT_MALE} > ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.sam
samtools sort ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.sam > ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.bam
samtools view -b -F 2304 ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.bam > tmp.bam
mv tmp.bam ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.bam
samtools index ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${FILTERED_CONDUIT_MALE} > ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.sam
samtools sort ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.sam > ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.bam
samtools view -b -F 2304 ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.bam > tmp.bam
mv tmp.bam ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.bam 
samtools index ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${RATTLE_MALE} > ../analysis/rattle/cel_male/rattle_male.sam
samtools sort ../analysis/rattle/cel_male/rattle_male.sam > ../analysis/rattle/cel_male/rattle_male.bam
samtools view -b -F 2304 ../analysis/rattle/cel_male/rattle_male.bam > tmp.bam
mv tmp.bam ../analysis/rattle/cel_male/rattle_male.bam 
samtools index ../analysis/rattle/cel_male/rattle_male.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ${TALC_MALE} > ../analysis/talc/cel_male/cel_male.sam
samtools sort ../analysis/talc/cel_male/cel_male.sam > ../analysis/talc/cel_male/cel_male.bam
samtools view -b -F 2304 ../analysis/talc/cel_male/cel_male.bam > tmp.bam
mv tmp.bam ../analysis/talc/cel_male/cel_male.bam
samtools index ../analysis/talc/cel_male/cel_male.bam

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/trinity/cel_male/trinity_out/Trinity_stranded.fasta > ../analysis/trinity/cel_male/trinity.sam
samtools sort ../analysis/trinity/cel_male/trinity.sam > ../analysis/trinity/cel_male/trinity.bam
samtools view -b -F 2304 ../analysis/trinity/cel_male/trinity.bam  > tmp.bam
mv tmp.bam ../analysis/trinity/cel_male/trinity.bam 
samtools index ../analysis/trinity/cel_male/trinity.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/SPAdes/cel_male/transcripts_stranded.fasta > ../analysis/SPAdes/cel_male/spades.sam
samtools sort ../analysis/SPAdes/cel_male/spades.sam > ../analysis/SPAdes/cel_male/spades.bam
samtools view -b -F 2304 ../analysis/SPAdes/cel_male/spades.bam > tmp.bam
mv tmp.bam ../analysis/SPAdes/cel_male/spades.bam
samtools index ../analysis/SPAdes/cel_male/spades.bam 

bedtools bamtobed -bed12 -i ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.bam > ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.bed
bedtools bamtobed -bed12 -i ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.bam > ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.bed
bedtools bamtobed -bed12 -i ../analysis/rattle/cel_male/rattle_male.bam > ../analysis/rattle/cel_male/rattle_male.bed
bedtools bamtobed -bed12 -i ../analysis/talc/cel_male/cel_male.bam > ../analysis/talc/cel_male/cel_male.bed
bedtools bamtobed -bed12 -i ../analysis/trinity/cel_male/trinity.bam > ../analysis/trinity/cel_male/trinity.bed
bedtools bamtobed -bed12 -i ../analysis/SPAdes/cel_male/spades.bam > ../analysis/SPAdes/cel_male/spades.bed

conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.bed -o ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.gtf
conduitUtils  bed2gtf -s -i ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.bed -o ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.gtf
conduitUtils  bed2gtf -s -i ../analysis/rattle/cel_male/rattle_male.bed -o ../analysis/rattle/cel_male/rattle_male.gtf
conduitUtils  bed2gtf -s -i ../analysis/talc/cel_male/cel_male.bed -o ../analysis/talc/cel_male/cel_male.gtf
conduitUtils  bed2gtf -s -i ../analysis/trinity/cel_male/trinity.bed -o ../analysis/trinity/cel_male/trinity.gtf
conduitUtils  bed2gtf -s -i ../analysis/SPAdes/cel_male/spades.bed -o ../analysis/SPAdes/cel_male/spades.gtf

gffcompare/gffcompare -o ../analysis/GFFcompare/cel_male/cel_male_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_male/stringent_output_dir/stringent_conduit_male.gtf ../analysis/rattle/cel_male/rattle_male.gtf ../analysis/talc/cel_male/cel_male.gtf ../analysis/trinity/cel_male/trinity.gtf ../analysis/SPAdes/cel_male/spades.gtf ../analysis/Stringtie2/cel_male/merged.gtf
gffcompare/gffcompare -o ../analysis/GFFcompare/cel_male/cel_male_filtered_gffcompare -r ../data/references/ce11_UCSC_WB245.gtf ../analysis/conduit/cel_male/stringent_output_dir/filtered_stringent_conduit_male.gtf


CONDUIT_SMALL_NA12878="../analysis/conduit/smaller_NA12878/stringent_output_dir/conduit_final_consensuses.fa"
FILTERED_CONDUIT_SMALL_NA12878="../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_conduit_final_consensuses.fa"
RATTLE_SMALL_NA12878="../analysis/rattle/smaller_NA12878/transcriptome.fq"
TALC_SMALL_NA12878="../analysis/talc/smaller_NA12878/gm12878.fa"
TRINITY_SMALL_NA12878="../analysis/trinity/NA12878/trinity_out/Trinity.fasta"
SPADES_SMALL_NA12878="../analysis/SPAdes/smaller_NA12878/transcripts.fasta"

conduitUtils strandTranscripts -i ${TRINITY_SMALL_NA12878} -o ../analysis/trinity/smaller_NA12878/trinity_out/Trinity_stranded.fasta
conduitUtils strandTranscripts -i ${SPADES_SMALL_NA12878} -o ../analysis/SPAdes/smaller_NA12878/transcripts_stranded.fasta

minimap2 -t 40 -ax splice ../data/references/hg38.fa ${CONDUIT_SMALL_NA12878} > ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.sam
samtools sort ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.sam > ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.bam
samtools view -b -F 2304 ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.bam  > tmp.bam
mv tmp.bam ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.bam 
samtools index ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.bam 

minimap2 -t 40 -ax splice ../data/references/hg38.fa ${FILTERED_CONDUIT_SMALL_NA12878} > ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.sam
samtools sort ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.sam > ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.bam
samtools view -b -F 2304 ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.bam > tmp.bam
mv tmp.bam ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.bam 
samtools index ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.bam 

minimap2 -t 40 -ax splice ../data/references/hg38.fa ${RATTLE_SMALL_NA12878} > ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.sam
samtools sort ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.sam > ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.bam
samtools view -b -F 2304 ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.bam > tmp.bam
mv tmp.bam ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.bam 
samtools index ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.bam 

minimap2 -t 40 -ax splice ../data/references/hg38.fa ${TALC_SMALL_NA12878} > ../analysis/talc/smaller_NA12878/gm12878.sam
samtools sort ../analysis/talc/smaller_NA12878/gm12878.sam > ../analysis/talc/smaller_NA12878/gm12878.bam
samtools view -b -F 2304 ../analysis/talc/smaller_NA12878/gm12878.bam > tmp.bam
mv tmp.bam ../analysis/talc/smaller_NA12878/gm12878.bam
samtools index ../analysis/talc/smaller_NA12878/gm12878.bam

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/trinity/NA12878/trinity_out/Trinity_stranded.fasta > ../analysis/trinity/NA12878/trinity.sam
samtools sort ../analysis/trinity/NA12878/trinity.sam > ../analysis/trinity/NA12878/trinity.bam
samtools view -b -F 2304 ../analysis/trinity/NA12878/trinity.bam  > tmp.bam
mv tmp.bam ../analysis/trinity/NA12878/trinity.bam 
samtools index ../analysis/trinity/NA12878/trinity.bam 

minimap2 -t 40 -ax splice ../data/references/ce11.fa ../analysis/SPAdes/smaller_NA12878/transcripts_stranded.fasta > ../analysis/SPAdes/smaller_NA12878/spades.sam
samtools sort ../analysis/SPAdes/smaller_NA12878/spades.sam > ../analysis/SPAdes/smaller_NA12878/spades.bam
samtools view -b -F 2304 ../analysis/SPAdes/smaller_NA12878/spades.bam > tmp.bam
mv tmp.bam ../analysis/SPAdes/smaller_NA12878/spades.bam
samtools index ../analysis/SPAdes/smaller_NA12878/spades.bam 

bedtools bamtobed -bed12 -i ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.bam > ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.bed
bedtools bamtobed -bed12 -i ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.bam > ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.bed
bedtools bamtobed -bed12 -i ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.bam > ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.bed
bedtools bamtobed -bed12 -i ../analysis/talc/smaller_NA12878/gm12878.bam > ../analysis/talc/smaller_NA12878/gm12878.bed
bedtools bamtobed -bed12 -i ../analysis/trinity/NA12878/trinity.bam > ../analysis/trinity/NA12878/trinity.bed
bedtools bamtobed -bed12 -i ../analysis/SPAdes/smaller_NA12878/spades.bam > ../analysis/SPAdes/smaller_NA12878/spades.bed

conduitUtils  bed2gtf -s -i ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.bed -o ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.gtf
conduitUtils  bed2gtf -s -i ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.bed -o ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.gtf
conduitUtils  bed2gtf -s -i ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.bed -o ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.gtf
conduitUtils  bed2gtf -s -i ../analysis/talc/smaller_NA12878/gm12878.bed -o ../analysis/talc/smaller_NA12878/gm12878.gtf
conduitUtils  bed2gtf -s -i ../analysis/trinity/NA12878/trinity.bed -o ../analysis/trinity/NA12878/trinity.gtf
conduitUtils  bed2gtf -s -i ../analysis/SPAdes/smaller_NA12878/spades.bed -o ../analysis/SPAdes/smaller_NA12878/spades.gtf

gffcompare -o ../analysis/GFFcompare/smaller_GM12878/small_GM12878_gffcompare -r ../data/references/hg38_GENCODE_v32.gtf  ../analysis/conduit/smaller_NA12878/stringent_output_dir/stringent_conduit_small_NA12878.gtf ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.gtf ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.gtf ../analysis/talc/smaller_NA12878/gm12878.gtf ../analysis/trinity/NA12878/trinity.gtf ../analysis/SPAdes/smaller_NA12878/spades.gtf ../analysis/Stringtie2/smaller_NA12878/merged.gtf
gffcompare -o ../analysis/GFFcompare/smaller_GM12878/small_GM12878_filtered_gffcompare -r ../data/references/hg38_GENCODE_v32.gtf ../analysis/conduit/smaller_NA12878/stringent_output_dir/filtered_stringent_conduit_small_NA12878.gtf 

conda deactivate