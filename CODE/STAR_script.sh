#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 00:30:00
#SBATCH -J star_test2
#SBATCH --mail-type=ALL
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se
#SBATCH --output star.out

# Load modules
module load bioinfo-tools
module load star
module load gcc/6.2.0 star/2.5.2b

fastq=/home/soffiahv/genome_analysis/data/trimmed_data
ref_RM_fastamasked=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/repeatmasker/pilon.fasta.masked
genome_indeces=/home/soffiahv/genome_analysis/analyses/01.1_preprocessing_RNA/star2/index
#out=/home/soffiahv/genome_analysis/analyses/01.1_preprocessing_RNA/star2/results
out=/proj/uppmax2024-2-7/nobackup/work/shv/star/2results

#  CREATING A GENOME INDEX
STAR --runThreadN 6 \
    --runMode genomeGenerate \
    --genomeDir $genome_indeces \
    --genomeFastaFiles $ref_RM_fastamasked \

# RUNNING STAR without loop

STAR --genomeDir $genome_indeces \
    --runThreadN 6 \
    --readFilesIn $fastq/SRR6040092_scaffold_06.1.fastq.gz $fastq/SRR6040092_scaffold_06.2.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $out/SRR6040092_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard

STAR --genomeDir $genome_indeces \
    --runThreadN 6 \
    --readFilesIn $fastq/SRR6040093_scaffold_06.1.fastq.gz $fastq/SRR6040093_scaffold_06.2.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $out/SRR6040093_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard

STAR --genomeDir $genome_indeces \
    --runThreadN 6 \
    --readFilesIn $fastq/SRR6040094_scaffold_06.1.fastq.gz $fastq/SRR6040094_scaffold_06.2.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $out/SRR6040094_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard

STAR --genomeDir $genome_indeces \
    --runThreadN 6 \
    --readFilesIn $fastq/SRR6040096_scaffold_06.1.fastq.gz $fastq/SRR6040096_scaffold_06.2.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $out/SRR6040096_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard

STAR --genomeDir $genome_indeces \
    --runThreadN 6 \
    --readFilesIn $fastq/SRR6040097_scaffold_06.1.fastq.gz $fastq/SRR6040097_scaffold_06.2.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $out/SRR6040097_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard

STAR --genomeDir $genome_indeces \
    --runThreadN 6 \
    --readFilesIn $fastq/SRR6156066_scaffold_06.1.fastq.gz $fastq/SRR6156066_scaffold_06.2.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $out/SRR6156066_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard

STAR --genomeDir $genome_indeces \
    --runThreadN 6 \
    --readFilesIn $fastq/SRR6156067_scaffold_06.1.fastq.gz $fastq/SRR6156067_scaffold_06.2.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $out/SRR6156067_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard

STAR --genomeDir $genome_indeces \
    --runThreadN 6 \
    --readFilesIn $fastq/SRR6156069_scaffold_06.1.fastq.gz $fastq/SRR6156069_scaffold_06.2.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $out/SRR6156069_ \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard



