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