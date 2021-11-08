* Importing and tidying up input files:
#delimit ;
forvalues j = 1/24 { ;
forvalues j2 = 1/24 { ;
	if `j2'>`j' { ;
	insheet using out_pheno_bivar_`j'_`j2'.hsq,  clear ;
	sxpose, clear firstnames force ;
	gen firstrec=1 in 1 ;
	gen vg1_se= _var1[_n+1] if firstrec==1 ;
	gen vg2_se= _var2[_n+1] if firstrec==1 ;
	gen cg12_se= _var3[_n+1] if firstrec==1 ;
	gen ve1_se= _var4[_n+1] if firstrec==1 ;
	gen ve2_se= _var5[_n+1] if firstrec==1 ;
	gen ce12_se= _var6[_n+1] if firstrec==1 ;
	gen vp1_se= Vp_tr1[_n+1] if firstrec==1 ;
	gen vp2_se= Vp_tr2[_n+1] if firstrec==1 ;
	gen vg_vp1_se= _var9[_n+1] if firstrec==1 ;
	gen vg_vp2_se= _var10[_n+1] if firstrec==1 ;
	gen rg_se= rG[_n+1] if firstrec==1 ;
	rename _var1 vg1 ;
	rename _var2 vg2 ;
	rename _var3 cg12 ;
	rename _var4 ve1 ;
	rename _var5 ve2 ;
	rename _var6 ve12 ;
	rename Vp_tr1 vp1 ;
	rename Vp_tr2 vp2 ;
	rename _var9 vg_vp1 ;
	rename _var10 vg_vp2 ;
	rename rG rg ;
	rename logL logl ;
	rename logL0 logl0 ;
	rename LRT lrt ;
	rename Pval p ;
	drop in 2 ;
	drop firstrec ;
	gen trait1=`j' ;
	gen trait2=`j2' ;
	order trait1 trait2, first ;
	save `j'_`j2'.dta, replace ;
	} ;
	else clear ;
} ;
} ;
#delimit cr

clear
#delimit ;
forvalues j = 1/24 { ;
forvalues j2 = 1/24 { ;
	if `j2'>`j' { ;
	append using `j'_`j2'.dta ;
	} ;
	else ;
} ;
} ;
#delimit cr

split p, p(" (")
drop p p2
rename p1 p
split logl0, p(" (")
drop logl0 logl02
rename logl01 log10
destring *, replace

* Erasing all temporary files:
#delimit ;
forvalues j = 1/24 { ;
forvalues j2 = 1/24 { ;
	if `j2'>`j' { ;
	erase `j'_`j2'.dta ;
	} ;
	else ;
} ;
} ;
#delimit cr

* Saving file:
save "bivariate_output\unadjusted_bivariate_heritabilities_means.dta", replace

* Creating rg & rg se files: 
use "bivariate_output\unadjusted_bivariate_heritabilities_means.dta", clear
keep trait1 trait2 rg
rename rg _var
reshape wide _var, i(trait1) j(trait2)
rename trait1 trait
gen _var1=.
order _var1, after(trait)
set obs 24
drop trait
gen trait=_n
order trait, first
compress
save "bivariate_output\bivariate_rg_unadjusted_means.dta", replace

use "bivariate_output\unadjusted_bivariate_heritabilities_means.dta", clear
keep trait1 trait2 rg_se
rename rg_se _var
reshape wide _var, i(trait1) j(trait2)
rename trait1 trait
gen _var1=.
order _var1, after(trait)
set obs 24
drop trait
gen trait=_n
order trait, first
order trait, first
compress
save "bivariate_output\bivariate_rg_se_unadjusted_means.dta", replace


* Adjusted: 
* Importing and tidying up input files:
#delimit ;
forvalues j = 1/24 { ;
forvalues j2 = 1/24 { ;
	if `j2'>`j' { ;
	insheet using out_pheno_adj_bivar_`j'_`j2'.hsq, clear ;
	sxpose, clear firstnames force ;
	gen firstrec=1 in 1 ;
	gen vg1_se= _var1[_n+1] if firstrec==1 ;
	gen vg2_se= _var2[_n+1] if firstrec==1 ;
	gen cg12_se= _var3[_n+1] if firstrec==1 ;
	gen ve1_se= _var4[_n+1] if firstrec==1 ;
	gen ve2_se= _var5[_n+1] if firstrec==1 ;
	gen ce12_se= _var6[_n+1] if firstrec==1 ;
	gen vp1_se= Vp_tr1[_n+1] if firstrec==1 ;
	gen vp2_se= Vp_tr2[_n+1] if firstrec==1 ;
	gen vg_vp1_se= _var9[_n+1] if firstrec==1 ;
	gen vg_vp2_se= _var10[_n+1] if firstrec==1 ;
	gen rg_se= rG[_n+1] if firstrec==1 ;
	rename _var1 vg1 ;
	rename _var2 vg2 ;
	rename _var3 cg12 ;
	rename _var4 ve1 ;
	rename _var5 ve2 ;
	rename _var6 ve12 ;
	rename Vp_tr1 vp1 ;
	rename Vp_tr2 vp2 ;
	rename _var9 vg_vp1 ;
	rename _var10 vg_vp2 ;
	rename rG rg ;
	rename logL logl ;
	rename logL0 logl0 ;
	rename LRT lrt ;
	rename Pval p ;
	drop in 2 ;
	drop firstrec ;
	gen trait1=`j' ;
	gen trait2=`j2' ;
	order trait1 trait2, first ;
	save `j'_`j2'.dta, replace ;
	} ;
	else clear ;
} ;
} ;
#delimit cr

clear
#delimit ;
forvalues j = 1/24 { ;
forvalues j2 = 1/24 { ;
	if `j2'>`j' { ;
	append using `j'_`j2'.dta ;
	} ;
	else ;
} ;
} ;
#delimit cr

split p, p(" (")
drop p p2
rename p1 p
split logl0, p(" (")
drop logl0 logl02
rename logl01 log10
destring *, replace

* Erasing all temporary files:
#delimit ;
forvalues j = 1/24 { ;
forvalues j2 = 1/24 { ;
	if `j2'>`j' { ;
	erase `j'_`j2'.dta ;
	} ;
	else ;
} ;
} ;
#delimit cr

* Saving file:
save "bivariate_output\adjusted_bivariate_heritabilities_means.dta", replace

* Creating rg & rg se files: 
use "bivariate_output\adjusted_bivariate_heritabilities_means.dta", clear
keep trait1 trait2 rg
rename rg _var
reshape wide _var, i(trait1) j(trait2)
rename trait1 trait
gen _var1=.
order _var1, after(trait)
set obs 24
drop trait
gen trait=_n
order trait, first
compress
save "bivariate_output\bivariate_rg_adjusted_means.dta", replace

use "bivariate_output\adjusted_bivariate_heritabilities_means.dta", clear
keep trait1 trait2 rg_se
rename rg_se _var
reshape wide _var, i(trait1) j(trait2)
rename trait1 trait
gen _var1=.
order _var1, after(trait)
set obs 24
drop trait
gen trait=_n
order trait, first
compress
save "bivariate_output\bivariate_rg_se_adjusted_means.dta", replace