#!/bin/bash
echo -e "Assemly_accession\tRefseq_accession\tstart\tend\tstrand\tgene_id\tgene_name\tprotein_id\tlocus_tag\tproduct\tpseudo\tpartial" > temp_tuf_extr.tsv
cd ncbi_dataset/data/

while read acc_accession; do
  genome_folder=$acc_accession
  cd $genome_folder
  awk -F'\t' '$3 == "CDS"' genomic.gtf | grep -i 'tuf' > info.tmp
  acc_column=$(yes "$acc_accession" | head -n $(cat info.tmp | wc -l))
  info=$(cat info.tmp | awk -F'\t' 'BEGIN{OFS="\t"} {print $1, $4, $5, $7}')
  gene_id=$(awk '{match($0, /gene_id "[^"]+"/); if (RSTART) {print substr($0, RSTART, RLENGTH)} else {print "--"}}' info.tmp)
  gene_name=$(awk '{match($0, /gene "[^"]+"/); if (RSTART) {print substr($0, RSTART, RLENGTH)} else {print "--"}}' info.tmp)
  protein_id=$(awk '{match($0, /protein_id "[A-Za-z0-9_.]*"/); if (RSTART) {print substr($0, RSTART, RLENGTH)} else {print "--"}}' info.tmp)
  locus_tags=$(awk '{match($0, /locus_tag "[A-Za-z0-9_]*"/); if (RSTART) {print substr($0, RSTART, RLENGTH)} else {print "--"}}' info.tmp)
  product=$(awk '{match($0, /product "[A-Za-z0-9_. ,*-]*"/); if (RSTART) {print substr($0, RSTART, RLENGTH)} else {print "--"}}' info.tmp)
  pseudo=$(awk '{match($0, /pseudo "[A-Za-z0-9_. ,*-]*"/); if (RSTART) {print substr($0, RSTART, RLENGTH)} else {print "--"}}' info.tmp)
  partial=$(awk '{match($0, /partial "[A-Za-z0-9_. ,*-]*"/); if (RSTART) {print substr($0, RSTART, RLENGTH)} else {print "--"}}' info.tmp)
  paste <(echo "$acc_column") <(echo "$info") <(echo "$gene_id") <(echo "$gene_name") <(echo "$protein_id") <(echo "$locus_tags") <(echo "$product") <(echo "$pseudo") <(echo "$partial") >> ../../../temp_tuf_extr.tsv
  rm info.tmp
  cd ..
done
cd ../../

cat temp_tuf_extr.tsv | sed 's/gene "//g;s/gene_id //g;s/protein_id "//g;s/locus_tag "//g;s/product "//g;s/pseudo "//g;s/partial "//g;s/"//g;s/;//g;' > tuf_extr.tsv
rm temp_tuf_extr.tsv
