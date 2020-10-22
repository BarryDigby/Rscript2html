#!/usr/bin/Rscript

get_args <- function(){

	argp <- arg_parser(
		description="this script is designed to produce a final report of DE circRNAs detected in samples as part of the circRNA nextflow script",
		hide.opts=TRUE)

	argp <- add_argument(
		parser=argp,
		arg="de_circ",
		short="d",
		help="DESeq2 Results for DE circs")

	argp <- add_argument(
            	parser=argp,
            	arg="circ_counts",
		short="c",
            	help="Normalized circRNA counts")

 	argp <- add_argument(
            	parser=argp,
            	arg="gene_counts",
		short="g",
            	help="Normalized gene counts")

	argp <- add_argument(
		parser=argp,
		arg="parent_gene",
		short="pg",
		help="circRNA parent gene file")

	argp <- add_argument(
		parser=argp,
		arg="bed",
		short="b",
		help="bed12 file of circRNA")

	argp <- add_argument(
		parser=argp,
		arg="miranda",
		short="m",
		help="miRanda output for circRNA")

	argp <- add_argument(
		parser=argp,
		arg="targetscan",
		short="t",
		help="targetscan output for circRNA")

	argp <- add_argument(
		parser=argp,
		arg="mature_len",
		short="l",
		help="length of mature circRNA")

	argp <- add_argument(
		parser=argp,
		arg="phenotype",
		short="p",
		help="Phenotype / colData / samples file used previously for DESeq2")

    	argv <- parse_args(
            	parser=argp,
            	argv = commandArgs(trailingOnly = TRUE))

    return(argv)
    }

giveError <- function(message){
    cat(paste("\n", message, sep=""))
    quit()
    }

usage <- function(){giveError("USAGE: circ_report.R de_circ circrna_counts gene_counts bed miranda targetscan mature_len")}

stage_data <- function(de_circ, circ_counts, gene_counts, parent_gene, bed, miranda, targetscan, mature_len, phenotype){

	inputdata <- list()

	de <- read.table(de_circ, sep="\t", row.names="ID", header=T, stringsAsFactors=F)
	circ <- read.table(circ_counts, sep="\t", row.names="ID", header=T)
	gene <- read.table(gene_counts, sep="\t", row.names="ID", header=T, check.names=F)
	parent_tmp <- read.table(parent_gene, sep="\t", row.names=1, header=F, stringsAsFactors=F)
	colnames(parent_tmp) <- "gene"
	parent <- parent_tmp$gene
	bed <- read.table(bed, sep="\t", header=F, stringsAsFactors=F)
	colnames(bed) <- c("chr", "start", "end", "name", "score", "strand", "thickStart", "thickEnd", "itemRGB", "ExonCount", "ExonSizes", "ExonStart")
	miranda <- read.table(miranda, sep="\t", header=T, stringsAsFactors=F)
	targetscan <- read.table(targetscan, sep="\t", header=T, stringsAsFactors=F)
	mature_tmp <- read.table(mature_len)
	mature <- mature_tmp$V1
	pheno <- read.table(phenotype, sep="\t", header=T, row.names=1)

	inputdata$de <- de
	inputdata$circ <- circ
	inputdata$gene <- gene
	inputdata$parent <- parent
	inputdata$bed <- bed
	inputdata$miranda <- miranda
	inputdata$targetscan <- targetscan
	inputdata$mature <- mature
	inputdata$pheno <- pheno

	return(inputdata)
}

# Packages + Error traceback (really handy for explicit error tracing)
options(error=function()traceback(2))
suppressPackageStartupMessages(library("argparser"))
suppressPackageStartupMessages(library("rmarkdown"))


arg <- get_args()

inputdata <- stage_data(arg$de_circ, arg$circ_counts, arg$gene_counts, arg$parent_gene, arg$bed, arg$miranda, arg$targetscan, arg$mature_len, arg$phenotype)

#' ---
#' title: Sample HTML report generated from R script
#' author: Andrew Brooks
#' date: March 4, 2015
#' output:
#'    html_document:
#'      toc: true
#'      highlight: zenburn
#' ---


head(inputdata$de)
head(inputdata$circ)
head(inputdata$gene)
head(inputdata$parent)
head(inputdata$bed)
head(inputdata$miranda)
head(inputdata$targetscan)
head(inputdata$mature)
head(inputdata$pheno)

#' `rmarkdown::render('~/Desktop/circ_report/circ_report.R')`
