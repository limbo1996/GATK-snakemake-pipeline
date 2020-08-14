# fish fastq files use razer3
rule razers3:
    input:
        reads=["reads/{sample}_1.fastq", "reads/{sample}_2.fastq"]
    output:
        "mapped/{sample}.bam"
    log:
        "logs/razers3/{sample}.log"
    params:
        genome="ref_data/"
    threads: 8
    wrapper:
        "0.64.0/bio/razers3"