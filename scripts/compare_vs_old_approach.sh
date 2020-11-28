#!/bin/bash

# ../../gffcompare/gffcompare -o ../analysis/GFFcompare/old_approach_comparisons/L1 -r ../data/references/old_approach/L1.gtf ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.gtf
# ../../gffcompare/gffcompare -o ../analysis/GFFcompare/old_approach_comparisons/L2 -r ../data/references/old_approach/L2.gtf ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.gtf
# ../../gffcompare/gffcompare -o ../analysis/GFFcompare/old_approach_comparisons/L3 -r ../data/references/old_approach/L3.gtf ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.gtf
# ../../gffcompare/gffcompare -o ../analysis/GFFcompare/old_approach_comparisons/L4 -r ../data/references/old_approach/L4.gtf ../analysis/conduit/cel_L4/stringent_output_dir3/stringent_conduit_L4.gtf
# ../../gffcompare/gffcompare -o ../analysis/GFFcompare/old_approach_comparisons/YA -r ../data/references/old_approach/YA.gtf ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.gtf
# ../../gffcompare/gffcompare -o ../analysis/GFFcompare/old_approach_comparisons/GA -r ../data/references/old_approach/GA.gtf ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.gtf
# ../../gffcompare/gffcompare -o ../analysis/GFFcompare/old_approach_comparisons/ML -r ../data/references/old_approach/ML.gtf ../analysis/conduit/cel_male/stringent_output_dir3/stringent_conduit_male.gtf

conduitUtils idNovelIsoforms -i ../analysis/conduit/cel_L1/stringent_output_dir/stringent_conduit_L1.gtf  --r2 ../data/references/ce11_UCSC_WB245.gtf -r ../data/references/old_approach/L1.gtf
conduitUtils idNovelIsoforms -i ../analysis/conduit/cel_L2/stringent_output_dir/stringent_conduit_L2.gtf  --r2 ../data/references/ce11_UCSC_WB245.gtf -r ../data/references/old_approach/L2.gtf
conduitUtils idNovelIsoforms -i ../analysis/conduit/cel_L3/stringent_output_dir/stringent_conduit_L3.gtf  --r2 ../data/references/ce11_UCSC_WB245.gtf -r ../data/references/old_approach/L3.gtf
conduitUtils idNovelIsoforms -i ../analysis/conduit/cel_L4/stringent_output_dir3/stringent_conduit_L4.gtf --r2 ../data/references/ce11_UCSC_WB245.gtf -r ../data/references/old_approach/L4.gtf
conduitUtils idNovelIsoforms -i ../analysis/conduit/cel_YA/stringent_output_dir/stringent_conduit_YA.gtf  --r2 ../data/references/ce11_UCSC_WB245.gtf -r ../data/references/old_approach/YA.gtf
conduitUtils idNovelIsoforms -i ../analysis/conduit/cel_GA/stringent_output_dir/stringent_conduit_GA.gtf  --r2 ../data/references/ce11_UCSC_WB245.gtf -r ../data/references/old_approach/GA.gtf
conduitUtils idNovelIsoforms -i ../analysis/conduit/cel_male/stringent_output_dir3/stringent_conduit_male.gtf --r2 ../data/references/ce11_UCSC_WB245.gtf -r ../data/references/old_approach/ML.gtf
