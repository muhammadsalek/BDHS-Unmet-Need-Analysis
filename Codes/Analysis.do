


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
tab unmet_need_preg age_cat, chi2 cell
tab unmet_need_preg age_first_birth, chi2 cell
tab unmet_need_preg maternal_edu, chi2 cell
tab unmet_need_preg age_cohab_cat, chi2 cell
tab unmet_need_preg parity, chi2 cell
tab unmet_need_preg hh_head_sex, chi2 cell // check significance
tab unmet_need_preg husb_edu, chi2 cell
tab unmet_need_preg maternal_empl, chi2 cell
tab unmet_need_preg husband_emplo, chi2 cell // check significance
tab unmet_need_preg hh_wealth_cat, chi2 cell
tab unmet_need_preg residence_type, chi2 cell
tab unmet_need_preg hh_religion, chi2 cell
tab unmet_need_preg hh_size, chi2 cell // check significance
tab unmet_need_preg hh_own_house, chi2 cell // check significance
tab unmet_need_preg emp_level, chi2 cell
tab unmet_need_preg contraception, chi2 cell
tab unmet_need_preg hh_media, chi2 cell
tab unmet_need_preg internet_use, chi2 cell
tab unmet_need_preg hh_assets, chi2 cell
tab unmet_need_preg hh_materials, chi2 cell

tab unmet_need_preg division, chi2 cell









**********************************************
*********************************************
* Unadjusted Model
**********************************************
**********************************************
logistic unmet_need_preg i.internet_use









*********************************************
*********************************************
* Forward Stepwise Model Building for Unmet Need for FP
* Main Exposure: Internet Use
* Only confounders with p < 0.20 in bivariate analysis are considered
*********************************************
*********************************************

* Crude Model: Only main exposure (Internet use)
logistic unmet_need_preg i.internet_use
estimates store m0


* Step 1: Add age categories (p < 0.001 in bivariate)
logistic unmet_need_preg i.internet_use i.age_cat
estimates store m1
lrtest m1 m0, stats
estimates stats m0 m1 // statistically and conceptually m1 model better

/*

Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m0 |      4,370  -2961.924   -2950.52       2    5905.04   5917.805
          m1 |      4,370  -2961.924  -2797.008       4   5602.016   5627.547

*/



* Step 2: Add age at first birth (p < 0.001)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth
estimates store m2
lrtest m2 m1, stats
estimates stats m1 m2 // m2 better model statistically and conceptually

/*


Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m1 |      4,370  -2961.924  -2797.008       4   5602.016   5627.547
          m2 |      4,370  -2961.924  -2609.099       6   5230.199   5268.494
-----------------------------------------------------------------------------

*/



* Step 3: Add maternal education (p < 0.001)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu
estimates store m3
lrtest m3 m2, stats
estimates stats m2 m3 // m3 better model

/*

Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m1 |      4,370  -2961.924  -2797.008       4   5602.016   5627.547
          m2 |      4,370  -2961.924  -2609.099       6   5230.199   5268.494
-----------------------------------------------------------------------------



*/




* Step 4: Add husband education (p = 0.0003)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu 
estimates store m4
lrtest m4 m3, stats
estimates stats m3 m4 // m4 better model statistically and conceptually cause though AIC and BIC increase but husband education is an important confounder .

/*

Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m3 |      4,370  -2961.924  -2602.871       8   5221.741   5272.802
          m4 |      4,370  -2961.924  -2602.545      10   5225.089   5288.914
-----------------------------------------------------------------------------

*/







* Step 5: Add parity (p < 0.001)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity
estimates store m5
lrtest m5 m4, stats
estimates stats m4 m5 // m5 better model statistically and conceptually


/*
Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m4 |      4,370  -2961.924  -2602.545      10   5225.089   5288.914
          m5 |      4,370  -2961.924  -2441.901      13   4909.801   4992.774

*/





* Step 6: Add residence type (p = 0.002)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type
estimates store m6
lrtest m6 m5, stats
estimates stats m5 m6 // m6 better model statistically and conceptually

/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m5 |      4,370  -2961.924  -2441.901      13   4909.801   4992.774
          m6 |      4,370  -2961.924   -2439.77      14   4907.541   4996.896
-----------------------------------------------------------------------------


*/





* Step 7: Add media exposure (p < 0.001)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media
estimates store m7
lrtest m7 m6, stats
estimates stats m6 m7 // m7 better model statistically and conceptually m7


/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m5 |      4,370  -2961.924  -2441.901      13   4909.801   4992.774
          m6 |      4,370  -2961.924   -2439.77      14   4907.541   4996.896
-----------------------------------------------------------------------------



*/




* Step 8: Add household assets (hh_assets) (p = 0.040)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets
estimates store m8
lrtest m8 m7, stats
estimates stats m7 m8 // m7 better model statistically and conceptually

/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m7 |      4,370  -2961.924  -2438.274      15   4906.549   5002.286
          m8 |      4,370  -2961.924  -2437.385      16    4906.77    5008.89
-----------------------------------------------------------------------------


*/







* Step 9: Add household materials (hh_materials) (p = 0.001)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_materials
estimates store m9
lrtest m9 m7, stats
estimates stats m7 m9 // m7 better model statistically and conceptually m7
/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m7 |      4,370  -2961.924  -2438.274      15   4906.549   5002.286
          m8 |      4,370  -2961.924  -2437.385      16    4906.77    5008.89
-----------------------------------------------------------------------------


*/






* Step 10: Add husband employment (p = 0.006)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets i.husband_emplo
estimates store m10
lrtest m10 m7, stats
estimates stats m7 m10 // m10 final model statistically and conceptually m10

/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m7 |      4,370  -2961.924  -2438.274      15   4906.549   5002.286
          m8 |      4,370  -2961.924  -2437.385      16    4906.77    5008.89
-----------------------------------------------------------------------------



*/



* Step 11: Add household division (p = 0.000)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets i.husband_emplo i. division
estimates store m11
lrtest m10 m11, stats
estimates stats m11 m10 // m11 better model statistically and conceptually 

/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
         m11 |      4,370  -2961.924  -2430.359      24   4908.719   5061.899
         m10 |      4,370  -2961.924  -2433.752      17   4901.503   5010.006
-----------------------------------------------------------------------------



*/


* Step 11: Add household division (p = 0.000)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets i.husband_emplo i. division i.emp_level
estimates store m12
lrtest m12 m11, stats
estimates stats m11 m12 // m12 better model statistically and conceptually 


/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
         m11 |      4,370  -2961.924  -2430.359      24   4908.719   5061.899
         m12 |      4,370  -2961.924  -2427.704      25   4905.408   5064.971
-----------------------------------------------------------------------------


*/

 
 
* Step 11: Add household religion (p = 0.000)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets i.husband_emplo i. division i.emp_level ///
						i. hh_religion
estimates store m13
lrtest m13 m12, stats
estimates stats m13 m12 // m13 better model statistically and conceptually 

/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
         m13 |      4,370  -2961.924  -2427.644      26   4907.288   5073.234
         m12 |      4,370  -2961.924  -2427.704      25   4905.408   5064.971
-----------------------------------------------------------------------------

*/




* Step 11: Add household religion (p = 0.000)
logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets i.husband_emplo i. division i.emp_level ///
						i. hh_religion i. contraception

estimates store m14
lrtest m13 m14, stats
estimates stats m13 m14 // m14 better model statistically and conceptually 


/*


-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
         m13 |      4,370  -2961.924  -2427.644      26   4907.288   5073.234
         m14 |      4,370  -2961.924  -2415.646      27   4885.293   5057.621
-----------------------------------------------------------------------------


*/





*********************************************************************
*********************************************************************
* Final Model
*********************************************************************
*********************************************************************

svy:logistic unmet_need_preg i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets i.husband_emplo i. division i.emp_level ///
						i. hh_religion i. contraception






* Optional: goodness-of-fit test
estat gof






*Check Multicollinearity (VIF)
regress internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets i.husband_emplo i. division i.emp_level ///
						i. hh_religion i. contraception




vif // (mean VIF= 2.42)

*Goodness-of-Fit Tests for Logistic Regression
 logistic internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
                        i.residence_type i.hh_media i.hh_assets i.husband_emplo i. division i.emp_level ///
						i. hh_religion i. contraception

	

*Hosmer-Lemeshow Test
lfit, group(10)






/*

 . 
. *Hosmer-Lemeshow Test
. lfit, group(10)
note: obs collapsed on 10 quantiles of estimated probabilities.

Goodness-of-fit test after logistic model
Variable: internet_use

 Number of observations =  4,370
       Number of groups =     10
Hosmer–Lemeshow chi2(8) =  16.94
            Prob > chi2 = 0.0308



	*/







*********************************************
* Survey-Weighted Logistic Regression
* Predicting Unmet Need for Family Planning
* Generate ROC Curve
*********************************************

* 1. Fit the survey-weighted logistic regression model
svy: logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* 2. Predict predicted probabilities
predict phat, pr

* 3. ROC Curve
roctab unmet_need_preg phat

* Generate sensitivity and specificity points
roctab unmet_need_preg phat, graph
/*
Predicted probabilities from the survey-weighted logistic regression model were used to generate a receiver operating characteristic (ROC) curve. The area under the curve (AUC) was 0.778 (95% CI 0.764–0.792), indicating acceptable discrimination

*/



*********************************************************************
*********************************************************************
* Survey-Weighted Logistic Regression: Stratified by Residence
* Outcome: Unmet Need for Family Planning
* Main Exposure: Internet Use
*********************************************************************
*********************************************************************
* --- Urban sample ---
svy, subpop(if residence_type==1): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* Predict probabilities (optional)
*predict phat_urban if residence_type==1, pr

* ROC for Urban
*roctab unmet_need_preg phat_urban if residence_type==1

* --- Rural sample ---
svy, subpop(if residence_type==2): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* Predict probabilities (optional)
*predict phat_rural if residence_type==2, pr

* ROC for Rural
*roctab unmet_need_preg phat_rural if residence_type==2










*********************************************************************
* Survey-Weighted Logistic Regression: Stratified by Division
* Outcome: Unmet Need for Family Planning
* Main Exposure: Internet Use
*********************************************************************

* 1. Barishal
svy, subpop(if division==1): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.emp_level ///
    i.hh_religion i.contraception

* 2. Chattogram
svy, subpop(if division==2): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.emp_level ///
    i.hh_religion i.contraception

* 3. Dhaka
svy, subpop(if division==3): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.emp_level ///
    i.hh_religion i.contraception

* 4. Khulna
svy, subpop(if division==4): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.emp_level ///
    i.hh_religion i.contraception

* 5. Mymensingh
svy, subpop(if division==5): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.emp_level ///
    i.hh_religion i.contraception

* 6. Rajshahi
svy, subpop(if division==6): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.emp_level ///
    i.hh_religion i.contraception

* 7. Rangpur
svy, subpop(if division==7): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.emp_level ///
    i.hh_religion i.contraception

* 8. Sylhet
svy, subpop(if division==8): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.emp_level ///
    i.hh_religion i.contraception









*********************************************************************
* Survey-Weighted Logistic Regression: Stratified by Maternal Age
* Outcome: Unmet Need for Family Planning
* Main Exposure: Internet Use
*********************************************************************

* 1. Age 15-24 (Young)
svy, subpop(if age_cat==1): logistic unmet_need_preg ///
    i.internet_use i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* 2. Age 25-34 (Mid)
svy, subpop(if age_cat==2): logistic unmet_need_preg ///
    i.internet_use i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* 3. Age 35-49 (Older)
svy, subpop(if age_cat==3): logistic unmet_need_preg ///
    i.internet_use i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception



*********************************************************************
* Survey-Weighted Logistic Regression: Stratified by Age at First Birth
* Outcome: Unmet Need for Family Planning
* Main Exposure: Internet Use
*********************************************************************

* 1. Early (10-17)
svy, subpop(if age_first_birth_cat==1): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* 2. Normal (18-24)
svy, subpop(if age_first_birth_cat==2): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* 3. Late (≥25)
svy, subpop(if age_first_birth_cat==3): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception



*********************************************************************
* Survey-Weighted Logistic Regression: Stratified by Maternal Education
* Outcome: Unmet Need for Family Planning
* Main Exposure: Internet Use
*********************************************************************

* 1. No Education
svy, subpop(if maternal_edu==0): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* 2. Primary Education
svy, subpop(if maternal_edu==1): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* 3. Secondary and Higher
svy, subpop(if maternal_edu==2): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.husb_edu i.parity ///
    i.residence_type i.hh_media i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception





*********************************************************************
* Survey-Weighted Logistic Regression: Stratified by Household Media Exposure
* Outcome: Unmet Need for Family Planning
* Main Exposure: Internet Use
*********************************************************************

* 1. No Media
svy, subpop(if hh_media==0): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception

* 2. Has Media
svy, subpop(if hh_media==1): logistic unmet_need_preg ///
    i.internet_use i.age_cat i.age_first_birth i.maternal_edu i.husb_edu i.parity ///
    i.residence_type i.hh_assets i.husband_emplo i.division i.emp_level ///
    i.hh_religion i.contraception
	
	
	
	
	
	
	
	
	
	
	
	
	
****************************************************
****************************************************
* Spatials\division_unmet_need_share
*****************************************************
*****************************************************    
* --------------------------------------------------------
* Preserve original dataset
* --------------------------------------------------------
preserve

* --------------------------------------------------------
* Generate total unmet need per division
* --------------------------------------------------------
* Count unmet need (1 = yes)
gen unmet = unmet_need_preg

* Summarize total unmet need per division
collapse (sum) unmet, by(division)

* Calculate total unmet need overall
egen total_unmet = total(unmet)

* Calculate division share of total unmet need (%)
gen unmet_share_pct = (unmet/total_unmet)*100

* Round to 2 decimal places
replace unmet_share_pct = round(unmet_share_pct, 0.01)

* --------------------------------------------------------
* Export results as CSV
* --------------------------------------------------------
export delimited using "F:\BDHS\Unmeet need\Descriptive studys\Spatials\division_unmet_need_share.csv", replace

* --------------------------------------------------------
* List results
* --------------------------------------------------------
list division unmet unmet_share_pct, clean

* --------------------------------------------------------
* Restore original dataset
* -------------------------------------------------------
restore
	
	
	
	
	
	
	
	
