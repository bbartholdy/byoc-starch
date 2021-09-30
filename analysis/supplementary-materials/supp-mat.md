---
title: Supplementary Materials
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
##  [1] forcats_0.5.1   stringr_1.4.0   dplyr_1.0.6     purrr_0.3.4    
##  [5] readr_1.4.0     tidyr_1.1.3     tibble_3.1.4    ggplot2_3.3.4  
##  [9] tidyverse_1.3.1 here_1.0.1     
## 
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.1.1 xfun_0.26        bslib_0.3.0      haven_2.4.1     
##  [5] colorspace_2.0-1 vctrs_0.3.8      generics_0.1.0   htmltools_0.5.2 
##  [9] yaml_2.2.1       utf8_1.2.2       rlang_0.4.11     jquerylib_0.1.4 
## [13] pillar_1.6.3     withr_2.4.2      glue_1.4.2       DBI_1.1.1       
## [17] dbplyr_2.1.1     modelr_0.1.8     readxl_1.3.1     lifecycle_1.0.1 
## [21] munsell_0.5.0    gtable_0.3.0     cellranger_1.1.0 rvest_1.0.0     
## [25] evaluate_0.14    knitr_1.36       fastmap_1.1.0    fansi_0.5.0     
## [29] broom_0.7.7      Rcpp_1.0.7       backports_1.2.1  scales_1.1.1    
## [33] jsonlite_1.7.2   fs_1.5.0         hms_1.1.0        digest_0.6.28   
## [37] stringi_1.7.4    rprojroot_2.0.2  grid_4.1.1       cli_3.0.1       
## [41] tools_4.1.1      magrittr_2.0.1   sass_0.4.0       crayon_1.4.1    
## [45] pkgconfig_2.0.3  ellipsis_0.3.2   xml2_1.3.2       reprex_2.0.0    
## [49] lubridate_1.7.10 rstudioapi_0.13  assertthat_0.2.1 rmarkdown_2.9   
## [53] httr_1.4.2       R6_2.5.1         compiler_4.1.1
```


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

**solution_counts**

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

## Amylase activity

Amylase activity in U/mL enzyme, where a U is mg maltose released from starch in six minutes at 36 &deg;C.

Tables containing the amylase activity results for both plates and photometric
readings.


```r
# table of results reported in units amylase per mL enzyme (but let's be honest,
  # ...it doesn't really matter what the unit is. No activity is no activity)
source(here("analysis/scripts/amylase-assay.R"))
cols <- c("1", "2", "3")  
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
raw_data %>%
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

Solution counts were extrapolated to the quantity in a 1 ml solution with
the following formula:

$$ \text{corrected count} = \text{raw count} \times \frac{\text{total} \space \text{transects}}{\text{counted} \space \text{transects}} \times 100 \mu l $$

Sample counts were extrapolated using the following formula:

$$ \text{Corrected count} = \text{raw count} \times (\text{portion of slide})^{-1} \times \frac{V_{sample}}{V_{slide}} $$

## Microscope images



