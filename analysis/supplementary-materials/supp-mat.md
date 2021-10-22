---
title: Supplementary Material
output: 
  html_document:
    keep_md: true
    df_print: paged
    toc: true
    toc_float: true
---



## R Session info


```r
print(sessionInfo(), locale = FALSE)
```

```
## R version 4.1.1 (2021-08-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Pop!_OS 21.04
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.9.0
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] broom_0.7.9     patchwork_1.1.1 forcats_0.5.1   stringr_1.4.0  
##  [5] dplyr_1.0.7     purrr_0.3.4     readr_2.0.2     tidyr_1.1.4    
##  [9] tibble_3.1.5    ggplot2_3.3.5   tidyverse_1.3.1 here_1.0.1     
## 
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.1.1 xfun_0.26        haven_2.4.3      colorspace_2.0-2
##  [5] vctrs_0.3.8      generics_0.1.0   htmltools_0.5.2  yaml_2.2.1      
##  [9] utf8_1.2.2       rlang_0.4.11     jquerylib_0.1.4  pillar_1.6.3    
## [13] withr_2.4.2      glue_1.4.2       DBI_1.1.1        bit64_4.0.5     
## [17] dbplyr_2.1.1     modelr_0.1.8     readxl_1.3.1     lifecycle_1.0.1 
## [21] munsell_0.5.0    gtable_0.3.0     cellranger_1.1.0 rvest_1.0.1     
## [25] evaluate_0.14    knitr_1.36       tzdb_0.1.2       fastmap_1.1.0   
## [29] parallel_4.1.1   fansi_0.5.0      Rcpp_1.0.7       backports_1.2.1 
## [33] scales_1.1.1     vroom_1.5.5      jsonlite_1.7.2   bit_4.0.4       
## [37] fs_1.5.0         hms_1.1.1        digest_0.6.28    stringi_1.7.5   
## [41] rprojroot_2.0.2  grid_4.1.1       cli_3.0.1        tools_4.1.1     
## [45] magrittr_2.0.1   crayon_1.4.1     pkgconfig_2.0.3  ellipsis_0.3.2  
## [49] xml2_1.3.2       reprex_2.0.1     lubridate_1.8.0  rstudioapi_0.13 
## [53] assertthat_0.2.1 rmarkdown_2.11   httr_1.4.2       R6_2.5.1        
## [57] compiler_4.1.1
```

## Experimental setup


```r
knitr::include_graphics(here("analysis/figures/plate_lid_side.jpg"))
```

![The 24 deepwell plate and the lid with pegs (substrata)](/mnt/hogwarts/Uni/publications/PhD/byocstarch/analysis/figures/plate_lid_side.jpg)


```r
knitr::include_graphics(here("analysis/figures/plate_lid_on.jpg"))
```

![The 24 deepwell plate with the lid on (sort of...)](/mnt/hogwarts/Uni/publications/PhD/byocstarch/analysis/figures/plate_lid_on.jpg)

## Metadata for raw data files

Counts represent the absolute number of starches counted on a slide

**starch_counts.csv**

| variable | description |
|----|----|
| sample | Sample number. |
| plate | Plate number that the sample came from. |
| row | Which row on the plate the sample came from. |
| s | Small starch count. |
| m | Medium starch count. |
| l | Large starch count. |
| total | Sum of s, m, and l. |
| treatment | Treatment solution to which the samples were exposed. |
| starch | Type of starch that was counted. |
| weight | Weight of the biofilm sample. |
| vol | Total volume of EDTA in which the sample was dissolved. |
| portion_slide | Proportion of the microscope slide that was counted. Total transects on slide divided by counted transects. |

**solution_counts.csv**

| variable | description |
|----|----|
| solution | Type of starch in solution. |
| concentration | Concentration (%w/v) of starch in solution. | 
| vol_slide | Volume of solution added to slide. |
| vol_total | Total volume of solution in aliquot. |
| portion_slide | Proportion of slide that was counted. Total transects on slide divided by counted transects. |
| slide | Slide number. |
| starch | Starch type counted. |
| s | Small starch count. |
| m | Medium starch count. |
| l | Large starch count. |
| total | Sum of s, m, and l. |

## Raw data

Raw counts from the treatment solutions before extrapolation.

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["solution"],"name":[1],"type":["chr"],"align":["left"]},{"label":["concentration"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["vol_slide"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["vol_total"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["portion_slide"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["slide"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["starch"],"name":[7],"type":["chr"],"align":["left"]},{"label":["s"],"name":[8],"type":["dbl"],"align":["right"]},{"label":["m"],"name":[9],"type":["dbl"],"align":["right"]},{"label":["l"],"name":[10],"type":["dbl"],"align":["right"]},{"label":["total"],"name":[11],"type":["dbl"],"align":["right"]}],"data":[{"1":"wheat","2":"0.25","3":"10","4":"1000","5":"0.1034483","6":"1","7":"wheat","8":"969","9":"387","10":"167","11":"1523"},{"1":"wheat","2":"0.25","3":"10","4":"1000","5":"0.1034483","6":"2","7":"wheat","8":"1118","9":"445","10":"199","11":"1762"},{"1":"potato","2":"0.25","3":"10","4":"1000","5":"0.1034483","6":"1","7":"potato","8":"9","9":"95","10":"86","11":"190"},{"1":"potato","2":"0.25","3":"10","4":"1000","5":"0.1034483","6":"2","7":"potato","8":"7","9":"78","10":"115","11":"200"},{"1":"mix","2":"0.25","3":"10","4":"1000","5":"0.1034483","6":"1","7":"wheat","8":"1218","9":"414","10":"116","11":"1748"},{"1":"mix","2":"0.25","3":"10","4":"1000","5":"0.1034483","6":"1","7":"potato","8":"NA","9":"68","10":"60","11":"128"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Raw counts from the calculus samples before extrapolation:

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sample"],"name":[1],"type":["chr"],"align":["left"]},{"label":["plate"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["row"],"name":[3],"type":["chr"],"align":["left"]},{"label":["s"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["m"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["l"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["total"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["treatment"],"name":[8],"type":["chr"],"align":["left"]},{"label":["starch"],"name":[9],"type":["chr"],"align":["left"]},{"label":["weight"],"name":[10],"type":["dbl"],"align":["right"]},{"label":["vol"],"name":[11],"type":["dbl"],"align":["right"]},{"label":["portion_slide"],"name":[12],"type":["dbl"],"align":["right"]}],"data":[{"1":"st1A1","2":"1","3":"A","4":"39","5":"535","6":"119","7":"693","8":"potato","9":"potato","10":"5.80","11":"100","12":"1.0000000"},{"1":"st1A2","2":"1","3":"A","4":"6","5":"28","6":"5","7":"39","8":"potato","9":"potato","10":"5.81","11":"100","12":"1.0000000"},{"1":"st1A3","2":"1","3":"A","4":"26","5":"1392","6":"389","7":"1807","8":"potato","9":"potato","10":"8.22","11":"100","12":"1.0000000"},{"1":"st1A4","2":"1","3":"A","4":"14","5":"184","6":"40","7":"238","8":"potato","9":"potato","10":"4.65","11":"100","12":"1.0000000"},{"1":"st1A5","2":"1","3":"A","4":"20","5":"341","6":"98","7":"459","8":"potato","9":"potato","10":"7.68","11":"200","12":"1.0000000"},{"1":"st1A6","2":"1","3":"A","4":"32","5":"466","6":"159","7":"657","8":"potato","9":"potato","10":"7.79","11":"200","12":"1.0000000"},{"1":"st1B1","2":"1","3":"B","4":"62","5":"36","6":"4","7":"102","8":"wheat","9":"wheat","10":"5.15","11":"100","12":"0.1034483"},{"1":"st1B2","2":"1","3":"B","4":"508","5":"321","6":"18","7":"847","8":"wheat","9":"wheat","10":"4.56","11":"100","12":"0.2500000"},{"1":"st1B3","2":"1","3":"B","4":"606","5":"664","6":"73","7":"1343","8":"wheat","9":"wheat","10":"9.28","11":"100","12":"0.1034483"},{"1":"st1B4","2":"1","3":"B","4":"61","5":"51","6":"14","7":"126","8":"wheat","9":"wheat","10":"1.59","11":"100","12":"0.1034483"},{"1":"st1B5","2":"1","3":"B","4":"276","5":"227","6":"64","7":"567","8":"wheat","9":"wheat","10":"8.62","11":"200","12":"0.1034483"},{"1":"st1B6","2":"1","3":"B","4":"175","5":"96","6":"19","7":"290","8":"wheat","9":"wheat","10":"9.80","11":"200","12":"0.1034483"},{"1":"st1C1","2":"1","3":"C","4":"NA","5":"57","6":"19","7":"76","8":"mix","9":"potato","10":"4.09","11":"100","12":"0.1034483"},{"1":"st1C1","2":"1","3":"C","4":"97","5":"94","6":"50","7":"241","8":"mix","9":"wheat","10":"4.09","11":"100","12":"0.1034483"},{"1":"st1C2","2":"1","3":"C","4":"NA","5":"12","6":"13","7":"25","8":"mix","9":"potato","10":"1.50","11":"100","12":"0.1034483"},{"1":"st1C2","2":"1","3":"C","4":"31","5":"30","6":"9","7":"70","8":"mix","9":"wheat","10":"1.50","11":"100","12":"0.1034483"},{"1":"st1C3","2":"1","3":"C","4":"NA","5":"113","6":"20","7":"133","8":"mix","9":"potato","10":"8.44","11":"100","12":"0.1034483"},{"1":"st1C3","2":"1","3":"C","4":"351","5":"256","6":"39","7":"646","8":"mix","9":"wheat","10":"8.44","11":"100","12":"0.1034483"},{"1":"st1C4","2":"1","3":"C","4":"NA","5":"78","6":"25","7":"103","8":"mix","9":"potato","10":"5.42","11":"100","12":"0.1034483"},{"1":"st1C4","2":"1","3":"C","4":"392","5":"302","6":"68","7":"762","8":"mix","9":"wheat","10":"5.42","11":"100","12":"0.1034483"},{"1":"st1C5","2":"1","3":"C","4":"NA","5":"22","6":"10","7":"32","8":"mix","9":"potato","10":"6.12","11":"200","12":"1.0000000"},{"1":"st1C5","2":"1","3":"C","4":"5","5":"0","6":"0","7":"5","8":"mix","9":"wheat","10":"6.12","11":"200","12":"1.0000000"},{"1":"st1C6","2":"1","3":"C","4":"NA","5":"17","6":"0","7":"17","8":"mix","9":"potato","10":"1.91","11":"100","12":"1.0000000"},{"1":"st1C6","2":"1","3":"C","4":"97","5":"52","6":"12","7":"161","8":"mix","9":"wheat","10":"1.91","11":"100","12":"1.0000000"},{"1":"st1D1","2":"1","3":"D","4":"NA","5":"NA","6":"NA","7":"1","8":"control","9":"none","10":"6.51","11":"100","12":"1.0000000"},{"1":"st1D2","2":"1","3":"D","4":"NA","5":"NA","6":"NA","7":"0","8":"control","9":"none","10":"4.42","11":"100","12":"1.0000000"},{"1":"st1D3","2":"1","3":"D","4":"NA","5":"NA","6":"NA","7":"0","8":"control","9":"none","10":"5.01","11":"200","12":"1.0000000"},{"1":"st1D4","2":"1","3":"D","4":"NA","5":"NA","6":"NA","7":"0","8":"control","9":"none","10":"5.14","11":"100","12":"1.0000000"},{"1":"st1D5","2":"1","3":"D","4":"NA","5":"NA","6":"NA","7":"0","8":"control","9":"none","10":"4.51","11":"100","12":"1.0000000"},{"1":"st1D6","2":"1","3":"D","4":"NA","5":"NA","6":"NA","7":"0","8":"control","9":"none","10":"1.67","11":"NA","12":"NA"},{"1":"st2A1","2":"2","3":"A","4":"20","5":"150","6":"24","7":"194","8":"potato","9":"potato","10":"6.11","11":"200","12":"1.0000000"},{"1":"st2A2","2":"2","3":"A","4":"89","5":"479","6":"34","7":"602","8":"potato","9":"potato","10":"2.54","11":"100","12":"1.0000000"},{"1":"st2A3","2":"2","3":"A","4":"71","5":"370","6":"22","7":"463","8":"potato","9":"potato","10":"8.48","11":"200","12":"1.0000000"},{"1":"st2A4","2":"2","3":"A","4":"59","5":"773","6":"135","7":"967","8":"potato","9":"potato","10":"5.91","11":"200","12":"1.0000000"},{"1":"st2A5","2":"2","3":"A","4":"97","5":"512","6":"292","7":"901","8":"potato","9":"potato","10":"8.92","11":"200","12":"1.0000000"},{"1":"st2A6","2":"2","3":"A","4":"NA","5":"NA","6":"NA","7":"NA","8":"potato","9":"potato","10":"3.14","11":"NA","12":"NA"},{"1":"st2B1","2":"2","3":"B","4":"183","5":"130","6":"20","7":"333","8":"wheat","9":"wheat","10":"8.08","11":"200","12":"0.1034483"},{"1":"st2B2","2":"2","3":"B","4":"27","5":"19","6":"3","7":"49","8":"wheat","9":"wheat","10":"2.30","11":"100","12":"0.1034483"},{"1":"st2B3","2":"2","3":"B","4":"585","5":"409","6":"43","7":"660","8":"wheat","9":"wheat","10":"6.84","11":"100","12":"0.1034483"},{"1":"st2B4","2":"2","3":"B","4":"32","5":"21","6":"2","7":"55","8":"wheat","9":"wheat","10":"0.56","11":"100","12":"0.1034483"},{"1":"st2B5","2":"2","3":"B","4":"308","5":"263","6":"46","7":"617","8":"wheat","9":"wheat","10":"8.51","11":"200","12":"0.1034483"},{"1":"st2B6","2":"2","3":"B","4":"NA","5":"NA","6":"NA","7":"NA","8":"wheat","9":"wheat","10":"1.06","11":"NA","12":"NA"},{"1":"st2C1","2":"2","3":"C","4":"NA","5":"79","6":"17","7":"96","8":"mix","9":"potato","10":"5.04","11":"100","12":"0.1034483"},{"1":"st2C1","2":"2","3":"C","4":"521","5":"331","6":"58","7":"910","8":"mix","9":"wheat","10":"5.04","11":"100","12":"0.1034483"},{"1":"st2C2","2":"2","3":"C","4":"NA","5":"25","6":"1","7":"26","8":"mix","9":"potato","10":"3.64","11":"100","12":"0.1034483"},{"1":"st2C2","2":"2","3":"C","4":"182","5":"101","6":"25","7":"308","8":"mix","9":"wheat","10":"3.64","11":"100","12":"0.1034483"},{"1":"st2C3","2":"2","3":"C","4":"NA","5":"31","6":"4","7":"35","8":"mix","9":"potato","10":"4.11","11":"100","12":"0.1034483"},{"1":"st2C3","2":"2","3":"C","4":"252","5":"142","6":"19","7":"413","8":"mix","9":"wheat","10":"4.11","11":"100","12":"0.1034483"},{"1":"st2C4","2":"2","3":"C","4":"NA","5":"43","6":"13","7":"56","8":"mix","9":"potato","10":"3.61","11":"100","12":"0.1034480"},{"1":"st2C4","2":"2","3":"C","4":"327","5":"222","6":"45","7":"594","8":"mix","9":"wheat","10":"3.61","11":"100","12":"0.1034480"},{"1":"st2C5","2":"2","3":"C","4":"NA","5":"14","6":"0","7":"14","8":"mix","9":"potato","10":"3.17","11":"100","12":"1.0000000"},{"1":"st2C5","2":"2","3":"C","4":"14","5":"8","6":"0","7":"22","8":"mix","9":"wheat","10":"3.17","11":"100","12":"1.0000000"},{"1":"st2C6","2":"2","3":"C","4":"NA","5":"NA","6":"NA","7":"NA","8":"mix","9":"potato","10":"1.75","11":"NA","12":"NA"},{"1":"st2D1","2":"2","3":"D","4":"0","5":"0","6":"0","7":"0","8":"control","9":"none","10":"8.32","11":"100","12":"1.0000000"},{"1":"st2D2","2":"2","3":"D","4":"0","5":"0","6":"0","7":"0","8":"control","9":"none","10":"11.18","11":"200","12":"1.0000000"},{"1":"st2D3","2":"2","3":"D","4":"NA","5":"NA","6":"NA","7":"NA","8":"control","9":"none","10":"3.43","11":"NA","12":"NA"},{"1":"st2D4","2":"2","3":"D","4":"NA","5":"NA","6":"NA","7":"NA","8":"control","9":"none","10":"5.76","11":"NA","12":"NA"},{"1":"st2D5","2":"2","3":"D","4":"NA","5":"NA","6":"NA","7":"NA","8":"control","9":"none","10":"3.66","11":"NA","12":"NA"},{"1":"st2D6","2":"2","3":"D","4":"NA","5":"NA","6":"NA","7":"NA","8":"control","9":"none","10":"5.67","11":"NA","12":"NA"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

The raw data can be downloaded from GitHub:

```sh
# solution counts
wget https://github.com/bbartholdy/byoc-starch/blob/main/analysis/data/raw_data/solution_counts.csv

# sample counts
wget https://github.com/bbartholdy/byoc-starch/blob/main/analysis/data/raw_data/starch_counts.csv
```

## Microscope images

![Image of starch granules extracted from a potato treatment sample](/mnt/hogwarts/Uni/publications/PhD/byocstarch/analysis/figures/starches_w_bar.jpg)


```r
knitr::include_graphics(here("analysis/figures/SNAP-103412-0006.jpg"))
```

![](/mnt/hogwarts/Uni/publications/PhD/byocstarch/analysis/figures/SNAP-103412-0006.jpg)<!-- -->


```r
knitr::include_graphics(here("analysis/figures/SNAP-164650-0012.jpg"))
```

![Microscope image of wheat starch from a wheat treatment sample.](/mnt/hogwarts/Uni/publications/PhD/byocstarch/analysis/figures/SNAP-164650-0012.jpg)

## Amylase activity

Amylase activity in U/mL enzyme, where a U is mg maltose released from starch in six minutes at 36 &deg;C.

Tables containing the amylase activity results for both plates and both photometric
readings conducted on each plate. Samples (rows) were analysed in triplicates (columns).


```r
# table of results reported in units amylase per mL enzyme (but let's be honest,
  # ...it doesn't really matter what the unit is. No activity is no activity)
source(here("analysis/scripts/amylase-assay.R"))
cols <- c("1", "2", "3")  # sample triplicates
rows <- c("S1", "S2", "S3", "B1", "B2", "B3", "B4", "B5", "BT1", "BT2", "BT3")
plt1_ph1_result <- rbind(sal1_ph1, bmm1_ph1)
rownames(plt1_ph1_result) <- rows
plt1_ph2_result <- rbind(sal1_ph2, bmm1_ph2)
rownames(plt1_ph2_result) <- rows
plt2_ph1_result <- rbind(sal2_ph1, bmm2_ph1)
rownames(plt2_ph1_result) <- rows
plt2_ph2_result <- rbind(sal2_ph2, bmm2_ph2)
rownames(plt2_ph2_result) <- rows
```


```r
plt1_ph1_result
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["V1"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["V2"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["V3"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"9.6633544","2":"3.4437165","3":"9.7409060","_rn_":"S1"},{"1":"10.2992774","2":"4.7465833","3":"9.6090682","_rn_":"S2"},{"1":"9.1902896","2":"5.1498516","3":"9.6711095","_rn_":"S3"},{"1":"-0.2944638","2":"-0.2420948","3":"-0.2682793","_rn_":"B1"},{"1":"-0.1940899","2":"-0.3642891","3":"-0.2464589","_rn_":"B2"},{"1":"-0.2115462","2":"-0.4210222","3":"-0.1504490","_rn_":"B3"},{"1":"-0.2726434","2":"-0.4384786","3":"-0.3119201","_rn_":"B4"},{"1":"-0.3381046","2":"-0.3599251","3":"-0.2202744","_rn_":"B5"},{"1":"-0.4952116","2":"-0.4384786","3":"-0.4864835","_rn_":"BT1"},{"1":"-0.4864835","2":"-0.3031920","3":"-0.4952116","_rn_":"BT2"},{"1":"-0.5083039","2":"-0.4341145","3":"-0.4690271","_rn_":"BT3"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

```r
plt1_ph2_result
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["V1"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["V2"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["V3"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"9.5791455","2":"3.3993902","3":"9.5869680","_rn_":"S1"},{"1":"10.2049435","2":"4.7292109","3":"9.6260804","_rn_":"S2"},{"1":"9.1567319","2":"5.1516246","3":"9.7199501","_rn_":"S3"},{"1":"-0.2739597","2":"-0.2345669","3":"-0.2520748","_rn_":"B1"},{"1":"-0.1689122","2":"-0.3527452","3":"-0.2345669","_rn_":"B2"},{"1":"-0.1864201","2":"-0.4096459","3":"-0.1426504","_rn_":"B3"},{"1":"-0.2476978","2":"-0.4271538","3":"-0.2958445","_rn_":"B4"},{"1":"-0.3221064","2":"-0.3527452","3":"-0.2170590","_rn_":"B5"},{"1":"-0.4796775","2":"-0.4271538","3":"-0.4753006","_rn_":"BT1"},{"1":"-0.4709236","2":"-0.2914676","3":"-0.4796775","_rn_":"BT2"},{"1":"-0.4928085","2":"-0.4227768","3":"-0.4534157","_rn_":"BT3"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

```r
plt2_ph1_result
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["V1"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["V2"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["V3"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"9.6074482","2":"3.5463151","3":"9.2241068","_rn_":"S1"},{"1":"10.3307337","2":"4.6674077","3":"9.4989553","_rn_":"S2"},{"1":"8.9854226","2":"5.2677348","3":"9.5351196","_rn_":"S3"},{"1":"-0.2451714","2":"-0.2745476","3":"-0.2745476","_rn_":"B1"},{"1":"-0.1990089","2":"-0.3920521","3":"-0.2619578","_rn_":"B2"},{"1":"-0.1780260","2":"-0.4675907","3":"-0.1864192","_rn_":"B3"},{"1":"-0.2997271","2":"-0.4717873","3":"-0.3374964","_rn_":"B4"},{"1":"-0.2577612","2":"-0.4004453","3":"-0.2325817","_rn_":"B5"},{"1":"-0.5011634","2":"-0.4088385","3":"-0.4759839","_rn_":"BT1"},{"1":"-0.5011634","2":"-0.2913339","3":"-0.4885737","_rn_":"BT2"},{"1":"-0.5305396","2":"-0.3291032","3":"-0.5179498","_rn_":"BT3"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

```r
plt2_ph2_result
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["V1"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["V2"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["V3"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"9.6115786","2":"3.5595447","3":"9.1398973","_rn_":"S1"},{"1":"10.2719324","2":"4.6335267","3":"9.3721096","_rn_":"S2"},{"1":"8.9149416","2":"5.2430841","3":"9.4301627","_rn_":"S3"},{"1":"-0.2266208","2":"-0.2644543","3":"-0.2602506","_rn_":"B1"},{"1":"-0.1887873","2":"-0.3779548","3":"-0.2434357","_rn_":"B2"},{"1":"-0.1635650","2":"-0.4578255","3":"-0.1677687","_rn_":"B3"},{"1":"-0.2896767","2":"-0.4578255","3":"-0.3191027","_rn_":"B4"},{"1":"-0.2476394","2":"-0.3905660","3":"-0.2182134","_rn_":"B5"},{"1":"-0.4956590","2":"-0.3947697","3":"-0.4662330","_rn_":"BT1"},{"1":"-0.4914553","2":"-0.2728618","3":"-0.4746404","_rn_":"BT2"},{"1":"-0.5166776","2":"-0.3106953","3":"-0.5040665","_rn_":"BT3"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

## Control samples


```r
raw_counts %>%
  filter(treatment == "control") %>%
  select(!c(vol, portion_slide, s, m, l))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["sample"],"name":[1],"type":["chr"],"align":["left"]},{"label":["plate"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["row"],"name":[3],"type":["chr"],"align":["left"]},{"label":["total"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["treatment"],"name":[5],"type":["chr"],"align":["left"]},{"label":["starch"],"name":[6],"type":["chr"],"align":["left"]},{"label":["weight"],"name":[7],"type":["dbl"],"align":["right"]}],"data":[{"1":"st1D1","2":"1","3":"D","4":"1","5":"control","6":"none","7":"6.51"},{"1":"st1D2","2":"1","3":"D","4":"0","5":"control","6":"none","7":"4.42"},{"1":"st1D3","2":"1","3":"D","4":"0","5":"control","6":"none","7":"5.01"},{"1":"st1D4","2":"1","3":"D","4":"0","5":"control","6":"none","7":"5.14"},{"1":"st1D5","2":"1","3":"D","4":"0","5":"control","6":"none","7":"4.51"},{"1":"st1D6","2":"1","3":"D","4":"0","5":"control","6":"none","7":"1.67"},{"1":"st2D1","2":"2","3":"D","4":"0","5":"control","6":"none","7":"8.32"},{"1":"st2D2","2":"2","3":"D","4":"0","5":"control","6":"none","7":"11.18"},{"1":"st2D3","2":"2","3":"D","4":"NA","5":"control","6":"none","7":"3.43"},{"1":"st2D4","2":"2","3":"D","4":"NA","5":"control","6":"none","7":"5.76"},{"1":"st2D5","2":"2","3":"D","4":"NA","5":"control","6":"none","7":"3.66"},{"1":"st2D6","2":"2","3":"D","4":"NA","5":"control","6":"none","7":"5.67"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Only the total starch count was considered for control samples, as size was
deemed irrelevant.

## Count corrections

Slide transects were calculated by counting the number of transects on the 
cover slip under the microscope. This was done by starting in the bottom-left
corner, and counting the total number of full fields-of-view across the cover 
slip to the bottom-right corner. The total number of transects was 29 (verified
multiple times).

A 1 mL aliquot of each of the original treatment solutions was taken, from which
10 $\mu$L was taken and mounted on a microscope slide and mixed with 10 $\mu$L 
20% (v/v) glycerol. Solution counts were extrapolated from a slide (10 $\mu$L) 
to the quantity in a 1 ml solution,
and then multipled by 16 days to achieve the total number of granules that were
exposed to the samples:

$$ \text{corrected count} = \text{raw count} \times \frac{\text{total slides}}{\text{counted slides}} \times 100 \mu L \times 16 \text{ days} $$

Samples were submerged in 50--100 $\mu$L EDTA, from which 20 $\mu$L was mounted 
on a microscope slide ($V_{slide}$) and counted. Sample counts were extrapolated to the full
volume of EDTA ($V_{sample}$) in which the sample was submerged (i.e. 50--100 $\mu$L).

$$ \text{Corrected count} = \text{raw count} \times (\text{portion of slide})^{-1} \times \frac{V_{sample}}{V_{slide}} $$

## Some additional plots

Bar plot for the total count of granules exposed to the samples over the
duration of the experiment,


```r
sol_comb_long %>%
  filter(size == "total") %>%
  group_by(treatment, starch) %>%
  ggplot(aes(x = treatment, y = count, fill = treatment, col = starch)) +
  geom_col(size = 1.5) +
  theme(panel.background = element_rect(fill = "white"),
        panel.grid = element_line(colour = "grey"),
        panel.grid.major.x = element_blank(),
        axis.title.x = element_blank()) +
  scale_fill_viridis_d() +
  scale_color_viridis_d(begin = 0.5)
```

![](supp-mat_files/figure-html/solution-bar-pl-1.png)<!-- -->

and box plot with superimposed points (with added jitter) for the extrapolated
mean counts of granules extracted from the samples.


```r
corr_comb %>%
  filter(treatment != "control") %>%
  ggplot(aes(x = treatment, y = total, 
             shape = treatment)) +
    geom_boxplot(aes(fill = treatment), alpha = 0.5) +
    geom_jitter(aes(col = treatment), width = 0.3, size = 2) +
    scale_color_viridis_d() +
    theme(panel.background = element_rect(fill = "white"),
        panel.grid = element_line(colour = "grey"),
        panel.grid.major.x = element_blank(),
        axis.title.x = element_blank()) + # remove y-axis title
    scale_fill_viridis_d()
```

![](supp-mat_files/figure-html/sample-box-plot-1.png)<!-- -->

Size distribution within the solutions (top) and samples (bottom):


```r
sol_size_pl <- sol_corr %>%
  group_by(solution, starch) %>%
  summarise(across(c(s, m, l, total), mean, na.rm = T)) %>%
  pivot_longer(cols = c(s,m,l, total), values_to = "count", names_to = "size") %>%
  filter(size != "total") %>%
  group_by(solution, starch) %>%
  mutate(percent = count / sum(count, na.rm = T) * 100) %>% 
  ggplot(aes(x = starch, y = percent, fill = size)) +
    geom_col(position = "dodge") +
    facet_wrap(~ solution, scales = "free_x") +
    scale_fill_viridis_d() +
    theme_bw() +
    labs(x = "")

samp_size_pl <- corr_counts_long %>%
  filter(size != "total",
         treatment != "control") %>%
  group_by(treatment, starch, size) %>%
  summarise(count = mean(count, na.rm = T)) %>%
  mutate(percent = count / sum(count, na.rm = T) * 100) %>% 
  ggplot(aes(x = starch, y = percent, fill = size)) +
    geom_col(position = "dodge") +
    facet_wrap(~ treatment, scales = "free_x") +
    scale_fill_viridis_d() +
    theme_bw()

sol_size_pl / samp_size_pl + plot_layout(guides = "collect")
```

![](supp-mat_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

Size distribution within the samples:


```r
samp_size_pl <- corr_counts_long %>%
  filter(size != "total",
         treatment != "control") %>%
  group_by(treatment, starch, size) %>%
  summarise(count = mean(count, na.rm = T)) %>%
  mutate(percent = count / sum(count, na.rm = T) * 100) %>% 
  ggplot(aes(x = starch, y = percent, fill = size)) +
    geom_col(position = "dodge") +
    facet_wrap(~ treatment, scales = "free_x") +
    scale_fill_viridis_d() +
    theme_bw()
```
