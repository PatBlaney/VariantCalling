#!/bin/bash
# Convert the merged, filtered SNP VCF file to a PLINK compatiable format
# using vcftools
filteredVcf="filteredSnps.vcf"
baseCommand="/usr/local/programs/vcftools_0.1.12b/bin/vcftools"
$baseCommand --vcf $filteredVcf --plink
