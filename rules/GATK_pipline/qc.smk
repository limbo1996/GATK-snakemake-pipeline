"""
可以使用fastp,可以自动完成质量控制去接头过程
并输出动态的HTML页面和JSON
"""
rule fastp_se:
    input:
        sample=unpack(get_fastq)
    output:
        trimmed="trimmed/se/{sample}.fastq",
        html="report/se/{sample}.html",
        json="report/se/{sample}.json"
    log:
        "logs/fastp/se/{sample}.log"
    params:
        extra=""
    threads: 1
    wrapper:
        "0.64.0/bio/fastp"

rule fastp_pe:
    input:
        sample=unpack(get_fastq)
    output:
        trimmed=["trimmed/pe/{sample}_1.fastq", "trimmed/pe/{sample}_2.fastq"],
        html="report/pe/{sample}.html",
        json="report/pe/{sample}.json"
    log:
        "logs/fastp/pe/{sample}.log"
    params:
        extra=""
    threads: 2
    wrapper:
        "0.64.0/bio/fastp"