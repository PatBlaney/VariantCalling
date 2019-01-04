#!/bin/bash
# Store variables to hold output directories, create them if they
# don't already exist. Store suffix of zipped FASTQ files containing
# left read pairs.
pairedOutPath="Paired/"
unpairedOutPath="Unpaired/"
mkdir -p $pairedOutPath
mkdir -p $unpairedOutPath
leftSuffix="_1.fastq.gz"
# Create a function that utilizes Trimmomatic to output quality bases
# Loop through all zipped FASTQ files downloaded from SRA
trimAll(){
for leftInFile in *$leftSuffix
	do
		# Use the name of left infile to create paired right file
		# and isolate sample read identifier
		rightInFile="${leftInFile/_1/_2}"
		leftSampleId="${leftInFile/.fastq.gz/}"
		rightSampleId="${rightInFile/.fastq.gz/}"
		# Call Trimmomatic on all left and right SRA FASTQ reads
		# with the Nextera paired end library adapter
		nice -n19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
		-threads 4 -phred33 \
		$leftInFile \
		$rightInFile \
		$pairedOutPath$leftSampleId.paired.fastq.gz \
		$unpairedOutPath$leftSampleId.unpaired.fastq.gz \
		$pairedOutPath$rightSampleId.paired.fastq.gz \
		$unpairedOutPath$rightSampleId.unpaired.fastq.gz \
		HEADCROP:0 \
		ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/NexteraPE-PE.fa:2:30:10 \
		LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36
	done
}
trimAll 1>trimAll.log 2>trimAll.err &
