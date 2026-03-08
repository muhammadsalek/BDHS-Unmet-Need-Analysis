# Unmet Need for Family Planning — Bangladesh

## Association Between Internet Use and Unmet Need for Family Planning among Ever-Married Women in Bangladesh: Evidence from BDHS 2022

<div align="center">

[![License](https://img.shields.io/badge/License-MIT-10b981?style=for-the-badge&labelColor=0d1117&logo=opensourceinitiative&logoColor=10b981)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active%20Research-7c3aed?style=for-the-badge&labelColor=0d1117)](https://github.com)
[![Journal](https://img.shields.io/badge/Output-Q1%20Journal%20Ready-00d4ff?style=for-the-badge&labelColor=0d1117)](https://github.com)

</div>

<div align="center">

![Stata](https://img.shields.io/badge/Stata-1A5276?style=flat-square&logoColor=white)
![R](https://img.shields.io/badge/R_4.2+-276DC3?style=flat-square&logo=r&logoColor=white)
![BDHS](https://img.shields.io/badge/BDHS_2022-Data-00d4ff?style=flat-square&logoColor=white)
![sf](https://img.shields.io/badge/sf-spatial-228B22?style=flat-square&logoColor=white)
![spdep](https://img.shields.io/badge/spdep-spatial%20dependence-6A0DAD?style=flat-square&logoColor=white)
![spatialreg](https://img.shields.io/badge/spatialreg-spatial%20regression-DC143C?style=flat-square&logoColor=white)
![tmap](https://img.shields.io/badge/tmap-thematic%20maps-f59e0b?style=flat-square&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-ef4444?style=flat-square&logoColor=white)
![tidyverse](https://img.shields.io/badge/tidyverse-1a73e8?style=flat-square&logo=r&logoColor=white)
![viridis](https://img.shields.io/badge/viridis-color%20scales-10b981?style=flat-square&logoColor=white)
![patchwork](https://img.shields.io/badge/patchwork-plot%20layout-9333ea?style=flat-square&logoColor=white)

</div>

---

## Overview

This study examines the association between internet use and unmet need for family planning among ever-married women in Bangladesh, using data from the **Bangladesh Demographic and Health Survey (BDHS) 2022**. The analysis integrates spatial mapping at the division level with statistical modeling to identify regional disparities and the role of digital access in reproductive health outcomes.

**Pipeline:**

```
BDHS 2022 Survey Data
        │
        ▼
  Preprocessing          cleaning · recoding · survey weighting
        │
        ▼
  Statistical Analysis   logistic regression · odds ratios
    (Stata)              survey-weighted estimates
        │
        ▼
  Spatial Analysis       division-level choropleth maps
      (R)                prevalence mapping
        │
        ▼
  Outputs                Q1 figures · CSV tables · maps
```

---

## Authors

**Corresponding Author**

**Md Jamal Uddin, Ph.D.**
Professor, Department of Statistics
Shahjalal University of Science and Technology (SUST), Sylhet-3114, Bangladesh
Faculty of Graduate Education, Daffodil International University, Dhaka, Bangladesh
📞 +8801716972846
📧 [jamal-sta@sust.edu](mailto:jamal-sta@sust.edu)
[![ORCID](https://img.shields.io/badge/ORCID-0000--0002--8360--3274-A6CE39?style=flat-square&logo=orcid&logoColor=white)](https://orcid.org/0000-0002-8360-3274)

---

**Co-Author**

**Md Salek Miah**
Research Assistant, Department of Statistics
Shahjalal University of Science and Technology (SUST), Sylhet-3114, Bangladesh
📧 [saleksta@gmail.com](mailto:saleksta@gmail.com)
[![ORCID](https://img.shields.io/badge/ORCID-0009--0005--5973--461X-A6CE39?style=flat-square&logo=orcid&logoColor=white)](https://orcid.org/0009-0005-5973-461X)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Md_Salek_Miah-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/md-salek-miah-b34309329/)

---

**Affiliation**

Biostatistics, Epidemiology, and Public Health Research Team
Department of Statistics, Shahjalal University of Science & Technology (SUST), Sylhet-3114, Bangladesh

---

## Repository Structure

```
BDHS-Unmet-Need-Analysis/
│
├── README.md
├── Analysis.do                        ← Main Stata analysis script
│                                        (descriptive + logistic regression)
├── Spatials.do                        ← Stata spatial data preparation
├── Spatial_Figures.R                  ← R script for choropleth maps
├── division_unmet_need_share.csv      ← Division-level prevalence estimates
└── LICENSE                            ← MIT License
```

---

## Data Source

| Dataset | Source | Description |
|:--------|:-------|:------------|
| **BDHS 2022** | [DHS Program](https://dhsprogram.com) | Bangladesh Demographic & Health Survey 2022 |
| **Division Shapefile** | Bangladesh Admin Boundaries | 8 Divisions — spatial polygons |
| `division_unmet_need_share.csv` | Derived from BDHS | Division-level prevalence of unmet need |

> **Note:** Raw DHS microdata requires registration at [dhsprogram.com](https://dhsprogram.com). Derived/aggregated CSV outputs in this repository are freely available.

---

## Quick Start

**Requirements:** Stata `>= 15` · R `>= 4.2`

**Step 1 — Statistical Analysis (Stata)**

```stata
cd "/path/to/BDHS-Unmet-Need-Analysis"
do Analysis.do
do Spatials.do
```

**Step 2 — Spatial Figures (R)**

```r
packages <- c(
  "sf",           # spatial vector data handling
  "readxl",       # read Excel files
  "dplyr",        # data manipulation
  "stringr",      # string operations
  "janitor",      # data cleaning utilities
  "ggplot2",      # core visualization
  "ggspatial",    # spatial ggplot2 extensions
  "ggtext",       # rich text in ggplot2
  "tmap",         # thematic maps
  "spdep",        # spatial dependence & autocorrelation
  "spatialreg",   # spatial regression models
  "rmapshaper",   # simplify spatial geometries
  "viridis",      # accessible color scales
  "classInt",     # class interval methods
  "patchwork",    # combine multiple ggplots
  "tidyverse"     # complete data science toolkit
)

installed <- packages %in% rownames(installed.packages())
if (any(!installed)) {
  install.packages(packages[!installed], dependencies = TRUE)
}
invisible(lapply(packages, library, character.only = TRUE))

source("Spatial_Figures.R")
```

---

## Key Highlights

| Feature | Details |
|:--------|:--------|
| **Exposure Variable** | Internet use (frequency and access) |
| **Outcome Variable** | Unmet need for family planning |
| **Population** | Ever-married women of reproductive age |
| **Survey Design** | BDHS 2022 complex survey with proper weighting |
| **Spatial Scope** | 8 divisions of Bangladesh |
| **Statistical Method** | Weighted logistic regression · odds ratios · 95% CI |
| **Spatial Method** | Division-level choropleth mapping |
| **Output Format** | 300 DPI publication-ready figures |

---

## Research Impact

| Domain | Contribution |
|:-------|:-------------|
| **Reproductive Health** | Examines digital determinants of family planning uptake |
| **Spatial Epidemiology** | Maps geographic disparities in unmet need across divisions |
| **Public Health** | Evidence for SDG 3 — Universal Health Coverage monitoring |
| **Health Policy** | Actionable insights for targeted interventions in Bangladesh |

---

## Citation

```bibtex
@article{miah_uddin_unmet_need_2025,
  title   = {Association Between Internet Use and Unmet Need for Family Planning
             among Ever-Married Women in Bangladesh: Evidence from BDHS 2022},
  author  = {Miah, Md Salek and Uddin, Md Jamal},
  journal = {[Journal Name]},
  year    = {2025},
  note    = {Q1 Journal Submission},
  url     = {https://github.com/muhammadsalek/BDHS-Unmet-Need-Analysis}
}
```

---

## License

MIT License — Copyright (c) 2025 Md Salek Miah & Md Jamal Uddin
Open for academic research. Citation required for publication use.

---

<div align="center">

**Biostatistics, Epidemiology, and Public Health Research Team**
Department of Statistics · Shahjalal University of Science and Technology · Sylhet-3114, Bangladesh

[![Made with Stata](https://img.shields.io/badge/Made%20with-Stata-1A5276?style=flat-square&logoColor=white)](https://www.stata.com)
[![Made with R](https://img.shields.io/badge/Made%20with-R-276DC3?style=flat-square&logo=r&logoColor=white)](https://r-project.org)
[![BDHS 2022](https://img.shields.io/badge/Data-BDHS%202022-00d4ff?style=flat-square)](https://dhsprogram.com)
[![SUST](https://img.shields.io/badge/University-SUST%20Bangladesh-f59e0b?style=flat-square)](https://www.sust.edu)

*⭐ Star this repo if it helped your research!*

</div>
