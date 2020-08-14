rule optitype:
    input:
        reads=["reads/{sample}_1.fished.fastq", "reads/{sample}_2.fished.fastq"]
    output:
        multiext("optitype/{sample}", "_coverage_plot.pdf", "_result.tsv")
    log:
        "logs/optitype/{sample}.log"
    params:
        sequencing_type="dna",
    wrapper:
        "0.64.0/bio/optitype"