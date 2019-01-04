#!/bin/bash
# Use the SNP filtered VCF file as the known variant sites, vShiloni
# reference genome, marked duplicates BAM files as input, and output
# filename as options for the BaseRecalibrator command
baseCommand="nice -n 19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar"
refGenome="vShiloni.fasta"
knownSites="filteredSnps.vcf"
bamFiles="$(ls -q NoDup/*.bam)"
inputBam="${bamFiles//NoDup/-I NoDup}"
initialTable="initialRecalData.table"
# Analyze patterns of covariation in the sequence dataset
$baseCommand -T BaseRecalibrator -R $refGenome $inputBam -knownSites $knownSites -o $initialTable &
# Do a second pass to analyze covariation that remains after the initial recalibration
# All input files remain the same and now use the data table created during first
# recalibration as the basis for the second round of recalibration
postTable="postRecalData.table"
$baseCommand -T BaseRecalibrator -R $refGenome $inputBam -knownSites $knownSites -BQSR $initialTable -o $postTable &
# Generate plots of how reported base qualities match up to the empirical
# qualities calculated by the BaseRecalibrator. One plot each for the initial
# and post data tables
recalPlots="recalibrationPlots.pdf"
$baseCommand -T AnalyzeCovariates -R $refGenome -before $initialTable -after $postTable -plots $recalPlots &
