#!/bin/bash 
echo true

params.gene = 'Sec23a'
params.annot = 'rnaseq/refs/mm65.long.ok.gtf'

annotation = Channel.fromPath(params.annot)
genes = params.gene.tokenize(', ')

process count {
  input: 
  each gene from genes
  file 'annotation.gtf' from annotation 
 
  shell:
  '''  
  echo !{gene} 
  grep !{gene} annotation.gtf > gff
  awk '$3=="transcript"' gff | wc -l 
  awk '$3=="exon"' gff | wc -l
  '''

}

