




use "F:\BDHS\Unmeet need\Data\descriptive_data.dta",clear






*********************************************
* Simple Imputation for Missing Data
* Replace missing with most frequent category
*********************************************

* 1. Check current distribution
tab husb_edu, missing
tab husband_emplo, missing

* 2. Impute missing values with mode

* husb_edu (3 categories: 1,2,3)
quietly summarize husb_edu, meanonly
* Mode replacement
tab husb_edu, matcell(freq)
matrix list freq
* Suppose most frequent category is 3
replace husb_edu = 3 if missing(husb_edu)

* husband_emplo (0/1)
tab husband_emplo, matcell(freq)
matrix list freq
* Suppose most frequent category is 1
replace husband_emplo = 1 if missing(husband_emplo)

* 3. Check again
misstable summarize husb_edu husband_emplo




tab husb_edu 
tab husband_emplo





********************************************************************************
* Table 1
* Bivariate Analysis
* Cross-tabulations with Unmet Need for Family Planning and Chi-square Test
********************************************************************************

*******************************
* 1. Demographic Characteristics
*******************************
tab unmet_need_preg age_cat, chi2 cell
tab unmet_need_preg age_cohab_cat, chi2 cell
tab unmet_need_preg parity, chi2 cell
tab unmet_need_preg division, chi2 cell
tab unmet_need_preg residence_type, chi2 cell
tab unmet_need_preg hh_religion, chi2 cell

*******************************
* 2. Maternal Characteristics
*******************************
tab unmet_need_preg maternal_edu, chi2 cell
tab unmet_need_preg maternal_empl, chi2 cell
tab unmet_need_preg age_first_birth, chi2 cell
tab unmet_need_preg contraception, chi2 cell
tab unmet_need_preg emp_level, chi2 cell

*******************************
* 3. Husband Characteristics
*******************************
tab unmet_need_preg husb_edu, chi2 cell
tab unmet_need_preg husband_emplo, chi2 cell
tab unmet_need_preg hh_head_sex, chi2 cell

*******************************
* 4. Household & Socioeconomic Factors
*******************************
tab unmet_need_preg hh_wealth_cat, chi2 cell
tab unmet_need_preg hh_size, chi2 cell
tab unmet_need_preg hh_own_house, chi2 cell
tab unmet_need_preg hh_assets, chi2 cell
tab unmet_need_preg hh_materials, chi2 cell

*******************************
* 5. Media & Information Access
*******************************
tab unmet_need_preg hh_media, chi2 cell
tab unmet_need_preg internet_use, chi2 cell




