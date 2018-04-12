data pcd;
set work.prodcoffeedrug;
run;

proc print data = pcd(obs=10);
run;

proc sql;
select brand_of_coffee, sum(dollars) from pcd group by brand_of_coffee order by 2 desc;
run;

data pcd1;
set pcd;
if brand_of_coffee = "FOLGERS" or brand_of_coffee = "MAXWELL HOUSE" or brand_of_coffee ="YUBAN" or brand_of_coffee = "CHOCK FULL O NUTS" or brand_of_coffee = "PRIVATE LABEL";
run;

proc print data = pcd1(obs=10);
run;

data pcd2(keep = IRI_KEY WEEK DOLLARS UNITS F D PR brand_of_coffee up) ;
set pcd1;
up = dollars/units;
run;

proc print data = pcd2(obs=10);
run;

data pcd3;
set pcd2;
if brand_of_coffee = "FOLGERS" then br = 1;
if brand_of_coffee = "MAXWELL HOUSE" then br = 2;
if brand_of_coffee = "YUBAN" then br =3;
if brand_of_coffee = "CHOCK FULL O NUTS" then br = 4;
if brand_of_coffee = "PRIVATE LABEL" then br = 5;
run;

proc print data = pcd3(obs=10);
run;

proc sql;
select * from pcd3 where br = 5;
quit;

data pcd4;
set pcd3;
if f = "NONE" then feature = 0;
else feature = 1;
if d > 0 then display = 1;
else display = 0;
run;

proc print data = pcd4(obs=10);
run;

proc sql;
select * from pcd4 where br = 5;
quit;

proc sql;                                                                                                                                                                                                                                                       
create table df as                                                                                                                                                                                                                                              
select iri_key, week, br, sum(feature) as total_fe, sum(display) as total_di,sum(pr) as pf,sum(dollars)/sum(UNITS) as price from pcd4 group by iri_key,week,br;                                                                                                          
quit;
 
proc print data = df;
run;

proc sql;
select * from df where br = 5;
quit;

data df1;                                                                                                                                                                                                                                                        
set df;                                                                                                                                                                                                                                                         
if br=1 and total_fe>0 then f1=1;else f1=0;                                                                                                                                                                                                                     
if br=2 and total_fe>0 then f2=1;else f2=0;                                                                                                                                                                                                                     
if br=3 and total_fe>0 then f3=1;else f3=0;                                                                                                                                                                                                                     
if br=4 and total_fe>0 then f4=1;else f4=0;                                                                                                                                                                                                                     
if br=5 and total_fe>0 then f5=1;else f5 =0;
if br=1 and total_di>0 then d1=1;else d1=0;                                                                                                                                                                                                                     
if br=2 and total_di>0 then d2=1;else d2=0;                                                                                                                                                                                                                     
if br=3 and total_di>0 then d3=1;else d3=0;                                                                                                                                                                                                                     
if br=4 and total_di>0 then d4=1;else d4=0;                                                                                                                                                                                                                     
if br=5 and total_di>0 then d5=1;else d5=0;
if br=1 and pf>0 then pf1=1;else pf1=0;                                                                                                                                                                                                                         
if br=2 and pf>0 then pf2=1;else pf2=0;                                                                                                                                                                                                                         
if br=3 and pf>0 then pf3=1;else pf3=0;                                                                                                                                                                                                                         
if br=4 and pf>0 then pf4=1;else pf4=0;    
if br=5 and pf>0 then pf5=1;else pf5=0; 
if br=1 then pr1=price;else pr1=0;                                                                                                                                                                                                                              
if br=2 then pr2=price;else pr2=0;                                                                                                                                                                                                                              
if br=3 then pr3=price;else pr3=0;                                                                                                                                                                                                                              
if br=4 then pr4=price;else pr4=0;     
if br=5 then pr5=price;else pr5=0; 
run;     

proc sql;
select * from df1 where br = 5;
quit;
 
proc sql;                                                                                                                                                                                                                                                       
create table df2 as                                                                                                                                                                                                                                               
select iri_key,week, br,                                                                                                                                                                                                                                            
sum(f1) as fe1,sum(f2) as fe2,sum(f3) as fe3,sum(f4) as fe4, sum(f5) as fe5,sum(d1) as di1,sum(d2) as di2,sum(d3) as di3,sum(d4) as di4, sum(d5) as di5,sum(pf1) as p1,sum(pf2) as p2,sum(pf3) as p3,sum(pf4) as p4,sum(pf5) as p5,SUM(pr1) as pri1,SUM(pr2) as pri2,SUM(pr3) as pri3,SUM(pr4) as pri4 ,sum(pr5) as pri5 from df1
group by iri_key,week;                                                                                                                                                                                                                                          
quit;                                                                                                                                      

DATA df3;                                                                                                                                                                                                                                                    
SET df2;                                                                                                                                                                                                                                                    
KEEP WEEK IRI_KEY BR fe1 fe2 fe3 fe4 fe5 di1 di2 di3 di4 di5 p1 p2 p3 p4 p5 pri1 pri2 pri3 pri4 pri5;                                                                                                                                     
run;                                                                                                                                                                                                                                                            

proc print data = df3(obs=10);
run;

data df4 (keep= pid decision Brand Pr Di Ft Pf ) ;                                                                                                                                                                               
set df3;                                                                                                                                                                                                                                                     
array Pvec{5} P1-P5;                                                                                                                                                                                                                                            
array Dvec{5} Di1-Di5;                                                                                                                                                                                                                                          
array Fvec{5} Fe1-Fe5;                                                                                                                                                                                                                                          
array Privec{5} Pri1-Pri5;                                                                                                                                                                                                                                      
retain pid 0;                                                                                                                                                                                                                                                   
pid+1;                                                                                                                                                                                                                                                          
do i=1 to 5;                                                                                                                                                                                                                                                    
Brand=i;                                                                                                                                                                                                                                                        
Pf=Pvec{i};                                                                                                                                                                                                                                                     
Di=Dvec{i};                                                                                                                                                                                                                                                     
Ft=Fvec{i};                                                                                                                                                                                                                                                     
Pr=Privec{i};                                                                                                                                                                                                                                                   
decision = (BR=i);                                                                                                                                                                                                                                               
output;                                                                                                                                                                                                                                                         
end;                                                                                                                                                                                                                                                            
run;

proc print data = df4(obs=10);
run;

data df5;                                                                                                                                                                                                                                                       
set df4;                                                                                                                                                                                                                                                         
if Brand=0 then Br1=1;                                                                                                                                                                                                                                          
else Br1=0;                                                                                                                                                                                                                                                     
if Brand=2 then Br2=1;                                                                                                                                                                                                                                          
else Br2=0;                                                                                                                                                                                                                                                     
if Brand=3 then Br3=1;                                                                                                                                                                                                                                          
else Br3=0;
if brand =4 then br4 =1;
else br4=0; 
if brand =5 then br5=1;
else br5=0;
run; 

proc print data = df5(obs=10);
run;

proc mdc data=df5 outest=est;                                                                                                                                                                                                                                   
model decision=Pr Pf Di Ft /type=clogit nchoice=5 optmethod=qn covest=hess;                                                                                                                                                 
id pid;                                                                                                                                                                                                                                                         
run;
