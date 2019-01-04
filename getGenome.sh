#!/bin/bash
# Create array with accession numbers of desired genomes to query for FASTA files
array=(NZ_CP018308.1 NZ_CP018309.1 NZ_CP018310.1)
# Iterage over the array and query GenBank with each accession number
for acc in "${array[@]}"
do
	# Query GenBank with accession number to donwload genome FASTA
	bp_download_query_genbank.pl --query $acc --out $acc.fasta
done
