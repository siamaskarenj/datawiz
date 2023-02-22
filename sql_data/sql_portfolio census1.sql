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
