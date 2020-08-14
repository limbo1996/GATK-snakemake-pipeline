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

rule markduplication:
    input: 
    output: 
    run: 

rule BaseRecalibrator:
    input: 
    output: 
    run: 

rule Apply:
    input: 
    output: 
    run: 