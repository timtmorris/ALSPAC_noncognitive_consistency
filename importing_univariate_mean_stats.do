cd "C:\Users\epttm\OneDrive - University of Bristol\MyFiles-Migrated\TIM\Projects\ALSPAC\Projects\Neil_noncog\blue_crystal\output\univariate_means"
graph set window fontface "Calibri"

* Unadjusted:
forvalues j = 1/24 {
	insheet using out_pheno_`j'.hsq, clear
	sxpose, clear firstnames force
	gen firstrec=1 in 1
	gen vg_se= _var1[_n+1] if firstrec==1
	gen ve_se= _var2[_n+1] if firstrec==1
	gen vp_se= Vp[_n+1] if firstrec==1
	gen vg_vp_se= _var4[_n+1] if firstrec==1
	rename _var1 vg
	rename _var2 ve
	rename Vp vp
	rename _var4 vg_vp 
	rename logL logl
	rename logL0 logl0
	rename LRT lrt
	rename Pval p
	drop in 2
	drop firstrec
	gen trait=`j'
	order trait, first
	save `j'.dta, replace
} 

use 1.dta, clear
forvalues j=2/24 {
	append using `j'.dta
	erase `j'.dta
}
erase 1.dta

label def mean_trait_lb 1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills" 4 "Communication (aggregate)"  ///
	5 "Self-esteem (aggregate)" 6 "Persistence (aggregate)" 7 "Locus of Control (aggregate)" 8 "Empathy" 9 "Impulsivity (aggregate)" ///
	10 "Big5 Extraversion" 11 "Big5 Agreeableness" 12 "Big5 Conscientiousness" 13 "Big5 Emotional stability" ///
	14 "Big5 Intellect/imagination" 15 "IQ (aggregate)" 16 "KS2 points" 17 "KS3 points" 18 "KS4 points" ///
	19 "KS5 grades" 20 "Employed" 21 "EET" 22 "Income" 23 "Non-response age 18" 24 "Non-response age 24"
la val trait mean_trait_lb

destring *, replace
order trait vg vg_se ve ve_se vp vp_se vg_vp vg_vp_se

compress 
save "unvariate_output\univariate_means_unadjusted.dta", replace


* Adjusted:
clear
forvalues j = 1/24 {
	insheet using out_pheno_adj_`j'.hsq, clear
	sxpose, clear firstnames force
	gen firstrec=1 in 1
	gen vg_se= _var1[_n+1] if firstrec==1
	gen ve_se= _var2[_n+1] if firstrec==1
	gen vp_se= Vp[_n+1] if firstrec==1
	gen vg_vp_se= _var4[_n+1] if firstrec==1
	rename _var1 vg
	rename _var2 ve
	rename Vp vp
	rename _var4 vg_vp 
	rename logL logl
	rename logL0 logl0
	rename LRT lrt
	rename Pval p
	drop in 2
	drop firstrec
	gen trait=`j'
	order trait, first
	save `j'_adj.dta, replace
} 

use 1_adj.dta, clear
forvalues j=2/24 {
	append using `j'_adj.dta
	erase `j'_adj.dta
}
erase 1_adj.dta

destring *, replace
order trait vg vg_se ve ve_se vp vp_se vg_vp vg_vp_se

compress 
save "unvariate_output\univariate_means_adjusted.dta", replace


* Combining heritabilities for correlogram:
use "unvariate_output\univariate_means_adjusted.dta", clear
keep trait vg_vp vg_vp_se p
rename vg_vp vg_vp_adj
rename vg_vp_se vg_vp_se_adj
rename p p_adj
merge 1:1 trait using "unvariate_output\univariate_means_unadjusted", nogen
keep trait vg_vp vg_vp_se p vg_vp_adj vg_vp_se_adj p_adj
order trait vg_vp vg_vp_se p vg_vp_adj vg_vp_se_adj p_adj
sort trait
by trait: gen vg_vp_uci=vg_vp+(1.96*vg_vp_se)
by trait: gen vg_vp_lci=vg_vp-(1.96*vg_vp_se)
by trait: gen vg_vp_adj_uci=vg_vp_adj+(1.96*vg_vp_se_adj)
by trait: gen vg_vp_adj_lci=vg_vp_adj-(1.96*vg_vp_se_adj)
drop p
gen z=vg_vp/vg_vp_se
gen p=exp((-0.717*z)-(0.416*z^2))
drop z p_adj
gen z=vg_vp_adj/vg_vp_se_adj
gen p_adj=exp((-0.717*z)-(0.416*z^2))
drop z

* Calculating FDR:
sort p
gen p_rank=_n
gen q=(p_rank/24)*0.05
gen q_sig=1 if p<q
replace q_sig=1 if q_sig[_n+1]==1
sort p_adj
gen p_adj_rank=_n
gen q_adj=(p_adj_rank/24)*0.05
gen q_adj_sig=1 if p_adj<q_adj
replace q_adj_sig=1 if q_adj_sig[_n+1]==1
sort trait
save "unvariate_output\univariate_means_heritability.dta", replace


* Creating heritability graphs: 
graph twoway ///
	(bar vg_vp_adj trait if q_adj_sig!=1, fcolor(gs12) lcolor(gs1) barwidth(1)) /// 
	(bar vg_vp_adj trait if q_adj_sig==1, fcolor(gs6) lcolor(gs1) barwidth(1)) ///  
	(rcap vg_vp_adj_uci vg_vp_adj_lci trait, color(red*1.5)), ///
	graphregion(color(white)) ///
	ytitle("Heritability") ylabel(,labsize(small) angle(0)) xtitle("") yscale(titlegap(*-30)) ///
	legend(off) xlabel(1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills (13)" 4 "Communication (aggregate)"  ///
	5 "Self-esteem (aggregate)" 6 "Persistence (aggregate)" 7 "Locus of Control (aggregate)" 8 "Empathy (7)" 9 "Impulsivity (aggregate)" ///
	10 "Big5 Extraversion (13)" 11 "Big5 Agreeableness (13)" 12 "Big5 Conscientiousness (13)" 13 "Big5 Emotional stability (13)" ///
	14 "Big5 Intellect/imagination (13)" 15 "IQ (aggregate)" 16 "Achievement (11)" 17 "Achievement (14)" 18 "Achievement (16)" ///
	19 "Achievement (18)" 20 "Employed" 21 "EET" 22 "Income" 23 "Non-response (18)" 24 "Non-response (24)", ///
	valuelabel angle(90) labsize(small))
graph export "figures\mean_heritability_adjusted.tif", width(2000) replace