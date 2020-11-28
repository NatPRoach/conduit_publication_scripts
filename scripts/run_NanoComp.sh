#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

# CONDUIT_L4="../analysis/conduit/cel_L4/stringent_output_dir2/conduit_final_consensuses.fa"
# RATTLE_L4="../analysis/rattle/cel_L4/transcriptome.fq"
# TALC_L4="../analysis/talc/cel_L4/cel_L4.fa"
# TRINITY_L4="../analysis/trinity/cel_L4/trinity_out/Trinity.fasta"
# SPADES_L4="../analysis/SPAdes/cel_L4/transcripts.fasta"

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_L4} > ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir/stringent_conduit_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${RATTLE_L4} > ../analysis/rattle/cel_L4/rattle_L4.sam
# samtools sort ../analysis/rattle/cel_L4/rattle_L4.sam > ../analysis/rattle/cel_L4/rattle_L4.bam
# samtools index ../analysis/rattle/cel_L4/rattle_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${TALC_L4} > ../analysis/talc/cel_L4/cel_L4.sam
# samtools sort ../analysis/talc/cel_L4/cel_L4.sam > ../analysis/talc/cel_L4/cel_L4.bam
# samtools index ../analysis/talc/cel_L4/cel_L4.bam

# minimap2 -ax splice ../data/references/ce11.fa ${TRINITY_L4} > ../analysis/trinity/cel_L4/trinity.sam
# samtools sort ../analysis/trinity/cel_L4/trinity.sam > ../analysis/trinity/cel_L4/trinity.bam
# samtools index ../analysis/trinity/cel_L4/trinity.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${SPADES_L4} > ../analysis/SPAdes/cel_L4/spades.sam
# samtools sort ../analysis/SPAdes/cel_L4/spades.sam > ../analysis/SPAdes/cel_L4/spades.bam
# samtools index ../analysis/SPAdes/cel_L4/spades.bam 

# NanoComp -o ../analysis/NanoComp/cel_L4/ --format pdf --names CONDUIT filtered_CONDUIT RATTLE rnaSPAdes TALC Trinity --bam ../analysis/conduit/cel_L4/stringent_output_dir3/stringent_conduit_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir3/filtered_stringent_conduit_L4.bam ../analysis/rattle/cel_L4/rattle_L4.bam ../analysis/SPAdes/cel_L4/spades.bam  ../analysis/talc/cel_L4/cel_L4.bam  ../analysis/trinity/cel_L4/trinity.bam -c "#8586A7" "#8586A7" "#547C9B" "#B45D52" "#789F5C" "#D8B847"

# NanoComp -o ../analysis/NanoComp/smaller_NA12878/ --format pdf --names CONDUIT filtered_CONDUIT RATTLE rnaSPAdes TALC Trinity --bam ../analysis/conduit/smaller_NA12878/stringent_output_dir3/stringent_conduit_small_NA12878.bam ../analysis/conduit/smaller_NA12878/stringent_output_dir3/filtered_stringent_conduit_small_NA12878.bam ../analysis/rattle/smaller_NA12878/rattle_small_NA12878.bam ../analysis/SPAdes/smaller_NA12878/spades.bam  ../analysis/talc/smaller_NA12878/gm12878.bam  ../analysis/trinity/NA12878/trinity.bam -c "#8586A7" "#8586A7" "#547C9B" "#B45D52" "#789F5C" "#D8B847"

# CONDUIT_MALE="../analysis/conduit/cel_male/stringent_output_dir2/conduit_final_consensuses.fa"
# RATTLE_MALE="../analysis/rattle/cel_male/transcriptome.fq"
# TALC_MALE="../analysis/talc/cel_male/cel_male.fa"
# TRINITY_MALE="../analysis/trinity/cel_male/trinity_out/Trinity.fasta"
# SPADES_MALE="../analysis/SPAdes/cel_male/transcripts.fasta"

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_MALE} > ../analysis/conduit/cel_male/stringent_output_dir2/stringent_conduit_male.sam
# samtools sort ../analysis/conduit/cel_male/stringent_output_dir2/stringent_conduit_male.sam > ../analysis/conduit/cel_male/stringent_output_dir2/stringent_conduit_male.bam
# samtools index ../analysis/conduit/cel_male/stringent_output_dir2/stringent_conduit_male.bam

# minimap2 -ax splice ../data/references/ce11.fa ${RATTLE_MALE} > ../analysis/rattle/cel_male/rattle_male.sam
# samtools sort ../analysis/rattle/cel_male/rattle_male.sam > ../analysis/rattle/cel_male/rattle_male.bam
# samtools index ../analysis/rattle/cel_male/rattle_male.bam

# minimap2 -ax splice ../data/references/ce11.fa ${TALC_MALE} > ../analysis/talc/cel_male/cel_male.sam
# samtools sort ../analysis/talc/cel_male/cel_male.sam > ../analysis/talc/cel_male/cel_male.bam
# samtools index ../analysis/talc/cel_male/cel_male.bam

# minimap2 -ax splice ../data/references/ce11.fa ${TRINITY_MALE} > ../analysis/trinity/cel_male/trinity.sam
# samtools sort ../analysis/trinity/cel_male/trinity.sam > ../analysis/trinity/cel_male/trinity.bam
# samtools index ../analysis/trinity/cel_male/trinity.bam

# minimap2 -ax splice ../data/references/ce11.fa ${SPADES_MALE} > ../analysis/SPAdes/cel_male/spades.sam
# samtools sort ../analysis/SPAdes/cel_male/spades.sam > ../analysis/SPAdes/cel_male/spades.bam
# samtools index ../analysis/SPAdes/cel_male/spades.bam

# NanoComp -o ../analysis/NanoComp/cel_male/ --format pdf --names CONDUIT filtered_CONDUIT RATTLE TALC Trinity rnaSPAdes --bam ../analysis/conduit/cel_male/stringent_output_dir3/stringent_conduit_male.bam  ../analysis/conduit/cel_male/stringent_output_dir3/filtered_stringent_conduit_male.bam ../analysis/rattle/cel_male/rattle_male.bam  ../analysis/talc/cel_male/cel_male.bam  ../analysis/trinity/cel_male/trinity.bam ../analysis/SPAdes/cel_male/spades.bam 


# CONDUIT_PREFIX="../analysis/conduit/cel_L4/stringent_output_dir2/conduit_consensuses_iter"

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}0.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}1.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}2.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}3.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}4.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}5.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_L4} > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.bam 

# NanoComp -o ../analysis/NanoComp/cel_L4/iterations/ --format pdf --names Iter0 Iter1 Iter2 Iter3 Iter4 Iter5 Final --bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.bam

# CONDUIT_PREFIX="../analysis/conduit/cel_male/stringent_output_dir2/conduit_consensuses_iter"

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}0.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}1.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}2.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}3.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}4.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_PREFIX}5.fa > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.bam 

# minimap2 -ax splice ../data/references/ce11.fa ${CONDUIT_L4} > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.sam
# samtools sort ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.sam > ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.bam
# samtools index ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.bam 

# NanoComp -o ../analysis/NanoComp/cel_L4/iterations/ --format pdf --names Iter0 Iter1 Iter2 Iter3 Iter4 Iter5 Final --bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter0_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter1_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter2_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter3_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter4_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_iter5_L4.bam ../analysis/conduit/cel_L4/stringent_output_dir2/stringent_conduit_final_L4.bam

# conda deactivate
