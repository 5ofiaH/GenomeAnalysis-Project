#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:40:00
#SBATCH -J repeatmasker_analyses_01
#SBATCH --mail-type=ALL 
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se

# Load modules
module load bioinfo-tools
module load RepeatMasker

file=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/pilon.fasta
out=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/repeatmasker 

echo "Modules were Loaded"
RepeatMasker -species durio -dir $out -gff -e ncbi -s $file 

