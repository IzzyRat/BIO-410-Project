# BIO-410-Project

### Background
cAMP receptor protein (CRP) is a global transcription factor that in Escherichia coli  regulates the expression of potentially 283 operons – which accounts for over 50% of all E. coli genes (Martı́nez-Antonio & Collado-Vides, 2003; Ishihama et al., 2016; Davis et al., 2017).  As a transcription factor that binds to a relatively large number of regulatory regions on genes, CRP binding sites on DNA can be particularly useful in gene detection. More specifically, structural annotation is the process of identifying genes within a genome (Tripp et al., 2015; Ejigu & and Jung, 2020). Typically, structural annotations utilize a position-specific score matrix (PSSM), where known DNA alignments are used to score unknown DNA sequences to determine the likelihood of a gene’s presence in that segment of DNA (Henikoff & Henikoff, 1996; Panchenko & Bryant, 2002). As a result, known CRP binding sites can be used to produce PSSMs to detect genes within genomes. 

Thus, this dataset utilizes known CRP binding sites in E. coli to generate a PSSM, which is then utilized to calculate the likelihood that three unknown DNA sequences are CRP binding sites. Sequences with a high likelihood of being a CRP binding site can then be investigated further to determine if a gene is present. 

### Methods
The libraries utilized in this project are: seqinr, Biostrings, rentrez, compbio4all, and ggplot2. All source code utilized to generate a PSSM and scores for the unknown DNA sequences can be viewed in the R file titled “StructuralAnnotationRMethod”. The known E. coli CRP binding sequences and unknown DNA sequences can both be found within this file. 
