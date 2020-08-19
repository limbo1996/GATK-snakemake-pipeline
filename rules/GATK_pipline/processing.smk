'''
该文件主要用来提前处理各个样本
主要是分辨样本是单端还是双端（质控）
样本类型， T/N（calling）
''' 
import pandas as pd













# vep的注释需要文件的下载
rule download_vep_plugins:
    output:
        directory("resources/vep/plugins")
    params:
        release=config["ref"]["bwa"]["release"]
    wrapper:
        "0.64.0/bio/vep/plugins"

rule get_vep_cache:
    output:
        directory("resources/vep/cache")
    params:
        species=config["ref"]["bwa"]["species"],
        build=config["ref"]["bwa"]["build"],
        release=config["ref"]["bwa"]["release"]
    log:
        "logs/vep/cache.log"
    cache: True  # save space and time with between workflow caching (see docs)
    wrapper:
        "0.64.0/bio/vep/cache"