
cd "`pathway'\unvariate_output"
graph set window fontface "Calibri"

* Unadjusted:
forvalues j = 1/41 {
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
forvalues j=2/41 {
	append using `j'.dta
	erase `j'.dta
}
erase 1.dta

la def trait_lb 1 "SDQ (4)" 2 "SDQ (7)" 3 "SDQ (8)" 4 "SDQ (10)" 5 "SDQ (12)" 6 "SDQ (13)" 7 "SDQ (16)" ///
	8 "SDQT (7)" 9 "SDQT (10)" 10 "Social skills (13)" 11 "Communication (0.5)" ///
	12 "Communication (1)" 13 "Communication (1.5)" 14 "Communication (3)"  15 "Communication (10)" 16 "Self-esteem (8)" ///
	17 "Self-esteem (18)" 18 "Persistence (0.5)" 19 "Persistence (2)" 20 "Persistence (7)" ///
	21 "Locus of control (8)" 22 "Locus of control (16)" 23 "Empathy (7)" 24 "Impulsivity (8)" ///
	25 "Impulsivity (11)" 26 "Extraversion (13)" 27 "Agreeableness (13)" 28 "Conscientiousness (13)" ///
	29 "Emotional stability (13)" 30 "Intellect/imagination (13)" 31"IQ (8)" 32 "IQ (15)" ///
	33 "Achievement (11)" 34 "Achievement (14)" 35 "Achievement (16)" 36 "Achievement (18)" 37 "Employed (23)" 38 "EET (23)" ///
	39 "Income (23)" 40 "Non-response (18)" 41 "Non-response (24)"
la val trait trait_lb

destring *, replace
order trait vg vg_se ve ve_se vp vp_se vg_vp vg_vp_se
compress
save "unvariate_output\univariate_unadjusted.dta", replace


* Adjusted:
clear
forvalues j = 1/41 {
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
forvalues j=2/41 {
	append using `j'_adj.dta
	erase `j'_adj.dta
}
erase 1_adj.dta

la def trait_lb 1 "SDQ (4)" 2 "SDQ (7)" 3 "SDQ (8)" 4 "SDQ (10)" 5 "SDQ (12)" 6 "SDQ (13)" 7 "SDQ (16)" ///
	8 "SDQT (7)" 9 "SDQT (10)" 10 "Social skills (13)" 11 "Communication (0.5)" ///
	12 "Communication (1)" 13 "Communication (1.5)" 14 "Communication (3)"  15 "Communication (10)" 16 "Self-esteem (8)" ///
	17 "Self-esteem (18)" 18 "Persistence (0.5)" 19 "Persistence (2)" 20 "Persistence (7)" ///
	21 "Locus of control (8)" 22 "Locus of control (16)" 23 "Empathy (7)" 24 "Impulsivity (8)" ///
	25 "Impulsivity (11)" 26 "Extraversion (13)" 27 "Agreeableness (13)" 28 "Conscientiousness (13)" ///
	29 "Emotional stability (13)" 30 "Intellect/imagination (13)" 31"IQ (8)" 32 "IQ (15)" ///
	33 "Achievement (11)" 34 "Achievement (14)" 35 "Achievement (16)" 36 "Achievement (18)" 37 "Employed (23)" 38 "EET (23)" ///
	39 "Income (23)" 40 "Non-response (18)" 41 "Non-response (24)"
la val trait trait_lb

destring *, replace
order trait vg vg_se ve ve_se vp vp_se vg_vp vg_vp_se

compress 
save "unvariate_output\univariate_adjusted.dta", replace


* Combining heritabilities for correlogram:
use "unvariate_output\univariate_adjusted.dta", clear
keep trait vg_vp vg_vp_se p
rename vg_vp vg_vp_adj
rename vg_vp_se vg_vp_se_adj
rename p p_adj
merge 1:1 trait using "unvariate_output\univariate_unadjusted", nogen
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
gen q=(p_rank/41*0.05)
gen q_sig=1 if p<q
replace q_sig=1 if q_sig[_n+1]==1
sort p_adj
gen p_adj_rank=_n
gen q_adj=(p_adj_rank/41)*0.05
gen q_adj_sig=1 if p_adj<q_adj
replace q_adj_sig=1 if q_adj_sig[_n+1]==1
sort trait
save "unvariate_output\univariate_heritability.dta", replace


* Creating heritability graphs: 
graph twoway ///
	(bar vg_vp_adj trait if q_adj_sig!=1 & trait<=45, fcolor(gs12) lcolor(gs1) barwidth(1)) /// 
	(bar vg_vp_adj trait if q_adj_sig==1 & trait<=45, fcolor(gs6) lcolor(gs1) barwidth(1)) ///  
	(rcap vg_vp_adj_uci vg_vp_adj_lci trait if trait<=45, color(red*1.5)), ///
	graphregion(color(white)) ///
	ytitle("Heritability") ylabel(,labsize(small) angle(0)) xtitle("") yscale(titlegap(*-30)) ///
	legend(off) xlabel(1 "SDQ (4)" 2 "SDQ (7)" 3 "SDQ (8)" 4 "SDQ (10)" 5 "SDQ (12)" 6 "SDQ (13)" 7 "SDQ (16)" ///
	8 "SDQT (7)" 9 "SDQT (10)" 10 "Social skills (13)" 11 "Communication (0.5)" ///
	12 "Communication (1)" 13 "Communication (1.5)" 14 "Communication (3)"  15 "Communication (10)" 16 "Self-esteem (8)" ///
	17 "Self-esteem (18)" 18 "Persistence (0.5)" 19 "Persistence (2)" 20 "Persistence (7)" ///
	21 "Locus of control (8)" 22 "Locus of control (16)" 23 "Empathy (7)" 24 "Impulsivity (8)" ///
	25 "Impulsivity (11)" 26 "Extraversion (13)" 27 "Agreeableness (13)" 28 "Conscientiousness (13)" ///
	29 "Emotional stability (13)" 30 "Intellect/imagination (13)" 31"IQ (8)" 32 "IQ (15)" ///
	33 "Achievement (11)" 34 "Achievement (14)" 35 "Achievement (16)" 36 "Achievement (18)" 37 "Employed (23)" 38 "EET (23)" ///
	39 "Income (23)" 40 "Non-response (18)" 41 "Non-response (24)", ///
	valuelabel angle(90) labsize(small))
graph export "figures\heritability_adjusted.tif", width(2000) replace


* Heritability of SDQ subscales:
cd "unvariate_output\sdq_subscales"

* Unadjusted:
forvalues j = 1/14 {
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
forvalues j=2/14 {
	append using `j'.dta
	erase `j'.dta
}
erase 1.dta

la def trait_lb 1 "SDQ 4" 2 "SDQ 7" 3 "SDQ 8" 4 "SDQ 10" 5 "SDQ 12" 6 "SDQ 13" 7 "SDQ 16" ///
	101 "SDQ 4 Internalising" 102 "SDQ 7 Internalising" 103 "SDQ 8 Internalising" ///
	104 "SDQ 10 Internalising" 105 "SDQ 12 Internalising" 106 "SDQ 13 Internalising" ///
	107 "SDQ 16 Internalising" 108 "SDQ 4 Externalising" 109 "SDQ 7 Externalising" ///
	110 "SDQ 8 Externalising" 111 "SDQ 10 Externalising" 112 "SDQ 12 Externalising" ///
	113 "SDQ 13 Externalising" 114 "SDQ 16 Externalising"
la val trait trait_lb

destring *, replace
order trait vg vg_se ve ve_se vp vp_se vg_vp vg_vp_se

compress 
save "unvariate_output\unadjusted_subscales.dta", replace


* Adjusted:
clear
forvalues j = 1/14 {
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
forvalues j=2/14 {
	append using `j'_adj.dta
	erase `j'_adj.dta
}
erase 1_adj.dta

la def trait_lb 1 "SDQ 4" 2 "SDQ 7" 3 "SDQ 8" 4 "SDQ 10" 5 "SDQ 12" 6 "SDQ 13" 7 "SDQ 16" ///
	101 "SDQ 4 Internalising" 102 "SDQ 7 Internalising" 103 "SDQ 8 Internalising" ///
	104 "SDQ 10 Internalising" 105 "SDQ 12 Internalising" 106 "SDQ 13 Internalising" ///
	107 "SDQ 16 Internalising" 108 "SDQ 4 Externalising" 109 "SDQ 7 Externalising" ///
	110 "SDQ 8 Externalising" 111 "SDQ 10 Externalising" 112 "SDQ 12 Externalising" ///
	113 "SDQ 13 Externalising" 114 "SDQ 16 Externalising"
la val trait trait_lb

destring *, replace
order trait vg vg_se ve ve_se vp vp_se vg_vp vg_vp_se

compress 
save "unvariate_output\univariate_adjusted_subscales.dta", replace

use "unvariate_output\univariate_adjusted_subscales.dta", clear
keep trait vg_vp vg_vp_se p
rename vg_vp vg_vp_adj
rename vg_vp_se vg_vp_se_adj
rename p p_adj
merge 1:1 trait using "unvariate_output\univariate_unadjusted_subscales", nogen
keep trait vg_vp vg_vp_se vg_vp_adj vg_vp_se_adj p p_adj
order trait vg_vp vg_vp_se vg_vp_adj vg_vp_se_adj p p_adj
save "unvariate_output\univariate_heritability_subscales.dta", replace
replace trait=trait+100
append using "unvariate_output\univariate_heritability.dta"

keep if trait<=7 | trait>=100
recode trait	(1=1) (101=2) (108=3) ///
				(2=5) (102=6) (109=7) ///
				(3=9) (103=10) (110=11) ///
				(4=13) (104=14) (111=15) ///
				(5=17) (105=18) (112=19) ///
				(6=21) (106=22) (113=23) ///
				(7=25) (107=26) (114=27)
la def trait_lb	1 "SDQ 4" 2 "SDQ 4 Internalising" 3 "SDQ 4 Externalising" ///
				5 "SDQ 7" 6 "SDQ 7 Internalising" 7 "SDQ 7 Externalising" ///
				9 "SDQ 8" 10 "SDQ 8 Internalising" 11 "SDQ 8 Externalising" ///
				13 "SDQ 10" 14 "SDQ 10 Internalising" 15 "SDQ 10 Externalising" ///
				17 "SDQ 12" 18 "SDQ 12 Internalising" 19 "SDQ 12 Externalising" ///
				21 "SDQ 13" 22 "SDQ 13 Internalising" 23 "SDQ 13 Externalising" ///
				25 "SDQ 16" 26 "SDQ 16 Internalising" 27 "SDQ 16 Externalising", modify
sort trait
by trait: replace vg_vp_uci=vg_vp+(1.96*vg_vp_se)
by trait: replace vg_vp_lci=vg_vp-(1.96*vg_vp_se)
by trait: replace vg_vp_adj_uci=vg_vp_adj+(1.96*vg_vp_se_adj)
by trait: replace vg_vp_adj_lci=vg_vp_adj-(1.96*vg_vp_se_adj)
drop p
gen z=vg_vp/vg_vp_se
gen p=exp((-0.717*z)-(0.416*z^2))
drop z p_adj
gen z=vg_vp_adj/vg_vp_se_adj
gen p_adj=exp((-0.717*z)-(0.416*z^2))
drop z

* Calculating FDR:
drop p_rank q q_sig p_adj_rank q_adj q_adj_sig
sort p
gen p_rank=_n
gen q=(p_rank/21)*0.05
gen q_sig=1 if p<q
replace q_sig=1 if q_sig[_n+1]==1
sort p_adj
gen p_adj_rank=_n
gen q_adj=(p_adj_rank/21)*0.05
gen q_adj_sig=1 if p_adj<q_adj
replace q_adj_sig=1 if q_adj_sig[_n+1]==1

graph twoway ///
	(bar vg_vp_adj trait if q_adj_sig!=1, fcolor(gs12) lcolor(gs1) barwidth(1)) ///
	(bar vg_vp_adj trait if q_adj_sig==1, fcolor(gs6) lcolor(gs1) barwidth(1)) ///
	(rcap vg_vp_adj_uci vg_vp_adj_lci trait, color(red*1.5)), ///
	graphregion(color(white)) ///
	ytitle("Heritability") ylabel(,labsize(small) angle(0)) xtitle("SDQ") ///
	legend(off) xlabel(1 "Total   (4)" 2 "Internalising   (4)" 3 "Externalising   (4)" ///
	5 "Total   (7)" 6 "Internalising   (7)" 7 "Externalising   (7)" ///
	9 "Total   (8)" 10 "Internalising   (8)" 11 "Externalising   (8)"  ///
	13 "Total   (10)" 14 "Internalising   (10)" 15 "Externalising   (10)" ///
	17 "Total   (12)" 18 "Internalising   (12)" 19 "Externalising   (12)" ///
	21 "Total   (13)" 22 "Internalising   (13)" 23 "Externalising   (13)" ///
	25 "Total   (16)" 26 "Internalising   (16)" 27 "Externalising   (16)", ///
	valuelabel angle(90) labsize(small))
graph export "figures\sdq_scales_heritability.tif", width(2000) replace