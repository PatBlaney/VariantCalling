#!/bin/bash
# Run GenotypeGVCFs GATK command on all 211 .vcf files to merge
# analysis of all samples into on VCF file
vcf="$(ls -q Vcf/*.vcf)"
inPath="Vcf/"
# Use a variable to hold all 211 VCF files as options to pass to
# GenotypeGVCFs command
replacement="--variant Vcf/"
vcfParam="${vcf//$inPath/$replacement}"
# Store the base command for all GATK commands
baseCommand="nice -n 19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar"
# Call GenotypeGVCFs command, passing the vShiloni reference genome, all 211 VCF parameters,
# number of threads, and the output merged VCF filename
$baseCommand -T GenotypeGVCFs -R vShiloni.fasta $vcfParam -nt 16 -o genotype.vcf \
1>gvcf.log 2>gvcf.err &
