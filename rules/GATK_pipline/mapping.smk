rule bwa_mem:
    input:
        reads=["reads/{sample}_1.fastq", "reads/{sample}_2.fastq"]
    output:
        "mapped/{sample}.bam"
    log:
        "logs/bwa_mem/{sample}.log"
    params:
        index="genome",
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
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
        extra=config["params"]["gatk"]["gatk_baserecalibrator"]
    wrapper:
        "0.64.0/bio/gatk/baserecalibrator"

rule Apply:
    input: 
    output: 
    run: 