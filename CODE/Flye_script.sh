#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:30:00
#SBATCH -J Flye_analyses_02
#SBATCH --mail-type=ALL 
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se

# Load modules
module load bioinfo-tools
module load Flye

echo "Modules were Loaded"

# Flye is a  de novo assembler for long reads (PacBio and Nanopore).

# Commands

base_dir=/domus/h1/soffiahv/genome_analysis
in=$base_dir/data/raw_data/pacbio_data
out=$base_dir/analyses/02_genome_assembly/Flye

echo "Flye started running"

# Run Flye
flye --pacbio-raw $in/SRR6037732_scaffold_06.fq.gz --out-dir $out --genome-size 25m --threads 4

echo "End of Flye"



