#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:30:00
#SBATCH -J bwa_analyses_01
#SBATCH --mail-type=ALL 
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se

# Load modules
module load bioinfo-tools
module load bwa	
module load samtools

ref=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/Flye/assembly.fasta
reads=/home/soffiahv/genome_analysis/data/raw_data/illumina_data
out=/domus/h1/soffiahv/genome_analysis/analyses/01_preprocessing/bwa

bwa index $ref

# Run BWA MEM for single-end reads
#bwa mem -t 2 $ref $reads/SRR6058604_scaffold_06.1P.fastq.gz $reads/SRR6058604_scaffold_06.1U.fastq.gz
bwa mem -t 2 $ref $reads/SRR6058604_scaffold_06.1P.fastq.gz $reads/SRR6058604_scaffold_06.2P.fastq.gz > $out/bwa_mem_alignments.sam

samtools sort $out/bwa_mem_alignments.sam -o $out/sorted/bwa_mem_alignments.bam
samtools index $out/sorted/bwa_mem_alignments.bam -o $out/sorted/bwa_mem_alignments.bai
