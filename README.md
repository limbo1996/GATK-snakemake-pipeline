# DNA-seq and Neoantigens prediction
Snakemake workflow for neoantigen prediction.

> **This workflow is still in development**

This snakemake pipeline implements the [GATK best-practices workflow](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-)



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

