select * from census1..Data1

---avg sex ratio aggregate function
select state ,round( avg(Sex_Ratio),0 )as avgSex_Ratio From census1..Data1 group by state order by avgSex_Ratio desc

select state ,round( avg(literacy),0 )as avgliteracy_Ratio From census1..Data1 group by state order by avgliteracy_Ratio desc

select state ,round( avg(literacy),0 )as avgliteracy_Ratio From census1..Data1 group by state having round(avg(literacy),0)>90 order by avgliteracy_Ratio desc

----top 3 state showing highest growth ratio(by using top function)

select top 3 state, avg(growth)*100 avg_growth from census1..Data1 group by state order by avg_growth desc
----- the same can be done by  limit function
select state, avg(growth)*100 avg_growth from census1..Data1 group by state order by avg_growth desc limit 2;

-- to calculate bottom or lowest growth rate
select top 3 state,round (avg(sex_ratio),0)avg_sex_ratio from census1..Data1 group by state order by avg_sex_ratio asc 

- -------to display the top and the lowest in one table literacy state










