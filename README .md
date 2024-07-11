# Project Title

Assignment 10 -BINF6309  -Bioinformatics

NUID - 002938389

## Authors

-Prachi Sardana

-sardana.p@northeastern.edu


## Description

- To install PLink and study the genome wide associations following the tutorial

## Getting Started

### Dependencies

* Windows subsystem for Linux

### Installing

* Ubuntu
* PLink 

### Summary  


In order to get the summary statistics of the file used PLINK to analyze the example data: randomly selected genotypes (approximately 80,000 autosomal SNPs) from the 89 Asian HapMap individuals. Beginning from the range of features data management, summary statistics, population stratification and basic association analysis were studied. 
After getting tehe summary statistics of the table, each map file in hapmap consisted of 4 coloumns 1. chromosomes from (1-22), 2. snp identifier 3. genetic distance in morgans 4. base-pair position. 
A binary PED file was made. Make-bed using this option , the threshold filters for missing rates and allele frequency were automatically set to exclude nobody
The output generated 3 files hapmap1.bed containing the raw genotype data, hapmap1.bim containing two coloumns giving allele names for each SNP and hapmap1.fam which were first six coloumns of hapmap1.ped.The missing rates showed the percentages of missing data for each person and SNP in a particular dataset. The missing option generated simple summary statistics on the rate of missing data.The output file created a miss_stat.imiss statistics with their family id, individual id , missing phenotype, number of missing individuals and proportion of the missing individuals
In miss_stat.lmiss, at each locus showed the statistics with the chromosomes, number of missing chromosomes, genotype and the final coloumn determining the genotyping rate of individual. freq_stat consisted of the result table of allelic frequencies, showing the minor allele frequency and allele codes for each SNP in the input dataset.
The frq file created by the Plink command --freq. Chromosome number, SNP identifier, minor allele, major allele, and associated minor allele frequency were displayed in the columns.  In the stratified file, each row were the allele frequency for each SNP stratifed by subpopulation In the output stratified file, there were SNPS represented twice and the CLST coloumn indicated whether the frequency was from Chinese or Japanese populations. In order to perform a basic association analysis on the disease trait for all single SNPs, each SNP association resulted in the output file as1.assoc containing the chromosome, snp identifier, code for allele1, frequency of
variant in case , control, code for allele, chisquared test, asymptotic significance value, odds ratio for the test. The values showed in the table were the result of genotypic and other association models simulations of the trait. A log file was created as an output, confirming that the analysis has been done, and the results of the IBS-clustering were generated in format in the file str1 and . cluster1 in the stratification analysis.Taking clusters into account, the 'disease' variant, rs2222162, moved from 2nd position to 1 but still it is insignificant after genome -wide adjustment.


## Version History

* Ubuntu 22.04.1 LTS
* Pycharm Community Edition 2021.2.2
* Pylint 2.4.4
* Python 3.10
