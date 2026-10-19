


*--------------------------------------------
* Preserve original dataset
*--------------------------------------------
preserve

*--------------------------------------------
* Make Unmet Need numeric indicator 
*    (1 = Yes unmet need, 0 = No unmet need)
*--------------------------------------------
gen unmet_num = .
replace unmet_num = 1 if unmet_need_preg == 1
replace unmet_num = 0 if unmet_need_preg == 0

*--------------------------------------------
* Collapse to get division-wise totals
*--------------------------------------------
collapse (sum) Unmet_need=unmet_num (count) Total_preg=unmet_num, by(division)

*--------------------------------------------
* Compute global percentage for each division
*--------------------------------------------
sum Total_preg
local grand_total = r(sum)

gen division_pct = round((Total_preg / `grand_total')*100,1)

* Global unmet need percentage
gen Unmet_global_pct = round((Unmet_need / `grand_total')*100,1)

*--------------------------------------------
* Export to Excel
*--------------------------------------------
export excel division Total_preg division_pct Unmet_need Unmet_global_pct ///
    using "F:\BDHS\Unmeet need\Data\division_global_unmet_need_percentages.xlsx", ///
    firstrow(variables) replace

*--------------------------------------------
* Restore original dataset
*--------------------------------------------
restore





