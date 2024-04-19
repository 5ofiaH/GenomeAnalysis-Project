#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:50:00
#SBATCH -J pilon_analyses_01
#SBATCH --mail-type=ALL 
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se

# Load modules
module load bioinfo-tools
module load Pilon

echo "Modules were Loaded"

resflye=/domus/h1/soffiahv/genome_analysis/analyses/02_genome_assembly/Flye/assembly.fasta
resbwa=/domus/h1/soffiahv/genome_analysis/analyses/01_preprocessing/bwa/sorted/bwa_mem_alignments.bam
out=/domus/h1/soffiahv/genome_analysis/analyses/02_genome_assembly/pilon

java -jar $PILON_HOME/pilon.jar --genome $resflye --frags $resbwa --output $out --threads 2
