#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J Trimmo_illumina_rna_01
#SBATCH --mail-type=ALL 
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se

# Load modules
module load bioinfo-tools
module load trimmomatic

echo "Modules loaded"

# Commands
base_dir=/home/soffiahv/genome_analysis
in=$base_dir/data/untrimmed_data
out=$base_dir/analyses/01_preprocessing/trimmomatic_rna

# Data I chose for this comes from the transcriptome Illumina untrimmmed data.
echo "Trimmomatic started"

trimmomatic PE \
	-threads 2 \
	-phred33 \
	-basein $in/SRR6040095_scaffold_06.1.fastq.gz \
	-baseout $out/SRR6040095_scaffold_06_trimmed ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:5:20:10 \

echo "Trimmomatic ended"

