'''
约定snakemake版本
该文件主要用来提前处理各个样本
主要是分辨样本是单端还是双端(质控时，以及srq2fastq时)
样本类型， T/N（calling）
''' 
import pandas as pd
import snakemake.uitl