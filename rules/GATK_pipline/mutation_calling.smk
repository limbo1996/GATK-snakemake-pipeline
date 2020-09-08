rule mutect2: 
    input:
        fasta = "genome/genome.fasta",
        normal = get_normal_bam,
        tumor = "recal/{samples}_BQSR.bam",
    output:
        vcf = "variant/{samples}.vcf"
    message:
        "Testing Mutect2 with {wildcards.samples}"
    threads:
        5
    params:
        extra=config["params"]["mutect2"]
    log:
        "logs/mutect_{samples}.log"
    wrapper:
        "0.64.0/bio/gatk/mutect"

