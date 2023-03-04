select * from census1..Data1


select*from census1..Data2

select * from census1.dbo.Data1;

select * from census1.dbo.Data2

---number of rows present our dataset

select count(*) from census1..Data1

select count(*) from census1..Data2

--dataset for jharkhand and bihar

select * from census1..Data1 where State in('jharkhand','Bihar')

---population of India

select sum (population)as population from census1..Data2

---average growth statewise(agregate function)

select state, avg(growth)*100 as avg_growth from census1..Data1  group by state;



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
drop table  if exists #topstates;
create table #topstates
( state nvarchar(255),
topstate float
)
insert into #topstates
select state ,round( avg(Literacy),0) avgliteracy_ratio from census1..Data1 
group by state order by avgliteracy_ratio desc

select top 3* from #topstates order by #topstates.topstate desc

----- lowest 3 state literacy rate
drop table  if exists #bottomstates;
create table #bottomstates
( state nvarchar(255),
bottomstate float
)
insert into #bottomstates
select state ,round( avg(Literacy),0) avgliteracy_ratio from census1..Data1 
group by state order by avgliteracy_ratio asc

select top 3* from #bottomstates order by #bottomstates.bottomstate desc


----union operator to combine the literacy rate
select * from(
select top 3* from #topstates order by #topstates.topstate desc)a
union
select * from(
select top 3* from #bottomstates order by #bottomstates.bottomstate asc)b

----states startin with letter a
select distinct state from census1..Data1 where lower(state) like 'a%' or lower(state) like 'b%'

select distinct state from census1..Data1 where lower(state) like 'a%' and lower(state) like '%d'

-----joining both the table(inner join)(we also have given allies)

select a.district,a.state,a.Sex_Ratio/1000,b.population from census1..Data1 a inner join census1..Data2 b on a. District=b.District

--to calculate the nos of female and male
-----f/m=sex_ratio---1
-----f+m=population--2
----f=population-males----3
----(population-males)=(sex_ratio)*males
---population=males(sex_ratio+1)
---males=population/(sex_ratio+1)

---from equation 3
---female=population-population/(sex_ratio+1)
   -------=population(1-1/(sex_ratio+1)
   -------=population*(sex_ratio))/(sex_ratio+1)

   select d.state,sum(d.males) total_males,sum(d.females) total_females from
(select c.district,c.state state,round(c.population/(c.sex_ratio+1),0) males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females from
(select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from census1..data1 a inner join census1..data2 b on a.district=b.district ) c) d
group by d.state;

----total literacy rate
select c.state,sum(literate_people) total_literate_pop, sum(illiterate_people) total_illiterate_pop from
(select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people,
round((1-d.literacy_ratio)* d.population,0) illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population from census1..data1 a
inner join census1..data2 b on a.district=b.district) d) c
group by c.state

----population in previous_census
select sum(m.previous_census) total_previous_census_population,sum(m.current_population)total_current_population from(
select c. state,sum(c.previous_census) previous_census,sum(c.current_census_population)current_population from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census,round(d.population,0)  current_census_population from
(select a.district,a.state,a.growth growth ,b.population from census1..Data1 a inner join census1..Data2 b on a.district=b.district) d) c
group by c.state) m


---population vs  area


select sum(m.previous_census) total_previous_census_population,sum(m.current_population)total_current_population from(
select c. state,sum(c.previous_census) previous_census,sum(c.current_census_population)current_population from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census,round(d.population,0)  current_census_population from
(select a.district,a.state,a.growth growth ,b.population from census1..Data1 a inner join census1..Data2 b on a.district=b.district) d) c
group by c.state) m

---population vs area
select (g.total_area/g.total_previous_census_population)as previous_census_population_vs_area,(g.total_area/g.total_current_population) as current_census_population_vs_area from
(select q.*,r.total_area from(
select '1' as keyy ,n.*from
(select sum(m.previous_census) total_previous_census_population,sum(m.current_population)total_current_population from(
select c. state,sum(c.previous_census) previous_census,sum(c.current_census_population)current_population from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census,round(d.population,0)  current_census_population from
(select a.district,a.state,a.growth growth ,b.population from census1..Data1 a inner join census1..Data2 b on a.district=b.district) d) c
group by c.state) m) n) q inner join (

select '1' as keyy ,z.*from (
select sum(area_km2) total_area from census1..data2) z)r on q.keyy=r.keyy) g

-----window

output top 3 districts from each state with highest literacy rate

select a.*from
(select district,state,literacy,rank()over(partition by state order by literacy desc) rnk from census1 ..data1) a

where a.rnk in(1,2,3) order by state





