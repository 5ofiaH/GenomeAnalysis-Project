#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 06:00:00
#SBATCH -J braker_analyses_01
#SBATCH --mail-type=ALL
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se
#SBATCH --output flagstat.out
# Load modules
module load bioinfo-tools
module load samtools/1.8

bams=/proj/uppmax2024-2-7/nobackup/work/shv/star/2results
bams_star_2=/home/soffiahv/genome_analysis/analyses/01.1_preprocessing_RNA/star2/results

samtools flagstat $bams/SRR6040092_Aligned.sortedByCoord.out.bam
samtools flagstat $bams/SRR6040094_Aligned.sortedByCoord.out.bam

#samtools flagstat $bams_star_2/SRR6040092_Aligned.sortedByCoord.out.bam
