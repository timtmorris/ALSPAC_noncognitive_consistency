********************************************************************************
* Master code for Morris, T.T., Davey Smith, G., van den Berg, G. et al. 
* 		Consistency of noncognitive skills and their relation to educational 
* 		outcomes in a UK cohort. Transl Psychiatry 11, 563 (2021). 
* 		https://doi.org/10.1038/s41398-021-01661-8
* 
* Tim Morris. 
* Email: tim.morris@bristol.ac.uk
* 
********************************************************************************

* Analyses require access to the dataset used for this project. Data access can
* 		be granted subject to approval by the ALSPAC executive committee 
* 		(alspac-exec@bristol.ac.uk). The datasets used in this project have been
* 		archived under the project identifier B2310.

local pathway "[enter your file pathway here]"
mkdir "`pathway'\figures"
mkdir "`pathway'\correlogram"
mkdir "`pathway'\unvariate_output"
mkdir "`pathway'\unvariate_output\sdq_subscales"
mkdir "`pathway'\bivariate_output"

do importing_univariate_stats.do
do importing_univariate_mean_stats.do
do importing_bivariate_stats.do
do importing_bivariate_mean_stats.do
do correlogram.do
do correlogram_means.do
do timeline.do
do forest_plot.do

* END