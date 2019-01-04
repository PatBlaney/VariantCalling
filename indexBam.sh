#!/bin/bash
# Index each BAM file that has had duplicates marked with Samtools
# Loop through each .bam file in the NoDup directory and output
# indexed BAI files to the same directory
dupBamDir="NoDup/"
suffix=".bam"
indexBam(){
	for bamFile in $dupBamDir*$suffix
	do
		nice -n 19 samtools index \
		-b $bamFile
	done
}
indexBam 1>indexBam.log 2>indexBam.err &
