# conduit_publication_scripts

To generate the conda environment with most of the necessary tools to run this analysis run:
```
conda create -n conduit-benchmarking \
    conduit \
    gffcompare \
    hisat2 \
    minimap2 \
    nanocomp \
    rattle \
    r-base \
    r-cowplot \
    r-dplyr \
    r-ggplot2 \
    r-gridextra \
    r-here \
    r-readxl \
    spades \
    trinity \
    ucsc-genepredtobed \
    ucsc-gtftogenepred
```
Activate the environment with:
```
conda activate conduit-benchmarking
```
Then, install jellyfish with:
```
conda install -c bioconda jellyfish
```
(This step is necessary to be performed separately as there is a package on conda-forge called jellyfish that can resolve first depending on the priority of your default channel)


Note this analysis requires additional packages RATTLE and TALC, and their requisite dependencies. Please ensure these tools are in `$PATH`


Then run the entire analysis with:
```
./run_all.sh
```