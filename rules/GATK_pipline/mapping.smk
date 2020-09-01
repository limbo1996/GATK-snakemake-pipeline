rule bwa_mem:
    input:
        reads=["reads/{samples}_1.fastq", "reads/{samples}_2.fastq"]
    output:
        temp("mapped/{samples}.bam")
    log:
        "logs/bwa_mem/{sample}.log"
    params:
        index="genome",
        extra=get_sample_info_mapping,
        sort="picard",             
        sort_order="coordinate",  
        sort_extra=""            
    threads: 8
    wrapper:
        "0.64.0/bio/bwa/mem"

rule mark_duplicates:
    input:
        "mapped/{sample}.bam"
    output:
        temp(bam="dedup/{samples}.bam"),
        temp(metrics="dedup/{samples}.metrics.txt")
    log:
        "logs/picard/dedup/{sample}.log"
    wrapper:
        "0.64.0/bio/picard/markduplicates"

rule gatk_baserecalibrator:
    input:
        bam="mapped/{samples}.bam",
        ref="genome.fasta",
        dict="genome.dict" 
    output:
        temp("recal/{samples}.grp")
    log:
        "logs/gatk/baserecalibrator/{sample}.log"
    params:
        extra=config["params"]["gatk"]["gatk_baserecalibrator"] # 添加多个konwn site，待做
        java_opts=config["params"]["java"]
    wrapper:
        "0.64.0/bio/gatk/baserecalibrator"

rule gatk_applybqsr:
    input:
        bam="mapped/{samples}.bam",
        ref="genome.fasta",
        dict="genome.dict",
        recal_table="recal/{samples}.grp"
    output:
        bam="recal/{samples}_BQSR.bam"
    log:
        "logs/gatk/gatk_applybqsr/{sample}.log"
    params:
        java_opts=config["params"]["java"]
    wrapper:
        "0.64.0/bio/gatk/applybqsr"