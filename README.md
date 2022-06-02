
<!-- README.md is generated from README.Rmd. Please edit that file -->

# byocstarch

<!--[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/bbartholdy/byoc-starch/main?urlpath=rstudio)-->

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5604670.svg)](https://doi.org/10.5281/zenodo.5604670)
![Current
version](https://img.shields.io/github/v/release/bbartholdy/byoc-starch?label=version)
<!-- DOI badge: [![DOI](.svg)](repo link) -->

<!-- Document structure provided by rrtools package -->

This repository contains the data and code for our paper:

> *Investigating Biases Associated with Dietary Starch Incorporation and
> Retention in an Oral Biofilm Model*. Bjørn Peare Bartholdy, Amanda G.
> Henry, bioRxiv 2021.10.27.466104; doi:
> <https://doi.org/10.1101/2021.10.27.466104>

<!--
Our pre-print is online here:

> Authors, (YYYY). _Investigating Biases Associated with Dietary Starch Incorporation and Retention in an Oral Biofilm Model_. Name of journal/book, Accessed 02 Jun 2022. Online at <https://doi.org/xxx/xxx>

### How to cite

Please cite this compendium as:

> Authors, (2022). _Compendium of R code and data for Investigating Biases Associated with Dietary Starch Incorporation and Retention in an Oral Biofilm Model_. Accessed 02 Jun 2022. Online at <https://doi.org/xxx/xxx> -->

## Contents

The **analysis** directory contains:

-   [:file_folder: paper](/analysis/paper): R Markdown source document
    for manuscript. Includes code to reproduce the figures and tables
    generated by the analysis. It also has a [rendered
    version](https://github.com/bbartholdy/byoc-starch/blob/main/analysis/paper/index.pdf)
    suitable for reading (the code is replaced by figures and tables in
    this file)
-   [:file_folder: data](/analysis/data): Data used in the analysis.
-   [:file_folder: figures](/analysis/figures): Plots and other
    illustrations
-   [:file_folder:
    supplementary-materials](/analysis/supplementary-materials):
    Supplementary materials including notes and other documents prepared
    and collected during the analysis.

## How to run in your browser or download and run locally

This compendium can be accessed in a web browser using
[binder](https://mybinder.org/v2/gh/bbartholdy/byoc-starch/main?urlpath=rstudio).

To work with the compendium locally, you will need installed on your
computer the [R software](https://cloud.r-project.org/) itself and
optionally [RStudio
Desktop](https://rstudio.com/products/rstudio/download/).

You can download the compendium as a zip from from this URL:
[master.zip](/archive/master.zip). After unzipping: - open the `.Rproj`
file in RStudio - run `devtools::install()` to ensure you have the
packages this analysis depends on (also listed in the
[DESCRIPTION](/DESCRIPTION) file). - finally, open
`analysis/paper/paper.Rmd` and knit to produce the `paper.pdf`, or run
`rmarkdown::render("analysis/paper/paper.Rmd")` in the R console

### Licenses

**Text and figures :**
[CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)

**Code :** See the [DESCRIPTION](DESCRIPTION) file

**Data :** [CC-0](http://creativecommons.org/publicdomain/zero/1.0/)
attribution requested in reuse

### Contributions

We welcome contributions from everyone. Before you get started, please
see our [contributor guidelines](CONTRIBUTING.md). Please note that this
project is released with a [Contributor Code of Conduct](CONDUCT.md). By
participating in this project you agree to abide by its terms.
