#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 06:00:00
#SBATCH -J braker_analyses_01
#SBATCH --mail-type=ALL
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se

# Load modules
module load bioinfo-tools
module load braker/2.1.1_Perl5.24.1
module load augustus/3.2.3_Perl5.24.1
module load bamtools/2.5.1
module load blast/2.9.0+
module load GenomeThreader/1.7.0
module load samtools/1.8
module load GeneMark/4.33-es_Perl5.24.1


cp -vf /sw/bioinfo/GeneMark/4.33-es/snowy/gm_key $HOME/.gm_key

# Copy configuration file for AUGUSTUS
source $AUGUSTUS_CONFIG_COPY
chmod a+w -R /home/soffiahv/genome_analysis/analyses/02_genome_assembly/braker/augustus_config/species/

bams=/proj/uppmax2024-2-7/nobackup/work/shv/star/2results

rna_seq_bamfiles_dir=/proj/uppmax2024-2-7/nobackup/work/shv/star/results/
#bams=/proj/uppmax2024-2-7/nobackup/work/shv/star/results/bams

export AUGUSTUS_CONFIG_PATH=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/braker/augustus_config
export AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin
export AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts
export GENEMARK_PATH=/sw/bioinfo/GeneMark/4.33-es/snowy

braker.pl --genome=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/repeatmasker/pilon.fasta.masked \
          --bam=$bams/SRR6040092_Aligned.sortedByCoord.out.bam,$bams/SRR6040093_Aligned.sortedByCoord.out.bam,$bams/SRR6040094_Aligned.sortedByCoord.out.bam,$bams/SRR6040096_Aligned.sortedByCoord.out.bam,$bams/SRR6156066_Aligned.sortedByCoord.out.bam,$bams/SRR6156067_Aligned.sortedByCoord.out.bam,$bams/SRR6156069_Aligned.sortedByCoord.out.bam,$bams/SRR6040097_Aligned.sortedByCoord.out.bam \
          --cores 8 \
          --gff3 \
          --species=Durio_zibethinus \
          --useexisting \
          --softmasking \ 
          

