use "`pathway'\timeline_data.dta", clear
use "timeline_data.dta", clear
graph set window fontface "Calibri"

twoway ///
	(scatter nonresponse ageyears, mcolor(black) msymbol(X) msize(large)) ///
	(scatter neet ageyears, mcolor(black) msymbol(X) msize(large)) ///
	(scatter employment ageyears, mcolor(black) msymbol(X) msize(large)) ///
	(scatter income ageyears, mcolor(black) msymbol(X) msize(large)) ///
	(scatter education ageyears, mcolor(black) msymbol(X) msize(large)) ///
	(scatter iq ageyears, mcolor(black) msymbol(diamond)) ///
	(scatter personality ageyears, mcolor(black)) ///
	(scatter impulsivity ageyears, mcolor(black)) ///
	(scatter empathy ageyears, mcolor(black)) ///
	(scatter locusofcontrol ageyears, mcolor(black)) ///
	(scatter persistence ageyears, mcolor(black)) ///
	(scatter selfesteem ageyears, mcolor(black)) ///
	(scatter communication ageyears, mcolor(black)) ///
	(scatter socialskills ageyears, mcolor(black)) ///
	(scatter sdqt ageyears, mcolor(black)) ///
	(scatter sdq ageyears, mcolor(black) ///
	graphregion(color(white)) ///
	legend(order(15 "Non-cognitive" 5 "Cognitive" 3 "Outcomes") rows(1)) ///
	ylabel(15 "SDQ" 14 "SDQ Teacher" 13 "Social skills" ///
	12 "Communication" 11 "Self-esteem" 10 "Persistence" 9 "Locus of control" ///
	8 "Empathy" 7 "Impulsivity" 6 "Personality" 5 "IQ" 4 "Education" 3 "Employment" 2 "EET" ///
	1 "Income" 0"Non-response", angle(0) labsize(small)))
graph export "`pathway'\figures\timeline.tif", width(2000) replace