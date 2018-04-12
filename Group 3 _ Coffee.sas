PROC IMPORT OUT= WORK.PR2 
            DATAFILE= "H:\SAS\coffee_drug & Delivery Store.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data a1; set work.pr2;
run;

proc print data=a1 (obs=10); run;

data a2; set a1;
if F="A+" then highest_feature=1; else highest_feature=0;
if F="A" then High_feature=1; else High_feature=0;
if F="B" then Medium_feature=1; else Medium_feature=0;
if F="C" then Low_feature=1; else Low_feature=0;
if F="NONE" then No_feature=1; else No_feature=0;
if D=0 then no_display=1; else no_display=0;
if D=1 then low_display=1; else low_display=0;
if D=2 then high_display=1; else high_display=0;
if Market_Name="ATLANTA" then ATLANTA=1; else ATLANTA=0;
if Market_Name="BUFFALO/ROCHESTER" then BUFFALO_ROCHESTER=1; else BUFFALO_ROCHESTER=0;
if Market_Name="MILWAUKEE" then MILWAUKEE=1; else MILWAUKEE=0;
if Market_Name="PEORIA/SPRINGFLD." then PEORIA_SPRINGFLD=1; else PEORIA_SPRINGFLD=0;
if Market_Name="OKLAHOMA CITY" then OKLAHOMA_CITY=1; else OKLAHOMA_CITY=0;
if Market_Name="LOS ANGELES" then LOS_ANGELES=1; else LOS_ANGELES=0;
if Market_Name="SAN FRANCISCO" then SAN_FRANCISCO=1; else SAN_FRANCISCO=0;
if Market_Name="PORTLAND,OR" then PORTLAND_OR=1; else PORTLAND_OR=0;
if Market_Name="NEW YORK" then NEW_YORK=1; else NEW_YORK=0;
if Market_Name="WEST TEX/NEW MEX" then WEST_TEX_NEW_MEX=1; else WEST_TEX_NEW_MEX=0;
if Market_Name="BOSTON" then BOSTON=1; else BOSTON=0;
if Market_Name="HOUSTON" then HOUSTON=1; else HOUSTON=0;
if Market_Name="GREEN BAY" then GREEN_BAY=1; else GREEN_BAY=0;
if Market_Name="HARTFORD" then HARTFORD=1; else HARTFORD=0;
if Market_Name="CHARLOTTE" then CHARLOTTE=1; else CHARLOTTE=0;
if Market_Name="SAN DIEGO" then SAN_DIEGO=1; else SAN_DIEGO=0;
if Market_Name="EAU CLAIRE" then EAU_CLAIRE=1; else EAU_CLAIRE=0;
if Market_Name="TULSA,OK" then TULSA_OK=1; else TULSA_OK=0;
if Market_Name="NEW ENGLAND" then NEW_ENGLAND=1; else NEW_ENGLAND=0;
if Market_Name="NEW ORLEANS, LA" then NEW_ORLEANS_LA=1; else NEW_ORLEANS_LA=0;
if Market_Name="SALT LAKE CITY" then SALT_LAKE_CITY=1; else SALT_LAKE_CITY=0;
if Market_Name="OMAHA" then OMAHA=1; else OMAHA=0;
if Market_Name="RICHMOND/NORFOLK" then RICHMOND_NORFOLK=1; else RICHMOND_NORFOLK=0;
if Market_Name="KNOXVILLE" then KNOXVILLE=1; else KNOXVILLE=0;
if Market_Name="SOUTH CAROLINA" then SOUTH_CAROLINA=1; else SOUTH_CAROLINA=0;
if Market_Name="DALLAS, TX" then DALLAS_TX=1; else DALLAS_TX=0;
if Market_Name="ROANOKE" then ROANOKE=1; else ROANOKE=0;
if Market_Name="WASHINGTON, DC" then WASHINGTON_DC=1; else WASHINGTON_DC=0;
if Market_Name="SYRACUSE" then SYRACUSE=1; else SYRACUSE=0;
if Market_Name="RALEIGH/DURHAM" then RALEIGH_DURHAM=1; else RALEIGH_DURHAM=0;
if Market_Name="PHILADELPHIA" then PHILADELPHIA=1; else PHILADELPHIA=0;
if Market_Name="HARRISBURG/SCRANT" then HARRISBURG_SCRANT=1; else HARRISBURG_SCRANT=0;
if Market_Name="SPOKANE" then SPOKANE=1; else SPOKANE=0;
if Market_Name="BIRMINGHAM/MONTG." then BIRMINGHAM_MONTG=1; else BIRMINGHAM_MONTG=0;
if Market_Name="SEATTLE/TACOMA" then SEATTLE_TACOMA=1; else SEATTLE_TACOMA=0;
if Market_Name="TOLEDO" then TOLEDO=1; else TOLEDO=0;
if Market_Name="GRAND RAPIDS" then GRAND_RAPIDS=1; else GRAND_RAPIDS=0;
if Market_Name="MINNEAPOLIS/ST. PAUL" then MINNEAPOLIS_ST_PAUL=1; else MINNEAPOLIS_ST_PAUL=0;
if Market_Name="SACRAMENTO" then SACRAMENTO=1; else SACRAMENTO=0;
if Market_Name="DES MOINES" then DES_MOINES=1; else DES_MOINES=0;
if Market_Name="CLEVELAND" then CLEVELAND=1; else CLEVELAND=0;
if Market_Name="ST. LOUIS" then ST_LOUIS=1; else ST_LOUIS=0;
if Market_Name="PITTSFIELD" then PITTSFIELD=1; else PITTSFIELD=0;
if Market_Name="PHOENIX, AZ" then PHOENIX_AZ=1; else PHOENIX_AZ=0;
if Market_Name="CHICAGO" then CHICAGO=1; else CHICAGO=0;
if Market_Name="DETROIT" then DETROIT=1; else DETROIT=0;
if Market_Name="INDIANAPOLIS" then INDIANAPOLIS=1; else INDIANAPOLIS=0;
if Market_Name="MISSISSIPPI" then MISSISSIPPI=1; else MISSISSIPPI=0;
if Market_Name="PROVIDENCE,RI" then PROVIDENCE_RI=1; else PROVIDENCE_RI=0;
if Market_Name="KANSAS CITY" then KANSAS_CITY=1; else KANSAS_CITY=0;
run;

proc print data=a2 (obs=10);
run;

/* With All Variables of market name (base as Dallas_tx, no_feature, no_display, ) */
proc reg;
model Units= highest_feature High_feature Medium_feature Low_feature low_display high_display ATLANTA NEW_YORK BOSTON HOUSTON HARTFORD TULSA_OK OMAHA ROANOKE SYRACUSE SPOKANE TOLEDO CHICAGO DETROIT PR EST_ACV Open Clsd;
run;
/*-----------------------------------------------------------------XXXXXXXXXX----------------------------------------------------*/
/*Loading Coffee_groc file:-*/
data b1;
infile 'H:\project\coffee_groc_1114_1165' expandtabs firstobs=2;
input IRI_KEY WEEK SY GE VEND ITEM UNITS DOLLARS F $ D PR;
run;

/*Loading Delivery store file:-*/
PROC IMPORT OUT= WORK.B2
            DATAFILE= "H:\Project\Delivery_store.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
proc print data=b2 (obs=10);run;

/*Loading Prod Coffee:-*/
PROC IMPORT OUT= WORK.c1 
            DATAFILE= "H:\Project\prod_coffee.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/*Merging Delivery store and Coffee_groc file:-*/
proc sort data=b1; by IRI_KEY;
proc sort data=b2; by IRI_KEY;
data b4;
merge b1 (IN=aa) b2; If aa; by IRI_KEY; run;
proc print data=b4 (obs=10); run;

/*Creating UPC Code in Merged (Coffee_groc & Delivery_store)*/
data c2;set b4;
upc = catx(SY,GE,VEND,ITEM);run;
proc print data=c2 (obs=10);run;

/*Creating UPC Code in Prod Coffee*/
data c3;set c1;
upc = catx(SY,GE,VEND,ITEM);run;
proc print data=c3 (obs=10);run;

/*Merging Merged(Delivery store and Coffee_groc file) and prod coffee:-*/
proc sort data=c2; by UPC;
proc sort data=c3; by UPC;
data c4;
merge c3 (IN=aa) c2; If aa; by UPC; run;
proc print data=c4 (obs=10);run;

/*Filtering for CHOCK FULL O NUTS*/
proc sql;
create table c5 as select * from c4 where Brand_of_coffee="CHOCK FULL O N";
quit;
proc print data=c5 (obs=10); run;



/*Creating Dummy variables for */
data c6; set c5;
if F="A+" then highest_feature=1; else highest_feature=0;
if F="A" then High_feature=1; else High_feature=0;
if F="B" then Medium_feature=1; else Medium_feature=0;
if F="C" then Low_feature=1; else Low_feature=0;
if F="NONE" then No_feature=1; else No_feature=0;
if D=0 then no_display=1; else no_display=0;
if D=1 then low_display=1; else low_display=0;
if D=2 then high_display=1; else high_display=0;
if Market_Name="ATLANTA" then ATLANTA=1; else ATLANTA=0;
if Market_Name="BUFFALO/ROCHESTER" then BUFFALO_ROCHESTER=1; else BUFFALO_ROCHESTER=0;
if Market_Name="MILWAUKEE" then MILWAUKEE=1; else MILWAUKEE=0;
if Market_Name="PEORIA/SPRINGFLD." then PEORIA_SPRINGFLD=1; else PEORIA_SPRINGFLD=0;
if Market_Name="OKLAHOMA CITY" then OKLAHOMA_CITY=1; else OKLAHOMA_CITY=0;
if Market_Name="LOS ANGELES" then LOS_ANGELES=1; else LOS_ANGELES=0;
if Market_Name="SAN FRANCISCO" then SAN_FRANCISCO=1; else SAN_FRANCISCO=0;
if Market_Name="PORTLAND,OR" then PORTLAND_OR=1; else PORTLAND_OR=0;
if Market_Name="NEW YORK" then NEW_YORK=1; else NEW_YORK=0;
if Market_Name="WEST TEX/NEW MEX" then WEST_TEX_NEW_MEX=1; else WEST_TEX_NEW_MEX=0;
if Market_Name="BOSTON" then BOSTON=1; else BOSTON=0;
if Market_Name="HOUSTON" then HOUSTON=1; else HOUSTON=0;
if Market_Name="GREEN BAY" then GREEN_BAY=1; else GREEN_BAY=0;
if Market_Name="HARTFORD" then HARTFORD=1; else HARTFORD=0;
if Market_Name="CHARLOTTE" then CHARLOTTE=1; else CHARLOTTE=0;
if Market_Name="SAN DIEGO" then SAN_DIEGO=1; else SAN_DIEGO=0;
if Market_Name="EAU CLAIRE" then EAU_CLAIRE=1; else EAU_CLAIRE=0;
if Market_Name="TULSA,OK" then TULSA_OK=1; else TULSA_OK=0;
if Market_Name="NEW ENGLAND" then NEW_ENGLAND=1; else NEW_ENGLAND=0;
if Market_Name="NEW ORLEANS, LA" then NEW_ORLEANS_LA=1; else NEW_ORLEANS_LA=0;
if Market_Name="SALT LAKE CITY" then SALT_LAKE_CITY=1; else SALT_LAKE_CITY=0;
if Market_Name="OMAHA" then OMAHA=1; else OMAHA=0;
if Market_Name="RICHMOND/NORFOLK" then RICHMOND_NORFOLK=1; else RICHMOND_NORFOLK=0;
if Market_Name="KNOXVILLE" then KNOXVILLE=1; else KNOXVILLE=0;
if Market_Name="SOUTH CAROLINA" then SOUTH_CAROLINA=1; else SOUTH_CAROLINA=0;
if Market_Name="DALLAS, TX" then DALLAS_TX=1; else DALLAS_TX=0;
if Market_Name="ROANOKE" then ROANOKE=1; else ROANOKE=0;
if Market_Name="WASHINGTON, DC" then WASHINGTON_DC=1; else WASHINGTON_DC=0;
if Market_Name="SYRACUSE" then SYRACUSE=1; else SYRACUSE=0;
if Market_Name="RALEIGH/DURHAM" then RALEIGH_DURHAM=1; else RALEIGH_DURHAM=0;
if Market_Name="PHILADELPHIA" then PHILADELPHIA=1; else PHILADELPHIA=0;
if Market_Name="HARRISBURG/SCRANT" then HARRISBURG_SCRANT=1; else HARRISBURG_SCRANT=0;
if Market_Name="SPOKANE" then SPOKANE=1; else SPOKANE=0;
if Market_Name="BIRMINGHAM/MONTG." then BIRMINGHAM_MONTG=1; else BIRMINGHAM_MONTG=0;
if Market_Name="SEATTLE/TACOMA" then SEATTLE_TACOMA=1; else SEATTLE_TACOMA=0;
if Market_Name="TOLEDO" then TOLEDO=1; else TOLEDO=0;
if Market_Name="GRAND RAPIDS" then GRAND_RAPIDS=1; else GRAND_RAPIDS=0;
if Market_Name="MINNEAPOLIS/ST. PAUL" then MINNEAPOLIS_ST_PAUL=1; else MINNEAPOLIS_ST_PAUL=0;
if Market_Name="SACRAMENTO" then SACRAMENTO=1; else SACRAMENTO=0;
if Market_Name="DES MOINES" then DES_MOINES=1; else DES_MOINES=0;
if Market_Name="CLEVELAND" then CLEVELAND=1; else CLEVELAND=0;
if Market_Name="ST. LOUIS" then ST_LOUIS=1; else ST_LOUIS=0;
if Market_Name="PITTSFIELD" then PITTSFIELD=1; else PITTSFIELD=0;
if Market_Name="PHOENIX, AZ" then PHOENIX_AZ=1; else PHOENIX_AZ=0;
if Market_Name="CHICAGO" then CHICAGO=1; else CHICAGO=0;
if Market_Name="DETROIT" then DETROIT=1; else DETROIT=0;
if Market_Name="INDIANAPOLIS" then INDIANAPOLIS=1; else INDIANAPOLIS=0;
if Market_Name="MISSISSIPPI" then MISSISSIPPI=1; else MISSISSIPPI=0;
if Market_Name="PROVIDENCE,RI" then PROVIDENCE_RI=1; else PROVIDENCE_RI=0;
if Market_Name="KANSAS CITY" then KANSAS_CITY=1; else KANSAS_CITY=0;
run;

proc print data=c6 (obs=10);run;

/* With All Variables of market name (base as Dallas_tx, no_feature, no_display) */
proc reg;
model Dollars= highest_feature High_feature Medium_feature Low_feature low_display high_display ATLANTA BUFFALO_ROCHESTER MILWAUKEE PEORIA_SPRINGFLD OKLAHOMA_CITY LOS_ANGELES SAN_FRANCISCO PORTLAND_OR NEW_YORK WEST_TEX_NEW_MEX BOSTON HOUSTON GREEN_BAY HARTFORD CHARLOTTE SAN_DIEGO EAU_CLAIRE TULSA_OK NEW_ENGLAND NEW_ORLEANS_LA SALT_LAKE_CITY OMAHA RICHMOND_NORFOLK KNOXVILLE SOUTH_CAROLINA ROANOKE WASHINGTON_DC SYRACUSE RALEIGH_DURHAM PHILADELPHIA HARRISBURG_SCRANT SPOKANE BIRMINGHAM_MONTG SEATTLE_TACOMA TOLEDO GRAND_RAPIDS MINNEAPOLIS_ST_PAUL SACRAMENTO DES_MOINES CLEVELAND ST_LOUIS PITTSFIELD PHOENIX_AZ CHICAGO DETROIT INDIANAPOLIS MISSISSIPPI PROVIDENCE_RI KANSAS_CITY PR EST_ACV Open Clsd;
run;
