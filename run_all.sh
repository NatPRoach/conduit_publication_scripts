#!/bin/bash

# Declare relevant constants for benchmarking
THREADS="20"


# # Install requisite tools
# git clone --recurse-submodules https://github.com/comprna/RATTLE
# pushd RATTLE || exit
# ./build.sh
# popd || exit

SAMPLE_LIST=( cel_L1 cel_L2 cel_L3 cel_L4 cel_YA cel_GA cel_male smaller_NA12878 nivar )

mkdir analysis/
pushd analysis || exit
    DIR_LIST1=( conduit  GFFcompare  NanoComp  rattle  SPAdes  Stringtie2  talc  trinity )
    for DIR1 in "${DIR_LIST1[@]}";
    do
        mkdir ${DIR1}
        pushd "${DIR1}" || exit
        for DIR2 in "${SAMPLE_LIST[@]}";
        do
            mkdir "${DIR2}"
        done
        popd || exit
    done
popd || exit


pushd data/ || exit
./get_data.sh
popd || exit

pushd scripts/ || exit
    mkdir logs/
    pushd logs/ || exit
    wget 
    chmod +x
    wget 
    chmod +x 
    for DIR1 in "${SAMPLE_LIST[@]}";
    do
        mkdir "${DIR1}"
    done
    popd || exit
    ./run_CONDUIT.sh "${THREADS}"
    ./run_SPAdes.sh "${THREADS}"
    ./run_TALC.sh "${THREADS}"
    ./run_Trinity.sh "${THREADS}"
    ./run_Stringtie2.sh "${THREADS}"
    ./run_conduitUtils.sh
    ./run_NanoComp.sh "${THREADS}"
popd || exit

pushd figure_generation || exit
    Rscript benchmark_time.R
    Rscript conduit_figures.R
popd || exit