#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 06:00:00
#SBATCH -J EGG
#SBATCH --mail-type=ALL 
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se
#SBATCH --output eggnog.out

module load bioinfo-tools
module load eggNOG-mapper
module load gffread

gffs=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/braker/braker/Durio_zibethinus/augustus.hints.gff3
genome=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/repeatmasker/pilon.fasta.masked

gffread $gffs -g $genome -w output.fasta

#running eggnog
emapper.py -m diamond -i output.fasta --itype genome -o eggnog_out





