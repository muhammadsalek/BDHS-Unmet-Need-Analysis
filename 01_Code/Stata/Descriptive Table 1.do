


use "E:\f drives\BDHS\Unmet\Revision\Data\descriptive_data.dta", clear





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
tab age_cat unmet_need_preg, chi2 row
tab age_cohab_cat unmet_need_preg, chi2 row
tab parity unmet_need_preg, chi2 row
tab division unmet_need_preg, chi2 row
tab residence_type unmet_need_preg, chi2 row
tab hh_religion unmet_need_preg, chi2 row

*******************************
* 2. Maternal Characteristics
*******************************
tab maternal_edu unmet_need_preg, chi2 row
tab maternal_empl unmet_need_preg, chi2 row
tab age_first_birth unmet_need_preg, chi2 row
tab contraception unmet_need_preg, chi2 row
tab emp_level unmet_need_preg, chi2 row

*******************************
* 3. Husband Characteristics
*******************************
tab husb_edu unmet_need_preg, chi2 row
tab husband_emplo unmet_need_preg, chi2 row
tab hh_head_sex unmet_need_preg, chi2 row

*******************************
* 4. Household & Socioeconomic Factors
*******************************
tab hh_wealth_cat unmet_need_preg, chi2 row
tab hh_size unmet_need_preg, chi2 row
tab hh_own_house unmet_need_preg, chi2 row
tab hh_assets unmet_need_preg, chi2 row
tab hh_materials unmet_need_preg, chi2 row

*******************************
* 5. Media & Information Access
*******************************
tab hh_media unmet_need_preg, chi2 row
tab internet_use unmet_need_preg, chi2 row
































