<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0B1F3A,45:173B6C,100:2B59C3&height=230&section=header&text=BDHS%20Unmet%20Need%20Analysis&fontSize=43&fontColor=FFFFFF&animation=fadeIn&fontAlignY=36&desc=Internet%20Use%20%26%20Family%20Planning%20%7C%20Bangladesh%20%7C%20BDHS%202022&descAlignY=57&descSize=18" width="100%" alt="Repository header" />

Association Between Internet Use and Unmet Need for Family Planning among Currently Pregnant Women in Bangladesh

A reproducible public-health analysis using the Bangladesh Demographic and Health Survey (BDHS) 2022

<br>













<br>

Peer-reviewed research repository · Survey epidemiology · Reproductive health · Spatial public health · Stata + R

Read the article ·
Explore the workflow ·
Reproduce the analysis ·
Cite this work

</div>

🧭 Repository at a Glance





Study population

Currently pregnant women aged 15–49 years

Dataset

Bangladesh Demographic and Health Survey (BDHS) 2022

Analytic sample

n = 4,370

Primary exposure

Internet use

Primary outcome

Unmet need for family planning

Statistical framework

Complex-survey weighted descriptive and multivariable analyses

Primary model

Stepwise survey-weighted multivariable logistic regression

Spatial component

Division-level choropleth mapping across Bangladesh

Statistical software

Stata + R

Publication status

Published in BMC Women's Health (2026)

Purpose of this repository: to provide a transparent, publication-linked record of the statistical and spatial workflow used in the study, while respecting DHS data-access requirements.

🔬 Research Overview

Unmet need for family planning remains an important public-health challenge in low- and middle-income settings. This study examines whether internet use is associated with unmet need for family planning among currently pregnant women in Bangladesh, using nationally representative BDHS 2022 data and complementary divisional spatial analysis.

The repository brings together the main statistical analysis, spatial data preparation, R-based map generation, and derived division-level outputs used to support the published study.

Research question

Among currently pregnant women in Bangladesh, is internet use associated with unmet need for family planning after accounting for relevant socio-demographic and contextual factors?

🔑 Key Findings

<div align="center">
<table>
<tr>
<td align="center" width="25%"><b>4,370</b><br><sub>Pregnant women</sub></td>
<td align="center" width="25%"><b>41%</b><br><sub>Unmet need prevalence</sub></td>
<td align="center" width="25%"><b>1.83</b><br><sub>aOR for internet use</sub></td>
<td align="center" width="25%"><b>8</b><br><sub>Divisions mapped</sub></td>
</tr>
</table>
</div>

Predictor / estimate

Adjusted association

Internet use → unmet need

aOR 1.83 (95% CI 1.52–2.20)

Early age at first birth (10–17 years)

aOR 2.70 (95% CI 1.91–3.82)

Maternal age 25–34 years

aOR 2.41 (95% CI 1.82–3.17)

No formal education

aOR 5.34 (95% CI 1.70–16.71)

Barishal division

aOR 3.24 (95% CI 1.99–5.28)

Rajshahi division

aOR 3.30 (95% CI 1.62–6.72)

Sylhet division

aOR 2.98 (95% CI 1.96–4.53)

Highest raw spatial prevalence

Chattogram division

The published analysis found a statistically significant positive association between internet use and unmet need for family planning among currently pregnant women, with meaningful socio-demographic and regional heterogeneity.

🧪 Analytical Workflow

flowchart TD
    A[BDHS 2022<br/>Currently pregnant women<br/>n = 4,370] --> B[Data cleaning and recoding]
    B --> C[Complex survey design<br/>weights · strata · clusters]
    C --> D[Weighted descriptive analysis]
    C --> E[Survey-weighted logistic regression]
    E --> F[Adjusted odds ratios<br/>95% confidence intervals]
    E --> G[Stratified analyses]
    D --> H[Division-level estimates]
    H --> I[Spatial data preparation in Stata]
    I --> J[Choropleth mapping in R]
    F --> K[Publication tables and interpretation]
    G --> K
    J --> K
    K --> L[Peer-reviewed article<br/>BMC Women's Health · 2026]

Analysis components

Data preparation — sample restriction, cleaning, recoding, and variable construction.

Survey design — application of BDHS sampling weights and complex survey structure.

Descriptive epidemiology — weighted prevalence estimates and subgroup summaries.

Multivariable modeling — stepwise survey-weighted logistic regression.

Effect estimation — crude/adjusted odds ratios and 95% confidence intervals.

Stratified analysis — assessment across selected demographic and geographic subgroups.

Spatial analysis — division-level preparation and choropleth visualization in R.

📂 Repository Structure

BDHS-Unmet-Need-Analysis/
│
├── README.md
│   └── Project overview, methods, reproducibility, citation and data notes
│
├── Analysis.do
│   └── Main Stata workflow: cleaning, descriptive analysis and regression
│
├── Spatials.do
│   └── Stata preparation of division-level spatial analysis inputs
│
├── Spatial_Figures.R
│   └── R workflow for publication-ready divisional choropleth figures
│
├── division_unmet_need_share.csv
│   └── Derived division-level prevalence estimates
│
└── LICENSE
    └── MIT license for repository code

🗂️ Data Source & Governance

Bangladesh Demographic and Health Survey 2022

The individual-level data used for this study come from the Bangladesh Demographic and Health Survey (BDHS) 2022, distributed through the DHS Program.

Resource

Access

Use in this project

BDHS 2022 microdata

Registration / authorization through DHS Program

Main individual-level statistical analysis

Bangladesh division boundaries

Administrative spatial boundary data

Division-level mapping

division_unmet_need_share.csv

Repository-derived aggregated output

Reproducible spatial visualization

Important data-access note

Raw DHS microdata are not redistributed in this repository. Researchers who wish to reproduce the individual-level analysis must independently request access through the DHS Program and comply with the DHS terms of use.

Responsible use

This repository is intended for research, education, reproducibility, and methodological transparency. Users are responsible for complying with all applicable DHS data-access conditions and for avoiding attempts to identify survey participants.

🧬 Methodology

Component

Specification

Exposure

Internet use (frequency and access)

Outcome

Unmet need for family planning

Population

Currently pregnant women, 15–49 years

Sample size

n = 4,370

Survey design

BDHS 2022 complex survey design with weighting

Main model

Stepwise survey-weighted multivariable logistic regression

Effect measures

cOR / aOR with 95% confidence intervals

Stratification

Residence, division, maternal age, age at first birth, education, media exposure

Spatial scope

Eight administrative divisions of Bangladesh

Spatial method

Descriptive division-level choropleth mapping

Figure output

Publication-ready high-resolution graphics

Interpretation note

Odds ratios are interpreted as associations, not causal effects. The cross-sectional survey design does not by itself establish temporality or causation.

💻 Software & Requirements

Software

Minimum version

Role

Stata

15+

Survey analysis, regression, spatial-data preparation

R

4.2+

Spatial visualization and publication-ready mapping

R packages

Spatial_Figures.R uses packages from the spatial and tidyverse ecosystem, including:

sf · readxl · dplyr · stringr · janitor · ggplot2 · ggspatial · ggtext · tmap · spdep · spatialreg · rmapshaper · viridis · classInt · patchwork · tidyverse

🚀 Quick Start

1. Obtain authorized BDHS 2022 microdata

Request access through the DHS Program and place the required source files in your local analysis environment. Raw DHS files are intentionally not included here.

2. Clone or download this repository

git clone <YOUR-REPOSITORY-URL>
cd BDHS-Unmet-Need-Analysis

Replace <YOUR-REPOSITORY-URL> with the actual GitHub repository URL.

3. Run the Stata workflow

cd "/path/to/BDHS-Unmet-Need-Analysis"
do Analysis.do
do Spatials.do

4. Generate spatial figures in R

<details>
<summary><b>Click to expand R package setup</b></summary>

packages <- c(
  "sf",
  "readxl",
  "dplyr",
  "stringr",
  "janitor",
  "ggplot2",
  "ggspatial",
  "ggtext",
  "tmap",
  "spdep",
  "spatialreg",
  "rmapshaper",
  "viridis",
  "classInt",
  "patchwork",
  "tidyverse"
)

installed <- packages %in% rownames(installed.packages())

if (any(!installed)) {
  install.packages(packages[!installed], dependencies = TRUE)
}

invisible(lapply(packages, library, character.only = TRUE))

source("Spatial_Figures.R")

</details>

♻️ Reproducibility

Reproducibility element

Repository support

Main statistical workflow

✅ Analysis.do

Spatial data preparation

✅ Spatials.do

Spatial figure generation

✅ Spatial_Figures.R

Derived division-level estimates

✅ division_unmet_need_share.csv

Raw DHS microdata

🔒 Restricted by DHS access policy; not redistributed

Software requirements

✅ Documented above

Published DOI

✅ Linked

Code license

✅ MIT

Reproducibility principle

The goal is to make the analytic logic, code, software environment, derived outputs, and publication link transparent while respecting restrictions on participant-level DHS data.

🌍 Public-Health Relevance

Domain

Contribution

Reproductive health

Examines digital access as a correlate of unmet family-planning need

Survey epidemiology

Uses a nationally representative DHS dataset and complex-survey analysis

Spatial epidemiology

Describes regional disparities across Bangladesh's eight divisions

Health equity

Highlights socio-demographic and geographic heterogeneity

Policy translation

Supports more targeted family-planning planning and communication strategies

Open research practice

Links publication, code, derived outputs, and reproducibility guidance

👥 Authors & Affiliations

<table>
<tr>
<td width="50%" valign="top">

Md Salek Miah

First Author

Research Assistant
Department of Statistics
Shahjalal University of Science and Technology (SUST)
Sylhet-3114, Bangladesh

📧 saleksta@gmail.com

</td>
<td width="50%" valign="top">

Md Jamal Uddin, Ph.D.

Corresponding Author

Professor, Department of Statistics
Shahjalal University of Science and Technology (SUST)
Sylhet-3114, Bangladesh

Faculty of Graduate Education
Daffodil International University, Dhaka, Bangladesh

📧 jamal-sta@sust.edu
📞 +8801716972846

</td>
</tr>
</table>

<div align="center">

Biostatistics, Epidemiology, and Public Health Research Team
Department of Statistics · Shahjalal University of Science and Technology · Sylhet, Bangladesh

</div>

📖 Citation

If you use the code, workflow, derived outputs, or methodological structure from this repository, please cite the published article:

Miah, M. S., & Uddin, M. J. (2026). Association between internet use and unmet need for family planning among currently pregnant women in Bangladesh: evidence from BDHS 2022. BMC Women's Health. https://doi.org/10.1186/s12905-026-04788-2

<details>
<summary><b>BibTeX</b></summary>

@article{miah_uddin_2026_unmet_need,
  title   = {Association between internet use and unmet need for family planning among currently pregnant women in Bangladesh: evidence from BDHS 2022},
  author  = {Miah, Md Salek and Uddin, Md Jamal},
  journal = {BMC Women's Health},
  year    = {2026},
  doi     = {10.1186/s12905-026-04788-2},
  url     = {https://doi.org/10.1186/s12905-026-04788-2},
  note    = {Open Access}
}

</details>

🔎 Transparency Statement

The repository documents the analytical workflow associated with the published study.

Raw DHS participant-level microdata are not included because access is governed by the DHS Program.

Derived aggregate outputs may be shared where permitted.

Statistical estimates should be interpreted in the context of the study design and published methods.

Any use of language-editing tools does not substitute for author responsibility for the scientific analysis, interpretation, and reporting.

🎓 Learn the Methods — Salek Data Lab

Free, practical tutorials on DHS data management, survey-weighted regression, Stata, R, and reproducible public-health research workflows can be linked here.

Add your official YouTube / Salek Data Lab URL here once available.

🤝 Reuse & Academic Practice

Researchers and students are welcome to learn from and adapt the code structure and reproducible workflow, subject to the repository license and the terms governing the original data.

When adapting this work:

cite the published article;

preserve attribution for reused code;

comply with DHS data-use requirements;

document substantial methodological changes; and

avoid representing derivative analyses as results from the original publication.

📜 License & Reuse

Repository code: MIT License. See LICENSE for the full terms.

Published article and publisher-hosted content: reuse is governed by the license displayed on the published article. Please consult the journal article directly before reproducing text, tables, or figures.

DHS data: governed separately by the DHS Program's data-access and terms-of-use requirements.

<div align="center">

Research with transparency · Reproducibility · Public-health impact

Biostatistics, Epidemiology, and Public Health Research Team
Department of Statistics · Shahjalal University of Science and Technology (SUST)

<br>




<br>

⭐ If this repository supports your research or learning, consider starring it.

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:2B59C3,50:173B6C,100:0B1F3A&height=105&section=footer" width="100%" alt="Footer" />

</div>
