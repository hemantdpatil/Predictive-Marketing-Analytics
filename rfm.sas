data pdd (drop = _ VAR47 VAR48);
set work.paneldrugdemo;
run;

proc print data = pdd(obs=10);
run;

proc sort data = pdd;
by week;
run;

proc sql;
create table pdd1
as select panid, week, units, dollars
	from pdd
	group by panid;	
quit;

proc print data = pdd1(obs=10);
run;

proc sql;
create table pdd2
as select 
	panid,
	sum(dollars) as mon,
	sum(units) as freq,
	max(week) as rec
	from pdd1
	group by panid;
quit;

proc print data = pdd2;
run;

proc rank data = pdd2 out = pdd3 ties = low descending groups = 5;
var rec;
ranks R;
run;

proc rank data = pdd3 out = rfm ties = low groups = 5;
var freq mon;
ranks f m;
run;

data rfmout;
set rfm;
R+1;
f+1;
m+1;
rfmvar = cats( r,f,m)+0;
run;

proc print data = rfmout;
run;

data rfmd;
set work.rfmd;
run;

proc print data = rfmd(obs=10);
run;

proc cluster data = rfmd method = ward outtree = tree print = 10 ccc pseudo;
var R f m;
copy panid rfmvar panelist_type combined_pre_tax_income_of_hh family_size hh_race type_of_residential_possession age_group_applied_to_male_hh education_level_reached_by_male occupation_code_of_male_hh male_working_hour_code male_smoke age_group_applied_to_female_hh education_level_reached_by_femal occupation_code_of_female_hh female_working_hour_code fem_smoke number_of_dogs number_of_cats children_group_code marital_status number_of_tvs_used_by_hh number_of_tvs_hooked_to_cable;
run;

proc print data = tree(obs=10);
run;

title 'tree diagram using method = ward';
proc tree data = tree out = clusttree nclusters = 3;
id panid;
copy rfmvar panelist_type combined_pre_tax_income_of_hh family_size hh_race type_of_residential_possession age_group_applied_to_male_hh education_level_reached_by_male occupation_code_of_male_hh male_working_hour_code male_smoke age_group_applied_to_female_hh education_level_reached_by_femal occupation_code_of_female_hh female_working_hour_code fem_smoke number_of_dogs number_of_cats children_group_code marital_status number_of_tvs_used_by_hh number_of_tvs_hooked_to_cable;
run;

proc print data = clusttree(obs=10);
run;

proc fastclus data = rfmd out = rfmkmeans maxclusters = 6;
var r f m;
run;


/*


proc candisc out = can;
var panid r f m panelist_type combined_pre_tax_income_of_hh family_size hh_race type_of_residential_possession age_group_applied_to_male_hh education_level_reached_by_male occupation_code_of_male_hh male_working_hour_code male_smoke age_group_applied_to_female_hh education_level_reached_by_femal occupation_code_of_female_hh female_working_hour_code fem_smoke number_of_dogs number_of_cats children_group_code marital_status language number_of_tvs_used_by_hh number_of_tvs_hooked_to_cable;
class cluster;
run;

proc plot;
plot can9 *can8*can7*can6*can5*can4*can3*can2*can1 = clst;
run;

*/

