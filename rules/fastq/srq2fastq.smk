rule get_fastq_:
    output:
        # the wildcard name must be accession, pointing to an SRA number
        "data/{accession}_1.fastq",
        "data/{accession}_2.fastq"
    params:
        # optional extra arguments
        extra=""
    threads: 6  # defaults to 6
    wrapper:
        "0.64.0/bio/sra-tools/fasterq-dump"
