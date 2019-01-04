#!/bin/bash
# Using BAM files, produce variant calls with the Genome Analysis Toolkit
# This will identify the genomic variants from the reference genome and output
# VCF file with potential types variants present at those identified locations
# Initiate variables for the .bam file directory, .bam suffix, and output directory
bamDir="NoDup/"
suffix=".bam"
vcfDir="Vcf/"
mkdir -p $vcfDir
# Create a function that will loop through all .bam files and run the GATK
# HaplotypeCaller command
findVariants(){
for bamIn in $bamDir*$suffix
	do
		vcfOut="${bamIn/$bamDir/$vcfDir}"
		vcfOut="${vcfOut/$suffix/.vcf}"
		# Run HaplotypCaller for single-sample GVCF calling
		# Pass options to specify the emitting reference confidence for GVCF mode,
		# vShiloni reference genome, input .bam files, specify how to determine alt alleles,
		# specify calling confidence, number of threads to be used, and the output filename
		# Recently, the variant indexing arguments are no longer required if output file has
		# a .g.vcf extension 
		nice -n 19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
		-T HaplotypeCaller --emitRefConfidence GVCF -R vShiloni.fasta -I $bamIn --genotyping_mode DISCOVERY \
		-variant_index_type LINEAR -variant_index_parameter 128000 \
		-stand_call_conf 30 -nct 16 -o $vcfOut
		
	done
}
findVariants 1>findVariants.log 2>findVariants.err &
