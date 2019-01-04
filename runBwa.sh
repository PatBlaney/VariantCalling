#!/bin/bash
# Initialize variables for the directory with the quality trimmed
# paired reads, the .fastq suffix of left reads, the output .bam file directory
# Create the directory if it does not exist
pairedDir="Paired/"
suffix="_1.paired.fastq.gz"
bamOut="Bam/"
mkdir -p $bamOut
# Align all trimmed reads to the reference genome using BWA
alignAll(){
for leftRead in $pairedDir*$suffix
	do
		# Use left read filename to create paired right read filename
		# and isolate the raw sample ID
		rightRead="${leftRead/_1/_2}"
		sample="${leftRead/$pairedDir/}"
		sample="${sample/$suffix/}"
		# Call the BWA-MEM alignment algorithm to create .bam files
		# Pass the custom .bam header, number of threads, and paired
		# left and right read files. Sort the output .bam alignment files
		# by leftmost coordinates with samtools  
		nice -n19 bwa mem \
		-R "@RG\tID:$sample\tSM:sample1\tPL:illumina\tLB:lib1\tPU:unit1" \
		-t 8 vShiloni \
		$leftRead $rightRead |\
		samtools sort \
		1>$bamOut$sample.bam
	done
}
alignAll 2>alignAll.err &
