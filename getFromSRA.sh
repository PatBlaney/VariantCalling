#!/bin/bash
# Set a variable to hold the file that contains all SRA accession IDs
filename="SRR_Acc_List.txt"
# Create a function that reads the SRA accession IDs line-by-line
getAll() {
	while read -r line
	do
		# Get the FASTQ formatted reads from the SRA
		fastq-dump $line --split-3 --gzip
	done < "$filename"
}
# Call the function and run it in th background
getAll 1>get.log 2>get.err &
