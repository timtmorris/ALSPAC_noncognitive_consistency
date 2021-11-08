use "non_cog_analysis.dta", clear
drop employ neet neet
gen employ=YPC2450
egen neet=rowmax(YPC2450 YPC2451 YPC2453 YPC2456 YPC2458)
merge 1:1 aln qlet using "alspac_g1_with_genetic_data.dta", nogen
graph set window fontface "Calibri"

* First need to standardise each skill:
foreach var of varlist sdq4- sdq16_ext {
	egen `var'std=std(`var')
}

keep sdq4std- sdq16_extstd genetics male monthrescaled nonresponse18 nonresponse24 employ neet

rename ks2avstd ks2
rename ks3avstd ks3
rename ks4avstd ks4
rename ks5std ks5
rename incstd inc
global covars = "male monthrescaled iq8std"
global covars2 = "male iq8std"
gen iq8std2=iq8std
gen iq15std2=iq15std


* Run regressions on educational achievement:
foreach var of varlist ks2 ks3 ks4 ks5 {
	reg `var' sdq4std $covars if genetics==1
	estimates store results_1_`var'
	reg `var' sdq7std $covars if genetics==1
	estimates store results_2_`var'
	reg `var' sdq8std $covars if genetics==1
	estimates store results_3_`var'
	reg `var' sdq10std $covars if genetics==1
	estimates store results_4_`var'
	reg `var' sdq12std $covars if genetics==1
	estimates store results_5_`var'
	reg `var' sdq13std $covars if genetics==1
	estimates store results_6_`var'
	reg `var' sdq16std $covars if genetics==1
	estimates store results_7_`var'
	reg `var' sdqt7std $covars if genetics==1
	estimates store results_8_`var'
	reg `var' sdqt10std $covars if genetics==1
	estimates store results_9_`var'
	reg `var' social_skillsstd $covars if genetics==1
	estimates store results_14_`var'
	reg `var' communication5mstd $covars if genetics==1
	estimates store results_15_`var'
	reg `var' communication1std $covars if genetics==1
	estimates store results_16_`var'
	reg `var' communication18mstd $covars if genetics==1
	estimates store results_17_`var'	
	reg `var' communication3std $covars if genetics==1
	estimates store results_18_`var'
	reg `var' communication10std $covars if genetics==1
	estimates store results_19_`var'
	reg `var' selfesteem8std $covars if genetics==1
	estimates store results_20_`var'
	reg `var' selfesteem18std $covars if genetics==1
	estimates store results_21_`var'
	reg `var' persistence6mstd $covars if genetics==1
	estimates store results_22_`var'
	reg `var' persistence2std $covars if genetics==1
	estimates store results_23_`var'
	reg `var' persistence7std $covars if genetics==1
	estimates store results_24_`var'
	reg `var' loc8std $covars if genetics==1
	estimates store results_25_`var'
	reg `var' loc16std $covars if genetics==1
	estimates store results_26_`var'
	reg `var' empathystd $covars if genetics==1
	estimates store results_27_`var'
	reg `var' impulsivity8std $covars if genetics==1
	estimates store results_28_`var'
	reg `var' impulsivity11std $covars if genetics==1
	estimates store results_29_`var'
	reg `var' b5_estd $covars if genetics==1
	estimates store results_30_`var'
	reg `var' b5_astd $covars if genetics==1
	estimates store results_31_`var'
	reg `var' b5_cstd $covars if genetics==1
	estimates store results_32_`var'
	reg `var' b5_esstd $covars if genetics==1
	estimates store results_33_`var'
	reg `var' b5_iistd $covars if genetics==1
	estimates store results_34_`var'
	reg `var' iq8std2 $covars if genetics==1
	estimates store results_35_`var'
	reg `var' iq15std2 male monthrescaled if genetics==1
	estimates store results_36_`var'
}

foreach var of varlist inc {
	reg `var' sdq4std $covars2 if genetics==1 
	estimates store results_1_`var'
	reg `var' sdq7std $covars2 if genetics==1
	estimates store results_2_`var'
	reg `var' sdq8std $covars2 if genetics==1
	estimates store results_3_`var'
	reg `var' sdq10std $covars2 if genetics==1
	estimates store results_4_`var'
	reg `var' sdq12std $covars2 if genetics==1
	estimates store results_5_`var'
	reg `var' sdq13std $covars2 if genetics==1
	estimates store results_6_`var'
	reg `var' sdq16std $covars2 if genetics==1
	estimates store results_7_`var'
	reg `var' sdqt7std $covars2 if genetics==1
	estimates store results_8_`var'
	reg `var' sdqt10std $covars2 if genetics==1
	estimates store results_9_`var'
	reg `var' social_skillsstd $covars2 if genetics==1
	estimates store results_14_`var'
	reg `var' communication5mstd $covars2 if genetics==1
	estimates store results_15_`var'
	reg `var' communication1std $covars2 if genetics==1
	estimates store results_16_`var'
	reg `var' communication18mstd $covars2 if genetics==1
	estimates store results_17_`var'
	reg `var' communication3std $covars2 if genetics==1
	estimates store results_18_`var'	
	reg `var' communication10std $covars2 if genetics==1
	estimates store results_19_`var'
	reg `var' selfesteem8std $covars2 if genetics==1
	estimates store results_20_`var'
	reg `var' selfesteem18std $covars2 if genetics==1
	estimates store results_21_`var'
	reg `var' persistence6mstd $covars2 if genetics==1
	estimates store results_22_`var'
	reg `var' persistence2std $covars2 if genetics==1
	estimates store results_23_`var'
	reg `var' persistence7std $covars2 if genetics==1
	estimates store results_24_`var'
	reg `var' loc8std $covars2 if genetics==1
	estimates store results_25_`var'
	reg `var' loc16std $covars2 if genetics==1
	estimates store results_26_`var'
	reg `var' empathystd $covars2 if genetics==1
	estimates store results_27_`var'
	reg `var' impulsivity8std $covars2 if genetics==1
	estimates store results_28_`var'
	reg `var' impulsivity11std $covars2 if genetics==1
	estimates store results_29_`var'
	reg `var' b5_estd $covars2 if genetics==1
	estimates store results_30_`var'
	reg `var' b5_astd $covars2 if genetics==1
	estimates store results_31_`var'
	reg `var' b5_cstd $covars2 if genetics==1
	estimates store results_32_`var'
	reg `var' b5_esstd $covars2 if genetics==1
	estimates store results_33_`var'
	reg `var' b5_iistd $covars2 if genetics==1
	estimates store results_34_`var'
	reg `var' iq8std2 male if genetics==1
	estimates store results_35_`var'
	reg `var' iq15std2 male if genetics==1
	estimates store results_36_`var'
}

foreach var of varlist employ neet nonresponse24 {
	logit `var' sdq4std $covars2 if genetics==1
	estimates store results_1_`var'
	logistic `var' sdq7std $covars2 if genetics==1
	estimates store results_2_`var'
	logistic `var' sdq8std $covars2 if genetics==1
	estimates store results_3_`var'
	logistic `var' sdq10std $covars2 if genetics==1
	estimates store results_4_`var'
	logistic `var' sdq12std $covars2 if genetics==1
	estimates store results_5_`var'
	logistic `var' sdq13std $covars2 if genetics==1
	estimates store results_6_`var'
	logistic `var' sdq16std $covars2 if genetics==1
	estimates store results_7_`var'
	logistic `var' sdqt7std $covars2 if genetics==1
	estimates store results_8_`var'
	logistic `var' sdqt10std $covars2 if genetics==1
	estimates store results_9_`var'
	logistic `var' social_skillsstd $covars2 if genetics==1
	estimates store results_14_`var'
	logistic `var' communication5mstd $covars2 if genetics==1
	estimates store results_15_`var'
	logistic `var' communication1std $covars2 if genetics==1
	estimates store results_16_`var'
	logistic `var' communication18mstd $covars2 if genetics==1
	estimates store results_17_`var'
	logistic `var' communication3std $covars2 if genetics==1
	estimates store results_18_`var'
	logistic `var' communication10std $covars2 if genetics==1
	estimates store results_19_`var'
	logistic `var' selfesteem8std $covars2 if genetics==1
	estimates store results_20_`var'
	logistic `var' selfesteem18std $covars2 if genetics==1
	estimates store results_21_`var'
	logistic `var' persistence6mstd $covars2 if genetics==1
	estimates store results_22_`var'
	logistic `var' persistence2std $covars2 if genetics==1
	estimates store results_23_`var'
	logistic `var' persistence7std $covars2 if genetics==1
	estimates store results_24_`var'
	logistic `var' loc8std $covars2 if genetics==1
	estimates store results_25_`var'
	logistic `var' loc16std $covars2 if genetics==1
	estimates store results_26_`var'
	logistic `var' empathystd $covars2 if genetics==1
	estimates store results_27_`var'
	logistic `var' impulsivity8std $covars2 if genetics==1
	estimates store results_28_`var'
	logistic `var' impulsivity11std $covars2 if genetics==1
	estimates store results_29_`var'
	logistic `var' b5_estd $covars2 if genetics==1
	estimates store results_30_`var'
	logistic `var' b5_astd $covars2 if genetics==1
	estimates store results_31_`var'
	logistic `var' b5_cstd $covars2 if genetics==1
	estimates store results_32_`var'
	logistic `var' b5_esstd $covars2 if genetics==1
	estimates store results_33_`var'
	logistic `var' b5_iistd $covars2 if genetics==1
	estimates store results_34_`var'
	logistic `var' iq8std2 male if genetics==1
	estimates store results_35_`var'
	logistic `var' iq15std2 male if genetics==1
	estimates store results_36_`var'
}

foreach var of varlist nonresponse18 {
	logit `var' sdq4std $covars2 if genetics==1
	estimates store results_1_`var'
	logistic `var' sdq7std $covars2 if genetics==1
	estimates store results_2_`var'
	logistic `var' sdq8std $covars2 if genetics==1
	estimates store results_3_`var'
	logistic `var' sdq10std $covars2 if genetics==1
	estimates store results_4_`var'
	logistic `var' sdq12std $covars2 if genetics==1
	estimates store results_5_`var'
	logistic `var' sdq13std $covars2 if genetics==1
	estimates store results_6_`var'
	logistic `var' sdq16std $covars2 if genetics==1
	estimates store results_7_`var'
	logistic `var' sdqt7std $covars2 if genetics==1
	estimates store results_8_`var'
	logistic `var' sdqt10std $covars2 if genetics==1
	estimates store results_9_`var'
	logistic `var' social_skillsstd $covars2 if genetics==1
	estimates store results_14_`var'
	logistic `var' communication5mstd $covars2 if genetics==1
	estimates store results_15_`var'
	logistic `var' communication1std $covars2 if genetics==1
	estimates store results_16_`var'
	logistic `var' communication18mstd $covars2 if genetics==1
	estimates store results_17_`var'
	logistic `var' communication3std $covars2 if genetics==1
	estimates store results_18_`var'
	logistic `var' communication10std $covars2 if genetics==1
	estimates store results_19_`var'
	logistic `var' selfesteem8std $covars2 if genetics==1
	estimates store results_20_`var'
	logistic `var' persistence6mstd $covars2 if genetics==1
	estimates store results_22_`var'
	logistic `var' persistence2std $covars2 if genetics==1
	estimates store results_23_`var'
	logistic `var' persistence7std $covars2 if genetics==1
	estimates store results_24_`var'
	logistic `var' loc8std $covars2 if genetics==1
	estimates store results_25_`var'
	logistic `var' loc16std $covars2 if genetics==1
	estimates store results_26_`var'
	logistic `var' empathystd $covars2 if genetics==1
	estimates store results_27_`var'
	logistic `var' impulsivity8std $covars2 if genetics==1
	estimates store results_28_`var'
	logistic `var' impulsivity11std $covars2 if genetics==1
	estimates store results_29_`var'
	logistic `var' b5_estd $covars2 if genetics==1
	estimates store results_30_`var'
	logistic `var' b5_astd $covars2 if genetics==1
	estimates store results_31_`var'
	logistic `var' b5_cstd $covars2 if genetics==1
	estimates store results_32_`var'
	logistic `var' b5_esstd $covars2 if genetics==1
	estimates store results_33_`var'
	logistic `var' b5_iistd $covars2 if genetics==1
	estimates store results_34_`var'
	logistic `var' iq8std2 male if genetics==1
	estimates store results_35_`var'
	logistic `var' iq15std2 male if genetics==1
	estimates store results_36_`var'
}

coefplot ///
	results_1_ks4 results_2_ks4 results_3_ks4 results_4_ks4 results_5_ks4 results_6_ks4 results_7_ks4 ///
	results_8_ks4 results_9_ks4 results_14_ks4 ///
	results_15_ks4 results_16_ks4 results_17_ks4 results_18_ks4 results_19_ks4 results_20_ks4 results_21_ks4 ///
	results_22_ks4 results_23_ks4 results_24_ks4 results_25_ks4 results_26_ks4 results_27_ks4 results_28_ks4 ///
	results_29_ks4 results_30_ks4 results_31_ks4 results_32_ks4 results_33_ks4 results_34_ks4 results_35_ks4 ///
	results_36_ks4 ///
	, drop(_cons male monthrescaled iq8std iq15std) offset(0) legend(off) xline(0) xtitle("SD change in age 16 educational achievement") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ///
	ylabel(1 "SDQ   (4)  " 2 "SDQ   (7)  " 3 "SDQ   (8)  " 4 "SDQ   (10)" 5 "SDQ   (12)" 6 "SDQ   (13)" 7 "SDQ   (16)" ///
	8 "SDQT   (7)  " 9 "SDQT   (10)" 10 "Social skills   (13)" 11 "Communication  (0.5)" 12 "Communication   (1)  " 13 "Communication  (1.5)" ///
	14 "Communication   (3)  "  15 "Communication   (10)" 16 "Self-esteem   (8)  " ///
	17 "Self-esteem   (18)" 18 "Persistence  (0.5)" 19 "Persistence   (2)  " 20 "Persistence   (7)  " ///
	21 "Locus of control   (8)  " 22 "Locus of control   (16)" 23 "Empathy   (7)  " 24 "Impulsivity   (8)  " ///
	25 "Impulsivity   (11)" 26 "Extraversion   (13)" 27 "Agreeableness   (13)" 28 "Conscientiousness   (13)" ///
	29 "Emotional stability   (13)" 30 "Intellect/imagination   (13)" 31 "IQ   (8)  " 32 "IQ   (15)", labsize(vsmall))
graph export "figures\coefplot_ks4_only.tif", width(2000) replace


coefplot ///
	(results_1_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_2_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_3_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_4_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_5_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_6_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_7_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_8_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_9_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_14_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_15_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_16_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_17_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_18_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_19_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_20_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_21_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_22_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_23_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_24_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_25_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_26_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_27_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_28_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_29_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_30_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_31_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_32_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_33_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_34_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_35_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_36_ks2, offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_1_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_2_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_3_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_4_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_5_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_6_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_7_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_8_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_9_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_14_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_15_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_16_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_17_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_18_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_19_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_20_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_21_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_22_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_23_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_24_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_25_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_26_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_27_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_28_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_29_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_30_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_31_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_32_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_33_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_34_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_35_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_36_ks3, offset(0.1) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_1_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_2_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_3_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_4_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_5_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_6_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_7_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_8_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_9_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_14_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_15_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_16_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_17_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_18_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_19_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_20_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_21_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_22_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_23_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_24_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_25_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_26_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_27_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_28_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_29_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_30_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_31_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_32_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_33_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_34_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_35_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_36_ks4, offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_1_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_2_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_3_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_4_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_5_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_6_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_7_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_8_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_9_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_14_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_15_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_16_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_17_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_18_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_19_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_20_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_21_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_22_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_23_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_24_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_25_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_26_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_27_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_28_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_29_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_30_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_31_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_32_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_33_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_34_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_35_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_36_ks5, offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	, drop(_cons male monthrescaled iq8std iq15std) legend(order(2 "Age 11" 94 "Age 14" 140 "Age 16" 240 "Age 18") rows(1)) xline(0) xtitle("SD changes in educational achievement") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ysize(10) ///
	ylabel(1 "SDQ   (4)  " 2 "SDQ   (7)  " 3 "SDQ   (8)  " 4 "SDQ   (10)" 5 "SDQ   (12)" 6 "SDQ   (13)" 7 "SDQ   (16)" ///
	8 "SDQT   (7)  " 9 "SDQT   (10)" 10 "Social skills   (13)" 11 "Communication  (0.5)" 12 "Communication   (1)  " 13 "Communication  (1.5)" ///
	14 "Communication   (3)  "  15 "Communication   (10)" 16 "Self-esteem   (8)  " ///
	17 "Self-esteem   (18)" 18 "Persistence  (0.5)" 19 "Persistence   (2)  " 20 "Persistence   (7)  " ///
	21 "Locus of control   (8)  " 22 "Locus of control   (16)" 23 "Empathy   (7)  " 24 "Impulsivity   (8)  " ///
	25 "Impulsivity   (11)" 26 "Extraversion   (13)" 27 "Agreeableness   (13)" 28 "Conscientiousness   (13)" ///
	29 "Emotional stability   (13)" 30 "Intellect/imagination   (13)" 31 "IQ   (8)  " 32 "IQ   (15)", labsize(small))
graph export "figures\coefplot_edu.tif", width(2000) replace

coefplot ///
	(results_1_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_2_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_3_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_4_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_5_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_6_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_7_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_8_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_9_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_14_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_15_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_16_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_17_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_18_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_19_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_20_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_21_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_22_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_23_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_24_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_25_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_26_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_27_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_28_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_29_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_30_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_31_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_32_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_33_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_34_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_35_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_36_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_1_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_2_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_3_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_4_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_5_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_6_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_7_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_8_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_9_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_14_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_15_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_16_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_17_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_18_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_19_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_20_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_21_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_22_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_23_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_24_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_25_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_26_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_27_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_28_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_29_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_30_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_31_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_32_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_33_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_34_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_35_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_36_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	, drop(_cons male monthrescaled iq8std iq15std) legend(order(2 "Employed" 94 "EET") rows(1)) xline(1) xtitle("Odds Ratios for labour market outcomes") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ysize(10) ///
	ylabel(1 "SDQ   (4)  " 2 "SDQ   (7)  " 3 "SDQ   (8)  " 4 "SDQ   (10)" 5 "SDQ   (12)" 6 "SDQ   (13)" 7 "SDQ   (16)" ///
	8 "SDQT   (7)  " 9 "SDQT   (10)" 10 "Social skills   (13)" 11 "Communication  (0.5)" 12 "Communication   (1)  " 13 "Communication  (1.5)" ///
	14 "Communication   (3)  "  15 "Communication   (10)" 16 "Self-esteem   (8)  " ///
	17 "Self-esteem   (18)" 18 "Persistence  (0.5)" 19 "Persistence   (2)  " 20 "Persistence   (7)  " ///
	21 "Locus of control   (8)  " 22 "Locus of control   (16)" 23 "Empathy   (7)  " 24 "Impulsivity   (8)  " ///
	25 "Impulsivity   (11)" 26 "Extraversion   (13)" 27 "Agreeableness   (13)" 28 "Conscientiousness   (13)" ///
	29 "Emotional stability   (13)" 30 "Intellect/imagination   (13)" 31 "IQ   (8)  " 32 "IQ   (15)", labsize(small))
graph export "figures\coefplot_labmkt.tif", width(2000) replace

coefplot ///
	(results_1_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_2_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_3_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_4_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_5_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_6_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_7_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_8_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_9_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_14_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_15_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_16_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_17_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_18_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_19_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_20_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_21_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_22_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_23_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_24_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_25_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_26_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_27_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_28_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_29_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_30_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_31_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_32_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_33_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_34_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_35_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_36_inc,  msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	, drop(_cons male monthrescaled iq8std iq15std) legend(off) xline(0) xtitle("Change in income") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ysize(6) ///
	ylabel(1 "SDQ   (4)  " 2 "SDQ   (7)  " 3 "SDQ   (8)  " 4 "SDQ   (10)" 5 "SDQ   (12)" 6 "SDQ   (13)" 7 "SDQ   (16)" ///
	8 "SDQT   (7)  " 9 "SDQT   (10)" 10 "Social skills   (13)" 11 "Communication  (0.5)" 12 "Communication   (1)  " 13 "Communication  (1.5)" ///
	14 "Communication   (3)  "  15 "Communication   (10)" 16 "Self-esteem   (8)  " ///
	17 "Self-esteem   (18)" 18 "Persistence  (0.5)" 19 "Persistence   (2)  " 20 "Persistence   (7)  " ///
	21 "Locus of control   (8)  " 22 "Locus of control   (16)" 23 "Empathy   (7)  " 24 "Impulsivity   (8)  " ///
	25 "Impulsivity   (11)" 26 "Extraversion   (13)" 27 "Agreeableness   (13)" 28 "Conscientiousness   (13)" ///
	29 "Emotional stability   (13)" 30 "Intellect/imagination   (13)" 31 "IQ   (8)  " 32 "IQ   (15)", labsize(small))
graph export "figures\coefplot_income.tif", width(2000) replace


coefplot ///
	(results_1_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_2_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_3_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_4_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_5_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_6_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_7_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_8_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_9_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_14_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_15_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_16_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_17_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_18_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_19_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_20_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_21_inc, eform offset(0.3) msym(S) msize(vsmall) mcol(black%0) ciopts(lpatt(solid) lcol(black%0))) ///
	(results_22_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_23_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_24_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_25_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_26_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_27_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_28_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_29_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_30_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_31_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_32_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_33_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_34_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_35_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_36_nonresponse18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_1_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_2_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_3_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_4_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_5_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_6_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_7_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_8_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_9_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_14_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_15_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_16_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_17_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_18_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_19_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_20_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_21_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_22_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_23_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_24_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_25_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_26_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_27_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_28_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_29_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_30_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_31_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_32_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_33_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_34_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_35_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_36_nonresponse24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	, drop(_cons male monthrescaled iq8std iq15std) legend(order(2 "Non-response (18)" 94 "Non-response (24)") rows(1)) xline(1) xtitle("Odds Ratios for non-response") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ysize(10) ///
	ylabel(1 "SDQ   (4)  " 2 "SDQ   (7)  " 3 "SDQ   (8)  " 4 "SDQ   (10)" 5 "SDQ   (12)" 6 "SDQ   (13)" 7 "SDQ   (16)" ///
	8 "SDQT   (7)  " 9 "SDQT   (10)" 10 "Social skills   (13)" 11 "Communication  (0.5)" 12 "Communication   (1)  " 13 "Communication  (1.5)" ///
	14 "Communication   (3)  "  15 "Communication   (10)" 16 "Self-esteem   (8)  " ///
	17 "Self-esteem   (18)" 18 "Persistence  (0.5)" 19 "Persistence   (2)  " 20 "Persistence   (7)  " ///
	21 "Locus of control   (8)  " 22 "Locus of control   (16)" 23 "Empathy   (7)  " 24 "Impulsivity   (8)  " ///
	25 "Impulsivity   (11)" 26 "Extraversion   (13)" 27 "Agreeableness   (13)" 28 "Conscientiousness   (13)" ///
	29 "Emotional stability   (13)" 30 "Intellect/imagination   (13)" 31 "IQ   (8)  " 32 "IQ   (15)", labsize(small))
graph export "figures\coefplot_nonresponse.tif", width(2000) replace


********************************************************************************

estimates drop _all
use "non_cog_analysis.dta", clear
drop employ neet neet
gen employ=YPC2450
egen neet=rowmax(YPC2450 YPC2451 YPC2453 YPC2456 YPC2458)
merge 1:1 aln qlet using "alspac_g1_with_genetic_data.dta", nogen
graph set window fontface "Calibri"


* First need to standardise each skill:
foreach var of varlist social_skills empathy b5_e b5_a b5_c b5_es b5_ii iq8 iq15 ks2av ks3av ks4av ks5 *mean inc {
	egen `var'std=std(`var')
}
keep social_skillsstd- ks_meanstd genetics male monthrescaled incstd nonresponse18 nonresponse24 employ neet

rename ks2avstd ks2
rename ks3avstd ks3
rename ks4avstd ks4
rename ks5std ks5
rename incstd inc
global covars = "male monthrescaled iq8std"
global covars2 = "male iq8std"
gen iq8std2=iq8std
gen iq15std2=iq15std

* Regressions using mean values:
foreach var of varlist ks2 ks3 ks4 ks5 {
	reg `var' sdq_meanstd $covars if genetics==1
	estimates store results_mean_1_`var'
	reg `var' sdqt_meanstd $covars if genetics==1
	estimates store results_mean_2_`var'
	reg `var' social_skillsstd $covars if genetics==1
	estimates store results_mean_3_`var'
	reg `var' comm_meanstd $covars if genetics==1
	estimates store results_mean_4_`var'
	reg `var' selfesteem_meanstd $covars if genetics==1
	estimates store results_mean_5_`var'
	reg `var' persistence_meanstd $covars if genetics==1
	estimates store results_mean_6_`var'
	reg `var' loc_meanstd $covars if genetics==1
	estimates store results_mean_7_`var'
	reg `var' empathystd $covars if genetics==1
	estimates store results_mean_8_`var'
	reg `var' impuls_meanstd $covars if genetics==1
	estimates store results_mean_9_`var'
	reg `var' b5_estd $covars if genetics==1
	estimates store results_mean_10_`var'
	reg `var' b5_astd $covars if genetics==1
	estimates store results_mean_11_`var'
	reg `var' b5_cstd $covars if genetics==1
	estimates store results_mean_12_`var'
	reg `var' b5_esstd $covars if genetics==1
	estimates store results_mean_13_`var'
	reg `var' b5_iistd $covars if genetics==1
	estimates store results_mean_14_`var'
	reg `var' iq_meanstd male monthrescaled if genetics==1
	estimates store results_mean_15_`var'
}

foreach var of varlist inc {
	reg `var' sdq_meanstd $covars2 if genetics==1
	estimates store results_mean_1_`var'
	reg `var' sdqt_meanstd $covars2 if genetics==1
	estimates store results_mean_2_`var'
	reg `var' social_skillsstd $covars2 if genetics==1
	estimates store results_mean_3_`var'
	reg `var' comm_meanstd $covars2 if genetics==1
	estimates store results_mean_4_`var'
	reg `var' selfesteem_meanstd $covars2 if genetics==1
	estimates store results_mean_5_`var'
	reg `var' persistence_meanstd $covars2 if genetics==1
	estimates store results_mean_6_`var'
	reg `var' loc_meanstd $covars2 if genetics==1
	estimates store results_mean_7_`var'
	reg `var' empathystd $covars2 if genetics==1
	estimates store results_mean_8_`var'
	reg `var' impuls_meanstd $covars2 if genetics==1
	estimates store results_mean_9_`var'
	reg `var' b5_estd $covars2 if genetics==1
	estimates store results_mean_10_`var'
	reg `var' b5_astd $covars2 if genetics==1
	estimates store results_mean_11_`var'
	reg `var' b5_cstd $covars2 if genetics==1
	estimates store results_mean_12_`var'
	reg `var' b5_esstd $covars2 if genetics==1
	estimates store results_mean_13_`var'
	reg `var' b5_iistd $covars2 if genetics==1
	estimates store results_mean_14_`var'
	reg `var' iq_meanstd male monthrescaled if genetics==1
	estimates store results_mean_15_`var'
}

rename nonresponse18 nr18
rename nonresponse24 nr24
foreach var of varlist employ neet nr18 nr24 {
	logit `var' sdq_meanstd $covars2 if genetics==1
	estimates store results_mean_1_`var'
	logit `var' sdqt_meanstd $covars2 if genetics==1
	estimates store results_mean_2_`var'
	logit `var' social_skillsstd $covars2 if genetics==1
	estimates store results_mean_3_`var'
	logit `var' comm_meanstd $covars2 if genetics==1
	estimates store results_mean_4_`var'
	logit `var' selfesteem_meanstd $covars2 if genetics==1
	estimates store results_mean_5_`var'
	logit `var' persistence_meanstd $covars2 if genetics==1
	estimates store results_mean_6_`var'
	logit `var' loc_meanstd $covars2 if genetics==1
	estimates store results_mean_7_`var'
	logit `var' empathystd $covars2 if genetics==1
	estimates store results_mean_8_`var'
	logit `var' impuls_meanstd $covars2 if genetics==1
	estimates store results_mean_9_`var'
	logit `var' b5_estd $covars2 if genetics==1
	estimates store results_mean_10_`var'
	logit `var' b5_astd $covars2 if genetics==1
	estimates store results_mean_11_`var'
	logit `var' b5_cstd $covars2 if genetics==1
	estimates store results_mean_12_`var'
	logit `var' b5_esstd $covars2 if genetics==1
	estimates store results_mean_13_`var'
	logit `var' b5_iistd $covars2 if genetics==1
	estimates store results_mean_14_`var'
	logit `var' iq_meanstd male monthrescaled if genetics==1
	estimates store results_mean_15_`var'
}

coefplot ///
	results_mean_1_ks4 results_mean_2_ks4 results_mean_3_ks4 results_mean_4_ks4 ///
	results_mean_5_ks4 results_mean_6_ks4 results_mean_7_ks4 results_mean_8_ks4 ///
	results_mean_9_ks4 results_mean_10_ks4 results_mean_11_ks4 results_mean_12_ks4 ///
	results_mean_13_ks4 results_mean_14_ks4 results_mean_15_ks4 ///
	, drop(_cons male monthrescaled iq8std iq15std) offset(0) legend(off) xline(0) xtitle("SD change in age 16 educational achievement") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ///
	ylabel(1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills (13)" 4 "Communication  (aggregate)" 5 "Self-esteem (aggregate)" ///
	6 "Persistence (aggregate)" 7 "Locus of control (aggregate)" 8 "Empathy (7)" 9 "Impulsivity (aggregate)" ///
	10 "Extraversion (13)" 11 "Agreeableness (13)" 12 "Conscientiousness (13)" ///
	13 "Emotional stability (13)" 14 "Intellect/imagination (13)" 15 "IQ (aggregate)", labsize(small))
graph export "figures\coefplot_ks4_only_mean.tif", width(2000) replace


coefplot ///
	(results_mean_1_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_2_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_3_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_4_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_5_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_6_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_7_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_8_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_9_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_10_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_11_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_12_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_13_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_14_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_15_ks2 , offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_1_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_2_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_3_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_4_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_5_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_6_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_7_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_8_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_9_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_10_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_11_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_12_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_13_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_14_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_15_ks3 , offset(0.1) msym(X) msize(medium) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_1_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_2_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_3_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_4_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_5_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_6_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_7_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_8_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_9_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_10_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_11_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_12_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_13_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_14_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_15_ks4 , offset(-0.1) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_1_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_2_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_3_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_4_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_5_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_6_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_7_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_8_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_9_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_10_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_11_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_12_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_13_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_14_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	(results_mean_15_ks5 , offset(-0.3) msym(O) msize(vsmall) mcol(eltblue) ciopts(lpatt(solid) lcol(eltblue))) ///
	, drop(_cons male monthrescaled iq8std iq15std) legend(order(2 "Age 11" 32 "Age 14" 62 "Age 16" 92 "Age 18") rows(1)) xline(0) xtitle("SD changes in educational achievement") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ysize(7) ///
	ylabel(1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills (13)" 4 "Communication  (aggregate)" 5 "Self-esteem (aggregate)" ///
	6 "Persistence (aggregate)" 7 "Locus of control (aggregate)" 8 "Empathy (7)" 9 "Impulsivity (aggregate)" ///
	10 "Extraversion (13)" 11 "Agreeableness (13)" 12 "Conscientiousness (13)" ///
	13 "Emotional stability (13)" 14 "Intellect/imagination (13)" 15 "IQ (aggregate)", labsize(small))
graph export "figures\coefplot_edu_means.tif", width(2000) replace

coefplot ///
	(results_mean_1_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_2_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_3_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_4_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_5_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_6_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_7_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_8_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_9_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_10_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_11_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_12_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_13_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_14_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_15_employ, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_1_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_2_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_3_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_4_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_5_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_6_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_7_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_8_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_9_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_10_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_11_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_12_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_13_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_14_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_15_neet, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	, drop(_cons male monthrescaled iq8std iq15std) legend(order(2 "Employed" 32 "EET") rows(1)) xline(1) xtitle("Odds Ratios for labour market outcomes") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ysize(5) ///
	ylabel(1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills (13)" 4 "Communication  (aggregate)" 5 "Self-esteem (aggregate)" ///
	6 "Persistence (aggregate)" 7 "Locus of control (aggregate)" 8 "Empathy (7)" 9 "Impulsivity (aggregate)" ///
	10 "Extraversion (13)" 11 "Agreeableness (13)" 12 "Conscientiousness (13)" ///
	13 "Emotional stability (13)" 14 "Intellect/imagination (13)" 15 "IQ (aggregate)", labsize(small))
graph export "figures\coefplot_labmkt_mean.tif", width(2000) replace

coefplot ///
	(results_mean_1_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_2_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_3_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_4_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_5_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_6_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_7_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_8_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_9_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_10_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_11_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_12_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_13_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_14_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	(results_mean_15_inc, offset(0) msym(diamond) msize(vsmall) mcol(green) ciopts(lpatt(solid) lcol(green))) ///
	, drop(_cons male monthrescaled iq8std iq15std) legend(off) xline(0) xtitle("Change in income") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ///
	ylabel(1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills (13)" 4 "Communication  (aggregate)" 5 "Self-esteem (aggregate)" ///
	6 "Persistence (aggregate)" 7 "Locus of control (aggregate)" 8 "Empathy (7)" 9 "Impulsivity (aggregate)" ///
	10 "Extraversion (13)" 11 "Agreeableness (13)" 12 "Conscientiousness (13)" ///
	13 "Emotional stability (13)" 14 "Intellect/imagination (13)" 15 "IQ (aggregate)", labsize(small))
graph export "figures\coefplot_income_mean.tif", width(2000) replace


coefplot ///
	(results_mean_1_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_2_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_3_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_4_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_5_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_6_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_7_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_8_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_9_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_10_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_11_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_12_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_13_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_14_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_15_nr18, eform offset(0.3) msym(S) msize(vsmall) mcol(black) ciopts(lpatt(solid) lcol(black))) ///
	(results_mean_1_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_2_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_3_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_4_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_5_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_6_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_7_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_8_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_9_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_10_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_11_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_12_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_13_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_14_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	(results_mean_15_nr24, eform offset(0) msym(X) msize(small) mcol(red) ciopts(lpatt(solid) lcol(red))) ///
	, drop(_cons male monthrescaled iq8std iq15std) legend(order(2 "Non-response (18)" 32 "Non-response (24)") rows(1)) xline(1) xtitle("Odds Ratios for non-response") ///
	graphregion(color(white)) ///
	xscale(titlegap(*10)) lpatt(solid) lcol(black) msym(S) mcol(black) ciopts(lpatt(solid) lcol(black)) ysize(5) ///
	ylabel(1 "SDQ (aggregate)" 2 "SDQT (aggregate)" 3 "Social skills (13)" 4 "Communication  (aggregate)" 5 "Self-esteem (aggregate)" ///
	6 "Persistence (aggregate)" 7 "Locus of control (aggregate)" 8 "Empathy (7)" 9 "Impulsivity (aggregate)" ///
	10 "Extraversion (13)" 11 "Agreeableness (13)" 12 "Conscientiousness (13)" ///
	13 "Emotional stability (13)" 14 "Intellect/imagination (13)" 15 "IQ (aggregate)", labsize(small))
graph export "figures\coefplot_nonresponse_mean.tif", width(2000) replace