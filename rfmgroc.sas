data pgd;
set work.panelgrocdemo;
run;

proc print data = pgd(obs=10);
run;

proc sql;
create table pgd1
as select *
	from pgd
	group by panid;	
quit;

proc print data = pgd1(obs=10);
run;

proc sql;
create table pgd2
as select 
	*,
	sum(dollars) as mon,
	sum(units) as freq,
	max(week) as rec
	from pgd1
	group by panid;
quit;

proc print data = pgd2;
run;

proc rank data = pgd2 out = pgd3 ties = low descending groups = 5;
var rec;
ranks R;
run;

proc rank data = pgd3 out = rfmgroc ties = low groups = 5;
var freq mon;
ranks f m;
run;

data rfmgrocout;
set rfmgroc;
R+1;
f+1;
m+1;
rfmvar = cats( r,f,m)+0;
run;

proc print data = rfmgrocout(obs=10);
run;

data rfmgrocoutmod;
set work.rfmgrocoutmod;
run;

proc sql;
create table rfmgrocoutuni 
as select
		distinct PANID, Panelist_Type, Combined_Pre_Tax_Income_of_HH, Family_Size, HH_RACE, Type_of_Residential_Possession, Age_Group_Applied_to_Male_HH, Education_Level_Reached_by_Male, Occupation_Code_of_Male_HH, Male_Working_Hour_Code, Age_Group_Applied_to_Female_HH, Education_Level_Reached_by_Femal, Occupation_Code_of_Female_HH, Female_Working_Hour_Code, Number_of_Dogs, Number_of_Cats, Children_Group_Code, Marital_Status, Number_of_TVs_Used_by_HH, Number_of_TVs_Hooked_to_Cable, mon, freq, rec, R, f, m, rfmvar
		from rfmgrocoutmod;
quit;

proc print data = rfmgrocoutuni(obs=10);
run;

proc cluster data = rfmgrocoutuni method = ward outtree = treegroc print = 10 ccc pseudo;
var R f m;
copy panid rfmvar panelist_type combined_pre_tax_income_of_hh family_size hh_race type_of_residential_possession age_group_applied_to_male_hh education_level_reached_by_male occupation_code_of_male_hh male_working_hour_code age_group_applied_to_female_hh education_level_reached_by_femal occupation_code_of_female_hh female_working_hour_code number_of_dogs number_of_cats children_group_code marital_status number_of_tvs_used_by_hh number_of_tvs_hooked_to_cable;
run;

proc print data = treegroc(obs=10);
run;

title 'tree diagram using method = ward';
proc tree data = treegroc out = clusttreegroc nclusters = 7;
id panid;
copy rfmvar panelist_type combined_pre_tax_income_of_hh family_size hh_race type_of_residential_possession age_group_applied_to_male_hh education_level_reached_by_male occupation_code_of_male_hh male_working_hour_code age_group_applied_to_female_hh education_level_reached_by_femal occupation_code_of_female_hh female_working_hour_code number_of_dogs number_of_cats children_group_code marital_status number_of_tvs_used_by_hh number_of_tvs_hooked_to_cable;
run;

proc print data = clusttreegroc(obs=10);
run;

proc fastclus data = rfmd out = rfmkmeans maxclusters = 6;
var r f m;
run;


