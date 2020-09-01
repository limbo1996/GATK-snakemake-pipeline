'''
约定snakemake版本
该文件主要用来提前处理各个样本
主要是分辨样本是单端还是双端(质控时，以及srq2fastq时)
样本类型， T/N（calling）
''' 
import pandas as pd
from snakemake.utils import validate
from snakemake.utils import min_version

min_version("5.18.0")
reprot = "../reports/workflow.rst"

##########config file
configfile: "../config.yaml"

# validate(config, )


sample = pd.read_table(config["samples"], sep = "\t")
patient = pd.read_table(config["Patient"])

def get_fastq(wildcards):
	fastq = sample.loc[(wildcards.samples), ["fq1", "fq2"]]
	if len(fastq) == 1:
		return {"fastq_1" : fastq.fq1, "fastq_2" : fastq.fq2}
	return {"fastq" : fastq.fq1}

def get_sample_info_mapping(wildcards):
    return r"-R '@RG\tID:{sample}\tSM:{sample}\tPL:{platform}'".format(
        sample=wildcards.sample,
        platform=sample.loc[(wildcards.samples), "plat"])

def get_patient_file(wildcards):
	tumor = sample.loc[(wildcards.samples), ["samples", "type", "Patient"]]
	return expand("recal/{samples}_BQSR.bam", samples=tumor["samples"])