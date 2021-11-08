use "inv_non_cog_analysis.dta", clear
graph set window fontface "Calibri"

* Phenotypic correlations:
capture {
forv i=1/41 { 
foreach var of varlist invsdq4- nonresponse24 { 
	rename `var' var`i++' 
} 
} 
}

qui {
la var var1 "SDQ score age 4 (reversed)"
la var var2 "SDQ score age 7 (reversed)"
la var var3 "SDQ score age 8 (reversed)"
la var var4 "SDQ score age 10 (reversed)"
la var var5 "SDQ score age 12 (reversed)"
la var var6 "SDQ score age 13 (reversed)"
la var var7 "SDQ score age 16 (reversed)"
la var var8 "SDQ (teacher) score age 7 (reversed)"
la var var9 "SDQ (teacher) score age 10 (reversed)"
la var var10 "Social skills age 13"
la var var11 "Communication age 5 months"
la var var12 "Communication age 1"
la var var13 "Communication age 18 months"
la var var14 "Communication age 3"
la var var15 "Communication age 10"
la var var16 "Self-esteem age 8"
la var var17 "Self-esteem age 18"
la var var18 "Persistence 6 months"
la var var19 "Persistence age 2"
la var var20 "Persistance age 7"
la var var21 "Locus of control age 8"
la var var22 "Locus of control age 16"
la var var23 "Empathy age 7"
la var var24 "Impulsivity age 8"
la var var25 "Impulsivity age 11"
la var var26 "B5 Extraversion"
la var var27 "B5 Agreeableness"
la var var28 "B5 Conscientiousness"
la var var29 "B5 Emotional stability"
la var var30 "B5 Intellect/imagination"
la var var31 "IQ @ 8"
la var var32 "IQ @ 15"
la var var33 "KS2 average"
la var var34 "KS3 average"
la var var35 "KS4 average"
la var var36 "KS5 grades"
la var var37 "Employed"
la var var38 "EET"
la var var39 "Income"
la var var40 "Non-response age 18"
la var var41 "Non-response age 24"
}

#delimit ;
forvalues j = 1/41 { ;
forvalues j2 = 1/41 { ;
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
collapse (mean) r2var1var2_se- r2var40var41num
save "correlogram\noncog_r2.dta", replace


use "correlogram\noncog_r2.dta", clear
drop *se *num
forvalues j = 1/9 { 
	keep r2var`j'var*
		foreach var of varlist r2* {
		local newname = substr("`var'", 7, .)
		rename `var' `newname'
}
	save "correlogram\temp_files\temp`j'.dta", replace
	use "correlogram\noncog_r2.dta", clear
	drop *se *num
} 

use "correlogram\noncog_r2.dta", clear
drop *se *num
forvalues j = 10/40 { 
	keep r2var`j'var*
		foreach var of varlist r2* {
		local newname = substr("`var'", 8, .)
		rename `var' `newname'
}
	save "correlogram\temp_files\temp`j'.dta", replace
	use "correlogram\noncog_r2.dta", clear
	drop *se *num
} 

clear
forvalues j=1/40 {
	append using "correlogram\temp_files\temp`j'.dta"
}

sxpose, clear force
destring *, replace
gen temp=_n
set obs 41
replace temp=0 if temp==.
sort temp
drop temp
gen _var41=.
gen trait=_n
order trait, first
save "correlogram\rp.dta", replace
mkmat _var1-_var41, matrix(rp)
forvalues j = 1/40 {
	erase "correlogram\temp_files\temp`j'.dta"
}

* Univariate heritability: 
use "unvariate_output\univariate_heritability.dta", clear
sxpose, clear firstnames force
destring *, replace
keep in 3
list
expand 41
forvalues j = 1/41 {
	replace _var`j'=. if _n!=`j'
}
gen trait=_n
order trait, first
save "correlogram\h2.dta", replace
mkmat _var1-_var41, matrix(h2)


* Genetic correlations:
use "bivariate_output\bivariate_rg_adjusted.dta", clear
drop in 10/13
drop _var10-_var13
capture {
forv k=10/41 { 
foreach var of varlist _var14-_var45 { 
	rename `var' _var`k++' 
} 
}
}
drop trait
gen trait=_n
order trait, first
save "correlogram\rg.dta", replace
mkmat _var1-_var41, matrix(rg)


* Univariate heritability SE's: 
use "unvariate_output\univariate_heritability.dta", clear
sxpose, clear firstnames force
destring *, replace
keep in 4
list
expand 41
forvalues j = 1/41 {
	replace _var`j'=. if _n!=`j'
}
gen trait=_n
order trait, first
save "correlogram\h2_se.dta", replace
drop trait
mkmat _var1-_var41, matrix(h2_se)


* Genetic correlations SE's:
use "bivariate_output\bivariate_rg_se_adjusted.dta", clear
drop in 10/13
drop _var10-_var13
capture {
forv k=10/41 { 
foreach var of varlist _var14-_var45 { 
	rename `var' _var`k++' 
} 
}
}
drop trait
gen trait=_n
order trait, first
mkmat _var1-_var41, matrix(rg_se)
save "correlogram\rg_se.dta", replace


* Phenotypic correlations SE's: 
use "correlogram\noncog_r2.dta", clear
keep *se
forvalues j = 1/9 { 
	keep r2var`j'var*
		foreach var of varlist r2* {
		local newname = substr("`var'", 7, .)
		rename `var' `newname'
}
	save "correlogram\temp_files\temp`j'.dta", replace
	use "correlogram\noncog_r2.dta", clear
	keep *se
} 

use "correlogram\noncog_r2.dta", clear
keep *se
forvalues j = 10/40 { 
	keep r2var`j'var*
		foreach var of varlist r2* {
		local newname = substr("`var'", 8, .)
		rename `var' `newname'
}
	save "correlogram\temp_files\temp`j'.dta", replace
	use "correlogram\noncog_r2.dta", clear
	keep *se
} 

clear
forvalues j=1/40 {
	append using "correlogram\temp_files\temp`j'.dta"
}

sxpose, clear force
destring *, replace
gen temp=_n
set obs 41
replace temp=0 if temp==.
sort temp
drop temp
gen _var41=.
gen trait=_n
order trait, first
save "correlogram\rp_se.dta", replace
mkmat _var1-_var41, matrix(rp_se)
forvalues j = 1/40 {
	erase "correlogram\temp_files\temp`j'.dta"
}

* Merging estimates into one file/matrix:
use "correlogram\h2.dta", clear
merge 1:1 trait using "correlogram\rg.dta", nogen update
merge 1:1 trait using "correlogram\rp.dta", nogen update
save "correlogram\full.dta", replace
drop trait
mkmat _var1-_var41, matrix(full)


* Merging SE's into one file/matrix:
use "correlogram\h2_se.dta", clear
merge 1:1 trait using "correlogram\rg_se.dta", nogen update
merge 1:1 trait using "correlogram\rp_se.dta", nogen update
forvalues j = 1/41 {
	rename _var`j' _var`j'se
}
save "correlogram\full_se.dta", replace
drop trait
mkmat _var1se-_var41se, matrix(full_se)


* Calculating FDR:
use "correlogram\full.dta", clear
merge 1:1 trait using "correlogram\full_se.dta", nogen
outsheet using "correlogram\full_matrices.xls", replace
forvalues j = 1/41 {
	gen z_var_`j'=_var`j'/_var`j'se
	gen p_var`j'=exp((-0.717*z_var_`j')-(0.416*z_var_`j'^2))
	drop z_var_`j'
}
drop *se
reshape long _var p_var, i(trait) j(temp)
sort p
gen p_rank=_n
gen q=(p_rank/1681)*0.05
gen qsig=1 if p_var<q
replace qsig=1 if qsig[_n+1]==1
preserve
keep trait temp p_var q
reshape wide p_var q, i(trait) j(temp)
outsheet using "correlogram\full_p_q.xls", replace
restore
keep trait _var qsig temp
reshape wide _var qsig, i(trait) j(temp)
order trait _var*
keep trait qsig*
save "correlogram\full_q.dta", replace
mkmat qsig1-qsig41, matrix(full_q)

capture do "plotmatrix.ado"
graph set window fontface "Calibri"


* Creating correlograms:
plotmatrix2, mat(full) matse(full_q) split(-1(0.05)1) formatcells(%3.2f) maxticks(9) allcolors( ///
red*1 red*0.95 red*0.9 red*0.85 red*0.8 red*0.75 red*0.7 red*0.65 red*0.6 red*0.55 red*0.5 red*0.45 red*0.4 red*0.35 red*0.3 red*0.25 red*0.2 red*0.15 red*0.1 red*0.05 ///
white*0 ///
blue*0.05 blue*0.1 blue*0.15 blue*0.2 blue*0.25 blue*0.3 blue*0.35 blue*0.4 blue*0.45 blue*0.5 blue*0.55 blue*0.6 blue*0.65 blue*0.7 blue*0.75 blue*0.8 blue*0.85 blue*0.9 blue*0.95 blue*1 ///
) ///
graphregion(color(white) lwidth(small)) ///
aspect(1) legend(cols(1) position(3) order(41 "+1" 40 "" 39 "" 38 "" 37 "" 36 "" 35 "" 34 "" 33 "" 32 "" 31 "" 30 "" 29 "" 28 "" 27 "" 26 "" ///
25 "" 24 "" 23 "" 22 "" 21 "" 20 "" 19 "" 18 "" 17 "" 16 "" 15 "" 14 "" 13 "" 12 "" 11 "" 10 "" 9 "" 8 "" 7 "" 6 "" 5 "" 4 "" 3 "" 2 "" 1 "-1") rowgap(0) symxsize(2) size(small) region(lcolor(white)) bmargin(none)) ///
ylabel(0 "SDQ   (4)" -1 "SDQ   (7)" -2 "SDQ   (8)" -3 "SDQ (10)" -4 "SDQ (12)" -5 "SDQ (13)" -6 "SDQ (16)" ///
-7 "SDQT   (7)" -8 "SDQT (10)" -9 "Social skills (13)" -10 "Communication (0.5)" -11 "Communication   (1)" -12 "Communication (1.5)" -13 "Communication   (3)" ///
-14 "Communication (10)" -15 "Self-esteem   (8)" -16 "Self-esteem (18)" -17 "Persistence (0.5)" -18 "Persistence   (2)" -19 "Persistence   (7)" ///
-20 "Locus of control   (8)" -21 "Locus of control (16)" -22 "Empathy   (7)" -23 "Impulsivity   (8)" -24 "Impulsivity (11)" ///
-25 "Extraversion (13)" -26 "Agreeableness (13)" -27 "Conscientiousness (13)" -28 "Emotional stability (13)" ///
-29 "Intellect/imagination (13)" -30 "IQ   (8)" -31 "IQ (15)" -32 "Attainment (11)" ///
-33 "Attainment (14)" -34 "Attainment (16)" -35 "Attainment (18)" -36 "Employed (23)" -37 "EET (23)" -38 "Income (23)" ///
-39 "Non-response (18)" -40 "Non-response (24)", angle(0) labsize(tiny)) ///
xlabel (1 "SDQ   (4)" 2 "SDQ (7)" 3 "SDQ   (8)" 4 "SDQ (10)" 5 "SDQ (12)" 6 "SDQ (13)" 7 "SDQ (16)" ///
8 "SDQT   (7)" 9 "SDQT (10)" 10 "Social skills (13)" 11 "Communication (0.5)" 12 "Communication   (1)" 13 "Communication (1.5)" 14 "Communication   (3)" ///
15 "Communication (10)" 16 "Self-esteem   (8)" 17 "Self-esteem (18)" 18 "Persistence (0.5)" 19 "Persistence   (2)" 20 "Persistence   (7)" ///
21 "Locus of control   (8)" 22 "Locus of control (16)" 23 "Empathy   (7)" 24 "Impulsivity   (8)" 25 "Impulsivity (11)"  ///
26 "Extraversion (13)" 27 "Agreeableness (13)" 28 "Conscientiousness (13)" 29 "Emotional stability (13)" ///
30 "Intellect/imagination (13)" 31 "IQ   (8)" 32 "IQ (15)" 33 "Attainment (11)" ///
34 "Attainment (14)" 35 "Attainment (16)" 36 "Attainment (18)" 37 "Employed (23)" 38 "EET (23)" 39 "Income (23)" ///
40 "Non-response (18)" 41 "Non-response (24)", angle(45) labsize(tiny)) ///
addbox(1 1 9 9 11 11 15 15 16 16 17 17 18 18 20 20 21 21 22 22 24 24 25 25 31 31 32 32 33 33 36 36 37 37 39 39 40 40 41 41)
graph export "figures\correlogram_full.tif", replace width (3000)
graph save "correlogram\correlogram_full.gph", replace


use "correlogram\full.dta", clear
replace _var30=. if trait==29
mkmat _var1-_var41, matrix(full_temp)
matselrc full_temp full_trimmed, r(1/30) c(1/30)
use "correlogram\full_q.dta", clear
replace qsig30=2 if trait==29
mkmat qsig1-qsig41, matrix(full_q_temp)
matselrc full_q_temp full_q_trimmed, r(1/30) c(1/30)

plotmatrix2, mat(full_trimmed) matse(full_q_trimmed) split(-1(0.05)1) formatcells(%3.2f) maxticks(9) allcolors( ///
red*1 red*0.95 red*0.9 red*0.85 red*0.8 red*0.75 red*0.7 red*0.65 red*0.6 red*0.55 red*0.5 red*0.45 red*0.4 red*0.35 red*0.3 red*0.25 red*0.2 red*0.15 red*0.1 red*0.05 ///
white*0 ///
blue*0.05 blue*0.1 blue*0.15 blue*0.2 blue*0.25 blue*0.3 blue*0.35 blue*0.4 blue*0.45 blue*0.5 blue*0.55 blue*0.6 blue*0.65 blue*0.7 blue*0.75 blue*0.8 blue*0.85 blue*0.9 blue*0.95 blue*1 ///
) ///
graphregion(color(white) lwidth(small)) ///
aspect(1) legend(cols(1) position(3) order(41 "+1" 40 "" 39 "" 38 "" 37 "" 36 "" 35 "" 34 "" 33 "" 32 "" 31 "" 30 "" 29 "" 28 "" 27 "" 26 "" ///
25 "" 24 "" 23 "" 22 "" 21 "" 20 "" 19 "" 18 "" 17 "" 16 "" 15 "" 14 "" 13 "" 12 "" 11 "" 10 "" 9 "" 8 "" 7 "" 6 "" 5 "" 4 "" 3 "" 2 "" 1 "-1") rowgap(0) symxsize(2) size(small) region(lcolor(white)) bmargin(none)) ///
ylabel(0 "SDQ   (4)" -1 "SDQ   (7)" -2 "SDQ   (8)" -3 "SDQ (10)" -4 "SDQ (12)" -5 "SDQ (13)" -6 "SDQ (16)" ///
-7 "SDQT   (7)" -8 "SDQT (10)" -9 "Social skills (13)" -10 "Communication (0.5)" -11 "Communication   (1)" -12 "Communication (1.5)" -13 "Communication   (3)" ///
-14 "Communication (10)" -15 "Self-esteem   (8)" -16 "Self-esteem (18)" -17 "Persistence (0.5)" -18 "Persistence   (2)" -19 "Persistence   (7)" ///
-20 "Locus of control   (8)" -21 "Locus of control (16)" -22 "Empathy   (7)" -23 "Impulsivity   (8)" -24 "Impulsivity (11)" ///
-25 "Extraversion (13)" -26 "Agreeableness (13)" -27 "Conscientiousness (13)" -28 "Emotional stability (13)" ///
-29 "Intellect/imagination (13)", angle(0) labsize(tiny)) ///
xlabel (1 "SDQ   (4)" 2 "SDQ (7)" 3 "SDQ   (8)" 4 "SDQ (10)" 5 "SDQ (12)" 6 "SDQ (13)" 7 "SDQ (16)" ///
8 "SDQT   (7)" 9 "SDQT (10)" 10 "Social skills (13)" 11 "Communication (0.5)" 12 "Communication   (1)" 13 "Communication (1.5)" 14 "Communication   (3)" ///
15 "Communication (10)" 16 "Self-esteem   (8)" 17 "Self-esteem (18)" 18 "Persistence (0.5)" 19 "Persistence   (2)" 20 "Persistence   (7)" ///
21 "Locus of control   (8)" 22 "Locus of control (16)" 23 "Empathy   (7)" 24 "Impulsivity   (8)" 25 "Impulsivity (11)"  ///
26 "Extraversion (13)" 27 "Agreeableness (13)" 28 "Conscientiousness (13)" 29 "Emotional stability (13)" ///
30 "Intellect/imagination (13)", angle(45) labsize(tiny)) ///
addbox(1 1 9 9 11 11 15 15 16 16 17 17 18 18 20 20 21 21 22 22 24 24 25 25)
graph export "figures\correlogram_noncog_only.tif", replace width (3000)
graph save "correlogram\correlogram_noncog_only.gph", replace
