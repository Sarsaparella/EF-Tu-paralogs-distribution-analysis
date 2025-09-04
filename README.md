# EF-Tu-paralogs-distribution-analysis
Repository with code for the "Sequence-specific trapping of EF-Tu/glycyl-tRNA complex on the ribosome by bottromycin" paper

Requirements:
- Python
- ncbi-datasets-cli software
- pandas 
- ete3
- jupyterlab

We run it with Python 3.12.3,  pandas=2.2.2, ncbi-datasets-cli=18.7.0, ete3=3.1.3, jupyterlab=4.0.12 on Linux Ubuntu 20.04.6 LTS, but any version will suffice as the pipeline itself is very simple.

The pipline can be run from tuf_genes_info_pipeline.ipynb jupyter notebook. In short, this pipeline downloads genomes, extracts info about tuf genes from gtf files and filters the resulting table.

Intermediate and resulting tables can be found in test_dataset_tables folder.
