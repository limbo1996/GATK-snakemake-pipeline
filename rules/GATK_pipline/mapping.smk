rule bwa_mem:
    input:
        reads=["reads/{sample}_1.fastq", "reads/{sample}_2.fastq"]
    output:
        "mapped/{sample}.bam"
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
        bam="dedup/{sample}.bam",
        metrics="dedup/{sample}.metrics.txt"
    log:
        "logs/picard/dedup/{sample}.log"
    wrapper:
        "0.64.0/bio/picard/markduplicates"

rule gatk_baserecalibrator:
    input:
        bam="mapped/{sample}.bam",
        ref="genome.fasta",
        dict="genome.dict" 
    output:
        recal_table="recal/{sample}.grp"
    log:
        "logs/gatk/baserecalibrator/{sample}.log"
    params:
        extra=config["params"]["gatk"]["gatk_baserecalibrator"] # 添加多个konwn site，待做
        java_opts=config["params"]["java"]
    wrapper:
        "0.64.0/bio/gatk/baserecalibrator"

rule gatk_applybqsr:
    input:
        bam="mapped/{sample}.bam",
        ref="genome.fasta",
        dict="genome.dict",
        recal_table="recal/{sample}.grp"
    output:
        bam="recal/{sample}_BQSR.bam"
    log:
        "logs/gatk/gatk_applybqsr/{sample}.log"
    params:
        java_opts=config["params"]["java"]
    wrapper:
        "0.64.0/bio/gatk/applybqsr"