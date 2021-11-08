use "inv_non_cog_analysis.dta", clear
graph set window fontface "Calibri"

* Phenotypic correlations:
capture {
	forv i=1/22 { 
	foreach var of varlist invsdq_mean- nonresponse24 { 
		rename `var' var`i++' 
	} 
}
}
la var var1 "SDQ (mean)"
la var var2 "Teacher SDQ (mean)"
la var var3 "Social skills (13)"
la var var4 "Communication (mean)"
la var var5 "Self-esteem (mean)"
la var var6 "Persistence (mean)"
la var var7 "Locus of Control (mean)"
la var var8 "Empathy (7)"
la var var9 "Impulsivity (mean)"
la var var10 "B5 Extraversion"
la var var11 "B5 Agreeableness"
la var var12 "B5 Conscientiousness"
la var var13 "B5 Emotional stability"
la var var14 "B5 Intellect/imagination"
la var var15 "IQ (mean)"
la var var16 "KS2 average"
la var var17 "KS3 average"
la var var18 "KS4 average"
la var var19 "KS5 grades"
la var var20 "Employed"
la var var21 "EET"
la var var22 "Income"
la var var23 "Non-response age 18"
la var var24 "Non-response age 24"


#delimit ;
forvalues j = 1/24 { ;
forvalues j2 = 1/24 { ;
	if `j2'>`j' { ;
	corr var`j' var`j2' ;
	gen r2var`j'var`j2'_se=sqrt((1-r(rho))/(r(N)-2)) ;
	noisily display r(rho) ;
	noisily display sqrt((1-r(rho))/(r(N)-2)) ;
	egen r2var`j'var`j2'=corr(var`j' var`j2') ;
	gen r2var`j'var`j2'num=r(N) ;
	} ;
	else ;
} ;
} ;
#delimit cr

keep in 1/100
collapse (mean) r2var1var2_se- r2var23var24num
save "correlogram\noncog_r2_means.dta", replace


use "correlogram\noncog_r2_means.dta", clear
drop *se *num
forvalues j = 1/9 { 
	keep r2var`j'var*
		foreach var of varlist r2* {
		local newname = substr("`var'", 7, .)
		rename `var' `newname'
}
	save "correlogram\temp_files\temp`j'.dta", replace
	use "correlogram\noncog_r2_means.dta", clear
	drop *se *num
} 

use "correlogram\noncog_r2_means.dta", clear
drop *se *num
forvalues j = 10/23 { 
	keep r2var`j'var*
		foreach var of varlist r2* {
		local newname = substr("`var'", 8, .)
		rename `var' `newname'
}
	save "correlogram\temp_files\temp`j'.dta", replace
	use "correlogram\noncog_r2_means.dta", clear
	drop *se *num
}

clear
forvalues j=1/23 {
	append using "correlogram\temp_files\temp`j'.dta"
}

sxpose, clear force
destring *, replace
gen temp=_n
set obs 24
replace temp=0 if temp==.
sort temp
drop temp
gen _var24=.
gen trait=_n
order trait, first
save "correlogram\rp_means.dta", replace
mkmat _var1-_var24, matrix(rp)
forvalues j = 1/23 {
	erase "correlogram\temp_files\temp`j'.dta"
}


* Univariate heritability: 
use "unvariate_output\univariate_means_heritability.dta", clear
sxpose, clear firstnames force
destring *, replace
keep in 3
expand 24
forvalues j = 1/24 {
	replace _var`j'=. if _n!=`j'
}
gen trait=_n
order trait, first
save "correlogram\h2_means.dta", replace
mkmat _var1-_var24, matrix(h2_means)


* Genetic correlations:
use "bivariate_output\bivariate_rg_adjusted_means.dta", clear
save "correlogram\rg_means.dta", replace
mkmat _var1-_var24, matrix(rg_means)


* Univariate heritability SE's: 
use "unvariate_output\univariate_means_heritability.dta", clear
sxpose, clear firstnames force
destring *, replace
keep in 4
list
expand 24
forvalues j = 1/24 {
	replace _var`j'=. if _n!=`j'
}
gen trait=_n
order trait, first
save "correlogram\h2_se_means.dta", replace
drop trait
mkmat _var1-_var24, matrix(h2_se_means)


* Genetic correlations SE's:
use "bivariate_output\bivariate_rg_se_adjusted_means.dta", clear
mkmat _var1-_var24, matrix(rg_se_means)
save "correlogram\rg_se_means.dta", replace


* Phenotypic correlations SE's: 
use "correlogram\noncog_r2_means.dta", clear
keep *se
forvalues j = 1/9 { 
	keep r2var`j'var*
		foreach var of varlist r2* {
		local newname = substr("`var'", 7, .)
		rename `var' `newname'
}
	save "correlogram\temp_files\temp`j'.dta", replace
	use "correlogram\noncog_r2_means.dta", clear
	keep *se
} 

use "correlogram\noncog_r2_means.dta", clear
keep *se
forvalues j = 10/23 { 
	keep r2var`j'var*
		foreach var of varlist r2* {
		local newname = substr("`var'", 8, .)
		rename `var' `newname'
}
	save "correlogram\temp_files\temp`j'.dta", replace
	use "correlogram\noncog_r2_means.dta", clear
	keep *se
} 

clear
forvalues j=1/23 {
	append using "correlogram\temp_files\temp`j'.dta"
}

sxpose, clear force
destring *, replace
gen temp=_n
set obs 24
replace temp=0 if temp==.
sort temp
drop temp
gen _var24=.
gen trait=_n
order trait, first
save "correlogram\rp_se_means.dta", replace
mkmat _var1-_var24, matrix(rp_se_means)
forvalues j = 1/23 {
	erase "correlogram\temp_files\temp`j'.dta"
}

* Merging estimates into one file/matrix:
use "correlogram\h2_means.dta", clear
merge 1:1 trait using "correlogram\rg_means.dta", nogen update
merge 1:1 trait using "correlogram\rp_means.dta", nogen update
save "correlogram\full_means.dta", replace
drop trait
mkmat _var1-_var24, matrix(full_means)


* Merging SE's into one file/matrix:
use "correlogram\h2_se_means.dta", clear
merge 1:1 trait using "correlogram\rg_se_means.dta", nogen update
merge 1:1 trait using "correlogram\rp_se_means.dta", nogen update
forvalues j = 1/24 {
	rename _var`j' _var`j'se
}
save "correlogram\full_se_means.dta", replace
drop trait
mkmat _var1se-_var24se, matrix(full_se_means)


* Calculating FDR:
use "correlogram\full_means.dta", clear
merge 1:1 trait using "correlogram\full_se_means.dta", nogen
outsheet using "correlogram\full_matrices_means.xls", replace
forvalues j = 1/24 {
	gen z_var_`j'=_var`j'/_var`j'se
	gen p_var`j'=exp((-0.717*z_var_`j')-(0.416*z_var_`j'^2))
	drop z_var_`j'
}
drop *se
reshape long _var p_var, i(trait) j(temp)
sort p
gen p_rank=_n
gen q=(p_rank/576)*0.05
gen qsig=1 if p_var<q
replace qsig=1 if qsig[_n+1]==1
preserve
keep trait temp p_var q
reshape wide p_var q, i(trait) j(temp)
outsheet using "correlogram\full_means_p_q.xls", replace
restore
keep trait _var qsig temp
reshape wide _var qsig, i(trait) j(temp)
order trait _var*
keep trait qsig*
save "correlogram\full_q_means.dta", replace
mkmat qsig1-qsig24, matrix(full_q_means)

graph set window fontface "Calibri"
capture do "plotmatrix.ado"

* Creating correlograms:
plotmatrix2, mat(full_means) matse(full_q_means) split(-1(0.05)1) formatcells(%3.2f) maxticks(9) allcolors( ///
red*1 red*0.95 red*0.9 red*0.85 red*0.8 red*0.75 red*0.7 red*0.65 red*0.6 red*0.55 red*0.5 red*0.45 red*0.4 red*0.35 red*0.3 red*0.25 red*0.2 red*0.15 red*0.1 red*0.05 ///
white*0 ///
blue*0.05 blue*0.1 blue*0.15 blue*0.2 blue*0.25 blue*0.3 blue*0.35 blue*0.4 blue*0.45 blue*0.5 blue*0.55 blue*0.6 blue*0.65 blue*0.7 blue*0.75 blue*0.8 blue*0.85 blue*0.9 blue*0.95 blue*1 ///
) ///
graphregion(color(white) lwidth(small)) ///
aspect(1) legend(cols(1) position(3) order(40 "+1" 40 "" 39 "" 38 "" 37 "" 36 "" 35 "" 34 "" 33 "" 32 "" 31 "" 30 "" 29 "" 28 "" 27 "" 26 "" ///
25 "" 24 "" 23 "" 22 "" 21 "" 20 "" 19 "" 18 "" 17 "" 16 "" 15 "" 14 "" 13 "" 12 "" 11 "" 10 "" 9 "" 8 "" 7 "" 6 "" 5 "" 4 "" 3 "" 2 "" 1 "-1") rowgap(0) symxsize(2) size(small) region(lcolor(white)) bmargin(none)) ///
ylabel(0 "SDQ (aggregate)" -1 "SDQT (aggregate)" -2 "Social skills (13)" -3 "Communication (aggregate)" -4 "Self-esteem (aggregate)" -5 "Persistence (aggregate)" -6 "Locus of Control (aggregate)" ///
-7 "Empathy (7)" -8 "Impulsivity (aggregate)" -9 "Extraversion (13)" -10 "Agreeableness (13)" -11 "Conscientiousness (13)" -12 "Emotional stability (13)" -13 "Intellect/imagination (13)" ///
-14 "IQ (aggregate)" -15 "Achievement (11)" -16 "Achievement (14)" -17 "Achievement (16)" -18 "Achievement (18)" -19 "Employed (23)" -20 "EET (23)" -21 "Income (23)" ///
-22 "Non-response (18)" -23 "Non-response (24)", angle(0) labsize(vsmall)) ///
xlabel (1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills (13)" 4 "Communication (aggregate)" 5 "Self-esteem (aggregate)" 6 "Persistence (aggregate)" 7 "Locus of Control (aggregate)" ///
8 "Empathy (7)" 9 "Impulsivity (aggregate)" 10 "Extraversion (13)" 11 "Agreeableness (13)" 12 "Conscientiousness (13)" 13 "Emotional stability (13)" 14 "Intellect/imagination (13)" ///
15 "IQ (aggregate)" 16 "Achievement (11)" 17 "Achievement (14)" 18 "Achievement (16)" 19 "Achievement (18)" 20 "Employed (23)" 21 "EET (23)" 22 "Income (23)" ///
23 "Non-response (18)" 24 "Non-response (24)", angle(45) labsize(vsmall)) ///
addbox(1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9 9 9 10 10 10 10 11 11 11 11 12 12 12 12 13 13 13 13 14 14 14 14 15 15 15 15 16 16 19 19 23 23 24 24)
graph export "figures\correlogram_means_full.tif", replace width (3000)
graph save "correlogram\correlogram_means_full.gph", replace


use "correlogram\full_means.dta", clear
replace _var13=. if trait==10
mkmat _var1-_var14, matrix(full_means_temp)
matselrc full_means_temp full_means_trimmed, r(1/14) c(1/14)
use "correlogram\full_q_means.dta", clear
replace qsig13=2 if trait==10
mkmat qsig1-qsig14, matrix(full_q_means_temp)
matselrc full_q_means_temp full_q_means_trimmed, r(1/14) c(1/14)

plotmatrix2, mat(full_means_trimmed) matse(full_q_means_trimmed) split(-1(0.05)1) formatcells(%3.2f) maxticks(9) allcolors( ///
red*1 red*0.95 red*0.9 red*0.85 red*0.8 red*0.75 red*0.7 red*0.65 red*0.6 red*0.55 red*0.5 red*0.45 red*0.4 red*0.35 red*0.3 red*0.25 red*0.2 red*0.15 red*0.1 red*0.05 ///
white*0 ///
blue*0.05 blue*0.1 blue*0.15 blue*0.2 blue*0.25 blue*0.3 blue*0.35 blue*0.4 blue*0.45 blue*0.5 blue*0.55 blue*0.6 blue*0.65 blue*0.7 blue*0.75 blue*0.8 blue*0.85 blue*0.9 blue*0.95 blue*1 ///
) ///
graphregion(color(white) lwidth(small)) ///
aspect(1) legend(cols(1) position(3) order(30 "+1" 29 "" 28 "" 27 "" 26 "" ///
25 "" 24 "" 23 "" 22 "" 21 "" 20 "" 19 "" 18 "" 17 "" 16 "" 15 "" 14 "" 13 "" 12 "" 11 "" 10 "" 9 "" 8 "" 7 "" 6 "" 5 "" 4 "" 3 "" 2 "" 1 "-1") rowgap(0) symxsize(2) size(small) region(lcolor(white)) bmargin(none)) ///
ylabel(0 "SDQ (aggregate)" -1 "SDQT (aggregate)" -2 "Social skills (13)" -3 "Communication (aggregate)" -4 "Self-esteem (aggregate)" -5 "Persistence (aggregate)" -6 "Locus of Control (aggregate)" ///
-7 "Empathy (7)" -8 "Impulsivity (aggregate)" -9 "Extraversion (13)" -10 "Agreeableness (13)" -11 "Conscientiousness (13)" -12 "Emotional stability (13)" -13 "Intellect/imagination (13)" ///
, angle(0) labsize(vsmall)) ///
xlabel (1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills (13)" 4 "Communication (aggregate)" 5 "Self-esteem (aggregate)" 6 "Persistence (aggregate)" 7 "Locus of Control (aggregate)" ///
8 "Empathy (7)" 9 "Impulsivity (aggregate)" 10 "Extraversion (13)" 11 "Agreeableness (13)" 12 "Conscientiousness (13)" 13 "Emotional stability (13)" 14 "Intellect/imagination (13)" ///
, angle(45) labsize(vsmall)) ///
addbox(1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9 9 9 10 10 10 10 11 11 11 11 12 12 12 12 13 13 13 13 14 14 14 14)
graph export "figures\correlogram_means_noncog_only.tif", replace width (3000)
graph save "correlogram\correlogram_means_noncog_only.gph", replace