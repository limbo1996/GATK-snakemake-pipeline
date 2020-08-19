configfile: "../config.yaml"
rule download_vep_plugins:
    output:
        directory("resources/vep/plugins")
    params:
        release=config["ref"]["bwa"]["release"]
    wrapper:
        "0.64.0/bio/vep/plugins"