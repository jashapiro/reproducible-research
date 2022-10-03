#!/bin/bash
set -euo pipefail

# This script downloads and subsets FASTQ files which can be used during workshops when
#  internet speed is limited and prohibits timely downloading of the full FASTQ files.


# Function to curl, subset, and zip a FASTQ file
# Provide a single argument: the FASTQ name, without `.gz` extension
function subset_fastq() {
    # Grab the file and unzip
    curl -O https://sra-download.ncbi.nlm.nih.gov/traces/sra63/SRZ/011518/SRR11518889/$1.gz
    # overwrite if already exists
    gunzip -f $1.gz > $1

    # Subset to first 10,000 reads (40000 lines)
    echo "$(head -n 40000 $1)" > $1

    # Zip the new file in case instructors wish to do the whole `.gz` experience
    gzip -c $1 > $1.gz
}


subset_fastq "NC16_S1_L004_R1_001.fastq"
subset_fastq "NC16_S1_L004_R2_001.fastq"

