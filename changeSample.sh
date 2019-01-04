#!/bin/bash
inPath="Vcf/"
ext=".vcf"
for vcfFile in $inPath*$ext
do
	sample="${vcfFile/$inPath/}"
	sample="${sample/$ext/}"
	sed -i -e "s/sample1/$sample/g" $vcfFile
done
