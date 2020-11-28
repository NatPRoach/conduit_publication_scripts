#!/bin/bash

pushd cel_L1/ || exit
    ./get_L1_data.sh
popd || exit

pushd cel_L2/ || exit
    ./get_L2_data.sh
popd || exit

pushd cel_L3/ || exit
    ./get_L3_data.sh
popd || exit

pushd cel_L4/ || exit
    ./get_L4_data.sh
popd || exit

pushd cel_YA/ || exit
    ./get_YA_data.sh
popd || exit

pushd cel_GA/ || exit
    ./get_GA_data.sh
popd || exit

pushd cel_male/ || exit
    ./get_male_data.sh
popd || exit

pushd smaller_NA12878/ || exit
    ./get_smaller_NA12878_data.sh
popd || exit