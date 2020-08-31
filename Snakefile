configfile: "config.yaml"
# sra2fastq的步骤补充上去
include: "rules/GATK_pipline/ref.smk"
include: "rules/GATK_pipline/qc.smk"
include: "rules/GATK_pipline/mapping.smk"
include: "rules/GATK_pipline/mutation_calling.smk"
include: "rules/GATK_pipline/filter_mutation.smk"
include: "rules/GATK_pipline/annoated.smk"
include: "rules/HLAtyping/fish_fastq.smk"
include: "rules/HLAtyping/typing.smk"
include: "rules/neoantigens_prediction/prediction.smk"

rule all:
    input: 
        sonefunc()# 这里想输入几个函数，完成对sample的解析