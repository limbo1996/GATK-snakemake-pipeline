rule fastqc:
    input: 

    output: 
        html = "qc/fastqc/{sample}_{rank}.html"
        zip = "qc/fastqc/{sample}_{rank}.zip"
    wrapper: 
        "0.64.0/bio/fastqc"

rule multiqc:
    input: 

    output: 
        
    log:
        "logs/multiqc.log"
    wrapper: 
        "0.64.0/bio/multiqc"



rule trim_se:
    input: 
    output: 
    wrapper: 
        "0.64.0/bio/trim_galore/se"

rule trim_pe:
    input: 
    output: 
    wrapper: 
        "0.64.0/bio/trim_galore/pe"

rule mapping: #直接输出bam文件
    input: 
    output: 
    run: 

