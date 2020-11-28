# conduit_publication_scripts


```
conda create -n conduit-benchmarking \
    conduit \
    minimap2 \
    hisat2 \
    nanocomp \
    gffcompare \
    rattle \
    r-base \
    r-cowplot \
    r-dplyr \
    r-here \
    r-ggplot2 \
    r-readxl \
    r-gridextra \
    ucsc-genepredtobed \
    ucsc-gtftogenepred
conda activate conduit-benchmarking
./run_all.sh
```