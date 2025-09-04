#!/bin/bash

mkdir Unpacked_genomes

while read accession; do
	echo $accession
	datasets download genome accession $accession --include genome,gtf,gbff --filename Unpacked_genomes/${accession}.zip
done
