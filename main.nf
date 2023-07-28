#!/usr/bin/env nextflow

Channel.fromPath(params.input.tokenize(' ')).set{cram}

if (params.input == null) {
    exit 1, helpMessage("ERROR: no --input specified")
}

process run_flagstat {
    label 'samtools'
    input:
    file cram

    output:
       file("${cram}.flagstat") into flagstat_file
    
    script:
    """
    samtools flagstat \
    -@ 1 \
    ${cram} > ${cram}.flagstat
    """
}

