# DNA-seq and Neoantigens prediction
Snakemake workflow for neoantigen prediction.
> **This workflow is still in development**

This snakemake pipeline implements the [GATK best-practices workflow](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-)

## 项目结构（待更新）
包括个部分：
* GATK workflow
* HLA typing
* Mutation calling
* Neoantigen Prediction（working...）
### GATK workflow
Flow the [GATK best-practices workflow](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-).
* `ref.smk` 收集需要用到的参考文件以及索引的构建
* `qc.smk` 对fastq文件质控和去接头
* `mapping.smk` 将fastq文件比对到参开基因组，并对得到的`bam`文件进行处理
* `mutation_calling.smk` mutation calling
* `filter_mutation.smk` 对突变结果过滤，并筛选`PASS`标签的突变
* `annoated.smk` 对突变注释
 
### HLA typing
使用工具[Optitype](https://github.com/FRED-2/OptiType)对样本进行HLA分型
### Neoantigen Prediction
正开发，计划最少使用`NetMHCpan`预测，尽量可以支持多种算法。。。。

## 使用方法
#### Step 1 Clone repository
 Clone this repository to your local system
 **需要写一个脚本判断是否有conda，如果没有自动下载安装并创建snakemake环境**
    
#### Step 2 Edit files
Configure the workflow accoreding to your needs via editing the files `config.yaml`， `sample.tsv`
#### Step 3 Execute the process
This workflow will download reference genomes and annotation automatically.
Test your configuration by performing a dry-run via

> snakemake --use-conda -n

Execute the workflow locally via

> snakemake --use-conda --cores N

using `N` cores or run it in a cluster environment via
> snakemake --use-conda --cluster qsub --jobs 100

#### Step 4 Inspection results
After execution,  you can create a self-contained interactive HTML report with all results via:
> snakemake --report report.HTML