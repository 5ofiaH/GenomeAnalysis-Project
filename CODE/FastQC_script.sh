#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:15:00
#SBATCH -J FastQC_analyses_01
#SBATCH --mail-type=ALL 
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se

# Load modules
module load bioinfo-tools
module load FastQC
module load MultiQC


# Commands

base_dir=/home/soffiahv/genome_analysis
in=$base_dir/data/raw_data
out=$base_dir/analyses/01_preprocessing

# Run FastQC for Illumina datcda
fastqc -o $out/illumina -t 2 $in/illumina_data/*.gz  

# Run FastQC for PacBio data
fastqc -o $out/pacbio -t 2 $in/pacbio_data/*.gz

#aggregate_reports

multiqc $out -o $out/reports -p -v -f > $out/reports/output.txt


