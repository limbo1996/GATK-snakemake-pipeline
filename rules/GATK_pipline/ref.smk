# 获取参考基因组
rule get_genome:
    output:
        "ref_data/genome.fasta"
    params:
        species=config["ref"]["bwa"]["species"],
        datatype="dna",
        build=config["ref"]["bwa"]["build"],
        release=config["ref"]["bwa"]["release"]
    log:
        "logs/get_genome.log"
    cache: True  
    wrapper:
        "0.64.0/bio/reference/ensembl-sequence"

# 构建bwa索引
rule bwa_index:
    input: 
        "ref_data/genome.fasta"
    output:
        multiext("ref_data/genome.fasta", ".bwt", ".pac", ".sa",".amb", ".ann")
    log:
        "logs/bwa_index.log"
    params:
        algorithm="bwtsw"
    wrapper:
        "0.64.0/bio/bwa/index"

# 构建dict索引
rule get_dict:
    input: 
        "ref_data/genome.fasta"
    output: 
        "ref_data/genome.dict"
    log:
        "logs/samtools/create_dict.log"
    cache: True
    conda:
        "../envs/samtools.yaml"
    shell: 
        "samtools dict {input} > {output} 2 > {log}"

# 构建fai文件
rule get_fai:
    input: 
        "ref_data/genome.fasta"
    output: 
        "ref_data/genome.fasta.fai"
    log:
        "logs/samtools/create_fai.log"
    wrapper:
        "0.64.0/bio/samtools/faidx"


# vep的注释需要文件的下载
rule download_vep_plugins:
    output:
        directory("resources/vep/plugins")
    params:
        release=config["ref"]["bwa"]["release"]
    wrapper:
        "0.64.0/bio/vep/plugins"
'''
有一个wildtype插件需要自己下
'''
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