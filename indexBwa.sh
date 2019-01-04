#!/bin/bash
# Index FASTA sequences into a database for assembly by calling the
# BWA index command. Pass the name 'vShiloni' as the output db.fasta file
# and use the IS linear-time construction algorithm. Use the concatinated
# FASTA file of downloads from GenBank as the input.
nice -n19 bwa index -p vShiloni -a is vShiloni.fasta \
1>bwaIndex.log 1>bwaIndex.err &
