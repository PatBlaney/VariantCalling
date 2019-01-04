#!/bin/bash
# Initiate variables for .bam file directory, .bam suffix, and
# a output directory for the marked duplicate
# Create the output directory if it doesn't exist
bamDir="Bam/"
bamSuffix=".bam"
noDupDir="NoDup/"
mkdir -p $noDupDir
# Create function to loop through all .bam files and run the
# MarkDuplicates Picard command on them
markDuplicates(){
	for bamFile in $bamDir*$bamSuffix
		do
			# Direct output files to correct directory
			outFile="${bamFile/$bamDir/$noDupDir}"
			# Call MarkDuplicates Picard command with .bam files
			# as input and directed output files
			java -jar /usr/local/bin/picard.jar MarkDuplicates \
			INPUT=$bamFile \
			OUTPUT=$outFile \
			METRICS_FILE=$outFile.metrics.txt
		done
}
markDuplicates 1>markDup.log 2>markDup.err &
