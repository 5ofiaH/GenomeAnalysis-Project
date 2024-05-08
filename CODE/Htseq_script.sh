#!/bin/bash -l

#SBATCH -A uppmax2024-2-7
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 06:00:00
#SBATCH -J Htseq_analyses_01
#SBATCH --mail-type=ALL 
#SBATCH --mail-user  sofia.hernandez-valenzuela.2039@student.uu.se
#SBATCH --output Htseq.out

module load bioinfo-tools
module load htseq
bams=/proj/uppmax2024-2-7/nobackup/work/shv/star/2results
gffs=/home/soffiahv/genome_analysis/analyses/02_genome_assembly/braker/braker/Durio_zibethinus

# Run HTSeq-count
for bam_file in $bams/*.bam; do
    # Get the basename of the BAM file
    filename=$(basename "$bam_file")
    base="${filename%.*}"

    htseq-count --format=bam  --order=pos --stranded=no -t gene --idattr=ID $bam_file $gffs/augustus.hints.gff3 > ${base}_counts.txt
    # Check if HTSeq-count command was successful
    if [ $? -eq 0 ]; then
        echo "HTSeq-count completed successfully for $bam_file. Output written to ${base}_counts.txt"
    else
        echo "Error: HTSeq-count failed for $bam_file."
    fi
done
