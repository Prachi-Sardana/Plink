#!/usr/bin/bash

# get the summary statistics of the file
./plink --file hapmap1 

# each map file in hapmap contain 4 coloumns 1. chromosomes from (1-22), 2. snp identifier 3. genetic distance in morgans 4. base-pair position
# less hapmap1.map

# making binary PED file 
# make-bed using this option , the threshold filters for missing rates and allele frequency were automatically set to exclude nobody
# The output generates 3 files hapmap1.bed containing the raw genotype data, hapmap1.bim containing two coloumns giving allele names for each SNP
# and hapmap1.fam which is first six coloumns of hapmap1.ped
 
./plink --file hapmap1 --make-bed --out hapmap1  
# Since the file is in binary format , we'll use bfile
./plink --bfile hapmap1

# missing option is used to generate simple summary statistics on the rate of missing data
# output file creates a miss_stat.imiss statistics with their family id, individual id , missing phenotype, number of missing individuals and
# proportion of the missing individuals
# In miss_stat.lmiss, at each locus shows the statistics with the chromosomes, number of missing chromosomes, genotype 
and the final coloumn is the genotyping rate of individual 
./plink --bfile hapmap1 --missing --out miss_stat

# get the summary statistics of allelic frequencies . 
# freq_stat.frq file is created which contains the minor allele frequency and allele codes for each SNP.
./plink --bfile hapmap1 --freq --out freq_stat
#  This generated the 2 files frequency stat.log and frequency stat.freq
# To perform a stratified analysis, use the --within option.
./plink --bfile hapmap1 --freq --within pop.phe --out freq_stat
#  In the stratified file, each row is now the allele frequency for each SNP stratifed by subpopulation
# In the output stratified file, we can see that there are SNPS represented twice , 
# the CLST coloumn indicates whether the frequency is from Chinese or Japanese populations.

# In order to perform a basic association analysis on the disease trait for all single SNPs
./plink --bfile hapmap1 --assoc --out as1 
# Each SNP association result in the output file as1.assoc contains the chromosome, snp identifier, code for allele1, frequency of 
# variant in case , control, code for allele, chisquared test, asymptotic significance value, odds ratio for the test.
# If a test is not defined (for example, if the variant is monomorphic but was not excluded by the filters)
#  then values of NA for not applicable will be given 

# we can sort the list of association studies and print out the top 10 list using this command
# sort --key=7 -nr as1.assoc | head
# We can use the adjust flag to get a sorted list of association results, that also includes a range of significance values
  that are adjusted for multiple testing
./plink --bfile hapmap1 --assoc --adjust --out as2
# this generates  as2.assoc.adjusted and  as2.assoc.log file.
# The log file records the inflation factor calculated for the genomic control analysis, and 
# the mean chi-squared statistic (that should be 1 under the null)

./plink --bfile hapmap1 --pheno pop.phe --assoc --adjust --out as3
# we see that testing for frequency differences between Chinese and Japanese individuals, based on inflation factor and mean chisquared statistic

# Genotypic and other association studies
./plink --bfile hapmap1 --model --snp rs2222162 --out mod1
# this generates a mod1.model file and mod1.log .The model file has more than one row per SNP, representing 
# the different tests performed for each SNP

# Running the basic command model will not produce value for genotypic tests as every cell is required to have minimum 5 observations.
# To force genotypic tests for the particular SNP , we'll run the command 
./plink --bfile hapmap1 --model --cell 0 --snp rs2222162 --out mod2
# Genotypic test is calculated in affected and unaffected individuals.

# Stratification analysis
#  This command performs a cluster analysis that pairs up individuals on the basis of genetic identity.
# based on ibs cultering, any pair of individuals with significance value less than 0.05 are tested whether or not individuals belong to same
# population based on the SNP data 
./plink --bfile hapmap1 --cluster --mc 2 --ppc 0.05 --out str1

# Association analysis, accounting for clusters
# used Cochran-Mantel-Haenszel (CMH) association statistic, which tests for SNP-disease association conditional on
# the clustering supplied by the cluster file
# clustering on the basis of most similar individuals
./plink --bfile hapmap1 --mh --within str1.cluster2 --adjust --out aac1

# clustering on the basis of different individuals.Each cluster should have at least 1 case and 1 control with --cc option  
# specifing a threshold of 0.01 for --ppc
./plink --bfile hapmap1 --cluster --cc --ppc 0.01 --out version2

# log file records that five clusters were found, and a low inflation factor . 
output aac2.cmh.adjusted is generated in which disease SNP is genome-wide significant
./plink --bfile hapmap1 --mh --within version2.cluster2 --adjust --out aac2

# specified the number of clusters as 2 to perform stratification analysis
./plink --bfile hapmap1 --cluster --K 2 --out version3

# based on the known actual ancestry of each individual in particular sample, we can always use this external clustering in the analysis
./plink --bfile hapmap1 --mh --within pop.phe --adjust --out aac3


# it is possible to generate a visualisation of the substructure in the sample 
# by creating a matrix of pairwsie IBS distances, then using a statistical package such as R to generate a multidimensional 
# scaling plot, for example: use
./plink --bfile hapmap1 --cluster --matrix --out ibd_view

# We can use the following commands in R to generate a plot.
# m <- as.matrix(read.table("ibd_view.mdist"))
# mds <- cmdscale(as.dist(1-m))
# k <- c( rep("green",45) , rep("blue",44) )
# plot(mds,pch=20,col=k)


# Quantitative trait association analysis
# This file generates quant1.qassoc 
./plink --bfile hapmap1 --assoc --pheno qt.phe --out quant1

# Another way is to use the permutation 
./plink --bfile hapmap1 --assoc --pheno qt.phe --perm --within str1.cluster2 --out quant2

# testing whether the association with the continuous phenotype differs between the two populations
./plink --bfile hapmap1 --pheno qt.phe --gxe --covar pop.phe --snp rs2222162 --out quant3

# The output generates quant3.qassoc.gxe file

# SNP file is extracted , and the identified file is set up. The file is extracted as separate , smaller and more managable file. 
# Th file is converted to binary PED file format to a standard PED format.
./plink --bfile hapmap1 --snp rs2222162 --recodeAD --out rec_snp1

#  The output file rec_snp1.recode.raw is  specific recoding feature codes genotypes as additive (0,1,2) and dominant (0,1,0) components.

# We can load file into statistics package and easily perform other analyses
# For example
# d <- read.table("rec_snp1.recode.raw" , header=T)
# summary(glm(PHENOTYPE-1 ~ rs2222162_A, data=d, family="binomial"))
# This statements confirm the original analysis
