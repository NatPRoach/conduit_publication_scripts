#!/bin/bash

source ~/miniconda3/etc/profile.d/conda.sh
conda activate conduit-benchmarking

SAMPLE_LIST=( cel_L1 cel_L2 cel_L3 cel_L4 cel_YA cel_GA cel_male smaller_NA12878 nivar )

for SAMPLE in "${SAMPLE_LIST[@]}";
do 
    conduitUtils filterFASTA -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/conduit_final_consensuses.fa -o ../../analysis/conduit/${SAMPLE}/stringent_output_dir/filtered_conduit_final_consensuses.fa
    conduitUtils translate -i ../../analysis/Stringtie2/${SAMPLE}/ont.fa  -o ../../analysis/Stringtie2/${SAMPLE}/ont_predicted_protein.fa
    conduitUtils translate -i ../../analysis/Stringtie2/${SAMPLE}/illumina.fa  -o ../../analysis/Stringtie2/${SAMPLE}/illumina_predicted_protein.fa
    conduitUtils translate -i ../../analysis/Stringtie2/${SAMPLE}/merged.fa  -o ../../analysis/Stringtie2/${SAMPLE}/merged_predicted_protein.fa
    conduitUtils translate -s -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/conduit_final_consensuses.fa  -o ../../analysis/conduit/${SAMPLE}/stringent_output_dir/predicted_protein.fa
    conduitUtils translate -i ../../analysis/trinity/${SAMPLE}/trinity_out/Trinity.fasta  -o ../../analysis/trinity/${SAMPLE}/trinity_out/predicted_protein.fa
    conduitUtils translate -i ../../analysis/SPAdes/${SAMPLE}/transcripts.fasta -o ../../analysis/SPAdes/${SAMPLE}/predicted_protein.fa
    conduitUtils translate -i ../../analysis/talc/${SAMPLE}/${SAMPLE}.fa -o ../../analysis/talc/${SAMPLE}/predicted_protein.fa
    conduitUtils translate -q -i ../../analysis/rattle/${SAMPLE}/transcriptome.fq  -o ../../analysis/rattle/${SAMPLE}/predicted_protein.fa

    echo "Stringtie ONT Assembly"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/Stringtie2/${SAMPLE}/ont_predicted_protein.fa -o tmp.txt
    echo ""
    echo "Stringtie Illumina Assembly"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/Stringtie2/${SAMPLE}/illumina_predicted_protein.fa -o tmp.txt
    echo ""
    echo "Stringtie Merged Assembly"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/Stringtie2/${SAMPLE}/merged_predicted_protein.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/predicted_protein.fa -o tmp.txt
    echo ""
    echo "Trinity Assembly"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/trinity/${SAMPLE}/trinity_out/predicted_protein.fa -o tmp.txt
    echo ""
    echo "rnaSPAdes Assembly"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/SPAdes/${SAMPLE}/predicted_protein.fa -o tmp.txt
    echo ""
    echo "TALC Assembly"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/talc/${SAMPLE}/predicted_protein.fa -o tmp.txt
    echo ""
    echo "RATTLE Assembly"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/rattle/${SAMPLE}/predicted_protein.fa -o tmp.txt
    echo ""

    conduitUtils splitFASTA -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/predicted_protein.fa -o ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein 
    echo "CONDUIT Assembly 1-1"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_1-1.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 2-4"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_2-4.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 5-9"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_5-9.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 10-19"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_10-19.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 20-39"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_20-39.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 40-79"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_40-79.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 80-159"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_80-159.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 160-319"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_160-319.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 320-639"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_320-639.fa -o tmp.txt
    echo ""
    echo "CONDUIT Assembly 640+"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/split_predicted_protein_640+.fa -o tmp.txt
    echo ""

    conduitUtils filterFASTA -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/predicted_protein.fa -o ../../analysis/conduit/${SAMPLE}/stringent_output_dir/filtered_predicted_protein.fa
    echo "CONDUIT Assembly Filtered"
    conduitUtils compareFASTA -r ../../data/references/elegans_uniprot.fasta -i ../../analysis/conduit/${SAMPLE}/stringent_output_dir/filtered_predicted_protein.fa -o tmp.txt
    echo ""
done

conda deactivate

