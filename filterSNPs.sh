#!/bin/bash
# Hard filter the merged VCF file for SNP variant calls that have a mapping quality
# minimum of 70.0
# Initiate variables for the input merged VCF file and output filtered VCF file
vcf="genotype.vcf"
vcfOut="filteredSnps.vcf"
# Initiate variables for the base GATK command and options to pass with the
# VariantFiltration command
baseCommand="nice -n 19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar"
taskRef="-T VariantFiltration -R vShiloni.fasta --filterName snpQual"
# Call VariantFiltration command passing the vShiloni reference genome, isolate SNP
# variant calls, input merged VCF file, filter by mapping quality minimum of 70.0,
# and the output filename
$baseCommand $taskRef -V $vcf --filterExpression "MQ < 70.0" -o $vcfOut \
1>filter.log 2>filter.err &
