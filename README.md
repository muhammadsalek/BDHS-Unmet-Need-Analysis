<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:1e3a8a,50:1e40af,100:312e81&height=220&section=header&text=BDHS%20Unmet%20Need%20Analysis&fontSize=42&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=Internet%20Use%20%26%20Unmet%20Need%20for%20Family%20Planning%20in%20Bangladesh&descAlignY=58&descSize=18" width="100%"/>

<br/>

# Association Between Internet Use and Unmet Need for Family Planning among Currently Pregnant Women in Bangladesh

### Evidence from the Bangladesh Demographic and Health Survey (BDHS) 2022

<br/>

[![Journal](https://img.shields.io/badge/Published_in-BMC_Women's_Health-1e3a8a?style=for-the-badge&labelColor=0d1117&logo=springernature&logoColor=00d4ff)](https://doi.org/10.1186/s12905-026-04788-2)
[![DOI](https://img.shields.io/badge/DOI-10.1186%2Fs12905--026--04788--2-7c3aed?style=for-the-badge&labelColor=0d1117)](https://doi.org/10.1186/s12905-026-04788-2)
[![Open Access](https://img.shields.io/badge/Access-Open_Access-10b981?style=for-the-badge&labelColor=0d1117&logo=unlock&logoColor=10b981)](https://www.springernature.com/gp/open-science/about/the-fundamentals-of-open-access-and-open-research)
[![Peer Review](https://img.shields.io/badge/Peer_Review-2_Rounds%2C_5_Reviewers-e11d48?style=for-the-badge&labelColor=0d1117)](#-peer-review--revision-trail)
[![License](https://img.shields.io/badge/License-MIT-f59e0b?style=for-the-badge&labelColor=0d1117)](LICENSE)

<img src="https://readme-typing-svg.demolab.com?font=Georgia&size=17&duration=3200&pause=900&color=1E40AF&center=true&vCenter=true&width=780&lines=Nationally+representative+BDHS+2022+cohort+%7C+n+%3D+4%2C370+pregnant+women;Stepwise+survey-weighted+multivariable+logistic+regression;Divisional+choropleth+mapping+of+unmet+need+prevalence;Full+methodology%2C+figures%2C+tables+%26+peer-review+trail+included;Published+%E2%80%94+BMC+Women's+Health+(2026)" alt="Typing SVG" />

</div>

---

## 📖 Citation

> Miah, M.S., Uddin, M.J. **Association between internet use and unmet need for family planning among currently pregnant women in Bangladesh: evidence from BDHS 2022.** *BMC Women's Health* (2026). https://doi.org/10.1186/s12905-026-04788-2

```bibtex
@article{miah_uddin_2026_unmet_need,
  title    = {Association between internet use and unmet need for family planning
              among currently pregnant women in Bangladesh: evidence from BDHS 2022},
  author   = {Miah, Md Salek and Uddin, Md Jamal},
  journal  = {BMC Women's Health},
  year     = {2026},
  doi      = {10.1186/s12905-026-04788-2},
  url      = {https://doi.org/10.1186/s12905-026-04788-2},
  note     = {Open Access}
}
```

[![Download PDF](https://img.shields.io/badge/Download-Full_Text_PDF-DC143C?style=flat-square&logo=adobeacrobatreader&logoColor=white)](https://link.springer.com/content/pdf/10.1186/s12905-026-04788-2_reference.pdf)
[![Supplementary Material](https://img.shields.io/badge/Supplementary-Material_1_(.docx)-228B22?style=flat-square&logo=microsoftword&logoColor=white)](https://media.springernature.com/original/springer-static/esm/art%3A10.1186%2Fs12905-026-04788-2/MediaObjects/12905_2026_4788_MOESM1_ESM.docx)

---

## 🧭 Overview

Unmet need for family planning remains a persistent public health challenge in low- and middle-income countries and a core indicator for **SDG 3 — Universal Health Coverage**. This study is among the first to examine how **internet use** relates to unmet need for family planning specifically among **currently pregnant women** in Bangladesh, integrating nationally representative survey data with divisional spatial mapping to surface where the burden concentrates.

This repository is a **complete, transparent research compendium** — not just analysis scripts. It contains the full audit trail from raw modeling through two rounds of peer review to the final published figures and tables, in line with open-science and reproducibility norms (STROBE-compliant reporting).

```
                         BDHS 2022 (n = 4,370 currently pregnant women, 15–49y)
                                            │
                                            ▼
                     ┌──────────────────────────────────────────┐
                     │   Preprocessing & Survey Weighting        │
                     │   cleaning · recoding · complex design    │
                     └──────────────────────────────────────────┘
                                            │
                                            ▼
                     ┌──────────────────────────────────────────┐
                     │   Stepwise Survey-Weighted Multivariable  │
                     │   Logistic Regression   (Stata)           │
                     └──────────────────────────────────────────┘
                                            │
                            ┌───────────────┴───────────────┐
                            ▼                                ▼
              ┌───────────────────────┐        ┌───────────────────────────┐
              │  Stratified Analyses  │        │  Spatial / Divisional      │
              │  residence · division │        │  Choropleth Mapping (R)    │
              │  age · education ·    │        │  prevalence disparities    │
              │  media exposure       │        │                            │
              └───────────────────────┘        └───────────────────────────┘
                            │                                │
                            └───────────────┬────────────────┘
                                             ▼
                          Q1 Journal Figures · Tables · Maps
                          → 2 Rounds Peer Review (5 Reviewers)
                            → Published in BMC Women's Health
```

---

## 👥 Authors & Affiliations

<table>
<tr>
<td width="50%" valign="top">

### Md Salek Miah *(First Author)*
Research Assistant, Department of Statistics
Shahjalal University of Science and Technology (SUST)
Sylhet-3114, Bangladesh

📧 [saleksta@gmail.com](mailto:saleksta@gmail.com)
[![ORCID](https://img.shields.io/badge/ORCID-0009--0005--5973--461X-A6CE39?style=flat-square&logo=orcid&logoColor=white)](https://orcid.org/0009-0005-5973-461X)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/md-salek-miah-b34309329/)
[![Google Scholar](https://img.shields.io/badge/Google_Scholar-Profile-4285F4?style=flat-square&logo=googlescholar&logoColor=white)](https://scholar.google.co.uk/scholar?as_sauthors=%22Md%20Salek%20Miah%22)
[![Springer Profile](https://img.shields.io/badge/Springer-Author_Profile-1e3a8a?style=flat-square&logo=springer&logoColor=white)](https://link.springer.com/researchers/74308750SN)
[![YouTube](https://img.shields.io/badge/YouTube-@SalekResearch-FF0000?style=flat-square&logo=youtube&logoColor=white)](https://www.youtube.com/@SalekResearch)

</td>
<td width="50%" valign="top">

### Md Jamal Uddin, Ph.D. *(Corresponding Author)*
Professor, Department of Statistics, SUST, Sylhet-3114, Bangladesh
Faculty of Graduate Education, Daffodil International University, Dhaka

📞 +8801716972846
📧 [jamal-sta@sust.edu](mailto:jamal-sta@sust.edu)
[![ORCID](https://img.shields.io/badge/ORCID-0000--0002--8360--3274-A6CE39?style=flat-square&logo=orcid&logoColor=white)](https://orcid.org/0000-0002-8360-3274)

</td>
</tr>
</table>

<div align="center">

**Biostatistics, Epidemiology, and Public Health Research Team**
Department of Statistics · Shahjalal University of Science & Technology (SUST) · Sylhet-3114, Bangladesh

</div>

---

## 🔑 Key Findings

<div align="center">

| Metric | Estimate |
|:--|:--:|
| Sample size | **n = 4,370** currently pregnant women, 15–49 years |
| Prevalence of unmet need for FP | **41%** |
| Internet use → unmet need (adjusted) | **aOR = 1.83** (95% CI: 1.52–2.20) |
| Early age at first birth (10–17y) | **aOR = 2.70** (95% CI: 1.91–3.82) |
| Age 25–34 years | **aOR = 2.41** (95% CI: 1.82–3.17) |
| No formal education | **aOR = 5.34** (95% CI: 1.70–16.71) |
| Barishal division | **aOR = 3.24** (95% CI: 1.99–5.28) |
| Rajshahi division | **aOR = 3.30** (95% CI: 1.62–6.72) |
| Sylhet division | **aOR = 2.98** (95% CI: 1.96–4.53) |
| Highest raw prevalence (spatial) | **Chattogram** division |

</div>

> Internet use was significantly associated with a higher unmet need for family planning among currently pregnant women in Bangladesh, with the strength of association varying meaningfully across socio-demographic and regional subgroups — evidence that can help target family planning programs toward the population groups carrying the greatest burden.

---

## 🛠️ Tech Stack

<div align="center">

![Stata](https://img.shields.io/badge/Stata-1A5276?style=flat-square&logoColor=white)
![R](https://img.shields.io/badge/R_4.2+-276DC3?style=flat-square&logo=r&logoColor=white)
![LaTeX](https://img.shields.io/badge/LaTeX-Flowchart-008080?style=flat-square&logo=latex&logoColor=white)
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

## 📂 Repository Structure

```
BDHS-Unmet-Need-Analysis/
│
├── README.md                              ← You are here
├── LICENSE                                ← MIT License
│
├── 📊 ANALYSIS CODE
│   ├── Analysis.do                        ← Main Stata script (descriptive + stepwise logistic regression)
│   ├── Spatials.do                        ← Stata spatial data preparation
│   └── Spatial_Figures.R                  ← R script for divisional choropleth maps
│
├── 🗃️ DATA
│   ├── descriptive_data.dta               ← Cleaned analytic dataset (Stata format)
│   └── division_unmet_need_share.csv      ← Division-level prevalence estimates
│
├── 🖼️ METHODOLOGY & FIGURES
│   ├── Flowchart.tex                      ← LaTeX source — participant selection flowchart
│   ├── Contraception_BD.pdf               ← Rendered methodology flowchart (PDF)
│   └── Figure 1.pdf                       ← Manuscript Figure 1
│
├── 📑 PUBLICATION TABLES
│   ├── Table 1.docx                       ← Table 1 — sample characteristics
│   └── Table 2.docx                       ← Table 2 — regression results
│
└── 🔁 PEER REVIEW & REVISION TRAIL
    ├── reviewrs 2.pdf                     ← Reviewer 2 comments (Round 1)
    ├── Tracked_Changed_Comments_Reviewr_1.pdf   ← Reviewer 1 tracked-changes (Round 1)
    ├── RESPONSE LETTER.pdf                ← Author response letter (Round 1)
    ├── Reviewr 3.pdf                      ← Reviewer 3 comments (Round 2)
    ├── Reviewr 4.docx                     ← Reviewer 4 comments (Round 2)
    ├── Reviewr 5.docx                     ← Reviewer 5 comments (Round 2)
    └── Response Letter_V2.pdf             ← Author response letter (Round 2)
```

---

## 🔁 Peer Review & Revision Trail

This repository documents the **complete editorial history** of the manuscript from submission to acceptance at *BMC Women's Health* — provided in the spirit of open, transparent, and reproducible science.

| Round | Reviewer Feedback | Author Response |
|:--:|:--|:--|
| **Round 1** | [`reviewrs 2.pdf`](reviewrs%202.pdf) · [`Tracked_Changed_Comments_Reviewr_1.pdf`](Tracked_Changed_Comments_Reviewr_1.pdf) | [`RESPONSE LETTER.pdf`](RESPONSE%20LETTER.pdf) |
| **Round 2** | [`Reviewr 3.pdf`](Reviewr%203.pdf) · [`Reviewr 4.docx`](Reviewr%204.docx) · [`Reviewr 5.docx`](Reviewr%205.docx) | [`Response Letter_V2.pdf`](Response%20Letter_V2.pdf) |

> **Timeline:** Received 08 March 2026 → Accepted 10 August 2026 → Published 19 August 2026 — five independent reviewers across two revision rounds.

---

## 🗂️ Data Source

| Dataset | Source | Description |
|:--|:--|:--|
| **BDHS 2022** | [DHS Program](https://dhsprogram.com) | Bangladesh Demographic & Health Survey 2022 |
| **Division Shapefile** | Bangladesh Admin Boundaries | 8 Divisions — spatial polygons |
| `descriptive_data.dta` | Cleaned analytic sample | Currently pregnant women, 15–49y, weighted |
| `division_unmet_need_share.csv` | Derived from BDHS | Division-level prevalence of unmet need |

> **Note:** Raw DHS microdata requires registration at [dhsprogram.com](https://dhsprogram.com). Derived/aggregated data files in this repository are freely available.

---

## 🚀 Quick Start

**Requirements:** Stata `>= 15` · R `>= 4.2` · LaTeX (for flowchart compilation, optional)

**Step 1 — Statistical Analysis (Stata)**

```stata
cd "/path/to/BDHS-Unmet-Need-Analysis"
use "descriptive_data.dta", clear
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

**Step 3 — Methodology Flowchart (LaTeX, optional)**

```bash
pdflatex Flowchart.tex
# → renders Contraception_BD.pdf
```

---

## 🔬 Methodology at a Glance

| Feature | Details |
|:--|:--|
| **Exposure Variable** | Internet use (frequency and access) |
| **Outcome Variable** | Unmet need for family planning |
| **Population** | Currently pregnant women, 15–49 years |
| **Sample Size** | n = 4,370 |
| **Survey Design** | BDHS 2022 complex survey with proper weighting |
| **Statistical Method** | Stepwise survey-weighted multivariable logistic regression · aOR/cOR · 95% CI |
| **Stratification** | Residence · division · maternal age · age at first birth · education · media exposure |
| **Spatial Scope** | 8 divisions of Bangladesh |
| **Spatial Method** | Descriptive divisional choropleth mapping |
| **Reporting Standard** | STROBE-compliant, with a participant-flow methodology flowchart |
| **Output Format** | 300 DPI publication-ready figures and formatted tables |
| **Peer Review** | 2 rounds, 5 independent reviewers — full trail archived in this repository |
| **AI Disclosure** | Grammarly / QuillBot / GPT-4 used for language editing only — no AI involvement in data generation, analysis, or interpretation |

---

## 🌍 Research Impact

| Domain | Contribution |
|:--|:--|
| **Reproductive Health** | Examines digital determinants of family planning uptake among pregnant women |
| **Spatial Epidemiology** | Maps geographic disparities in unmet need across Bangladesh's 8 divisions |
| **Public Health** | Evidence for SDG 3 — Universal Health Coverage monitoring |
| **Health Policy** | Actionable, subgroup-level insight for targeted family planning interventions |
| **Open Science** | Full reproducibility package — code, data, figures, tables, and complete peer-review trail |

---

## 🎓 Learn the Methods — Salek Data Lab

Free, hands-on tutorials on DHS data management, survey-weighted logistic regression, and R/Stata workflows for public health research:

<div align="center">

[![YouTube](https://img.shields.io/badge/YouTube-Salek_Research_Hub-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@SalekResearch)

</div>

---

## 📜 License

MIT License (code) — Copyright (c) 2026 Md Salek Miah & Md Jamal Uddin
Article content is licensed **CC BY-NC-ND 4.0** by the authors under BMC Women's Health / Springer Nature. Citation required for any reuse.

---

<div align="center">

**Biostatistics, Epidemiology, and Public Health Research Team**
Department of Statistics · Shahjalal University of Science and Technology · Sylhet-3114, Bangladesh

[![Made with Stata](https://img.shields.io/badge/Made%20with-Stata-1A5276?style=flat-square&logoColor=white)](https://www.stata.com)
[![Made with R](https://img.shields.io/badge/Made%20with-R-276DC3?style=flat-square&logo=r&logoColor=white)](https://r-project.org)
[![BDHS 2022](https://img.shields.io/badge/Data-BDHS%202022-00d4ff?style=flat-square)](https://dhsprogram.com)
[![SUST](https://img.shields.io/badge/University-SUST%20Bangladesh-f59e0b?style=flat-square)](https://www.sust.edu)

*⭐ Star this repo if it helped your research!*

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:312e81,50:1e40af,100:1e3a8a&height=100&section=footer" width="100%"/>

</div>
