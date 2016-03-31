#!/bin/bash

echo true
annotation = Channel.fromPath('rnaseq/refs/mm65.long.ok.gtf')

process count {

  input: 
  file 'annotation.gtf' from annotation 

  '''  
  grep Sec23a annotation.gtf > Sec23a.gff
  awk '$3=="transcript"' Sec23a.gff | wc -l 
  awk '$3=="exon"' Sec23a.gff | wc -l
  '''

}
