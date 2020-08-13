# 获取参开基因组并构建索引
# 获取参开基因组
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

# 构建索引， 需要conda yaml 主要是使用samtools