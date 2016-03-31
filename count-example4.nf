#!/bin/bash

params.gene = 'Sec23a'
params.annot = 'rnaseq/refs/mm65.long.ok.gtf'

annotation = Channel.fromPath(params.annot)
genes = params.gene.tokenize(', ')

process count {
  input: 
  each gene from genes
  file annot from annotation 
 
  output:
  stdout into result

  shell:
  '''  
  echo !{annot.baseName}
  echo !{gene} 
  grep !{gene} !{annot} > gff
  awk '$3=="transcript"' gff | wc -l 
  awk '$3=="exon"' gff | wc -l
  '''

}

result
  .map { str -> str.readLines().join(',') }
  .collectFile(newLine: true)
  .println { it.text }
