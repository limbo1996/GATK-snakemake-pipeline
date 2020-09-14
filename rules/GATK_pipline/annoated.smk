rule annotate_variants:
    input:
        calls="variants.vcf",  # .vcf, .vcf.gz or .bcf
        cache="resources/vep/cache",
        plugins="resources/vep/plugins",
    output:
        calls="variants.annotated.vcf",  # .vcf, .vcf.gz or .bcf
        stats="variants.html"
    params:
        plugins=["Wildtype", "Download"],
        extra="--everything"  # optional: extra arguments
    log:
        "logs/vep/annotate.log"
    threads: 4
    wrapper:
        "0.65.0/bio/vep/annotate"