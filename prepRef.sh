#!/bin/bash
# Create an index reference sequences of the concatinated FASTA file with samtools
# faidx. Then create a sequence dictionary for the indexed reference sequences using
# the CreateSequenceDictionary Picard command. Pass the concatenated FASTA file 
# as input reference FASTA and set the output dictionary file.
samtools faidx vShiloni.fasta
java -jar /usr/local/bin/picard.jar CreateSequenceDictionary \
R=vShiloni.fasta O=vShiloni.dict \
1>prepRef.log 2>prepRef.err &  
