rule mutect2: 
'''
如何同时输入tumor和normal是需要解决的问题，考虑将质控时如何判断样本是
单端还是双端一起解决，提取出来写为函数
'''
    input:
        fasta = "genome/genome.fasta",
        normal = get_normal(),
        tumor = "mapped/{sample}.bam",# 添加函数替换
    output:
        vcf = "variant/{sample}.vcf"
    message:
        "Testing Mutect2 with {wildcards.sample}"
    threads:
        1
    params:
        extra=config["params"]["mutect2"]
    log:
        "logs/mutect_{sample}.log"
    wrapper:
        "0.64.0/bio/gatk/mutect"

