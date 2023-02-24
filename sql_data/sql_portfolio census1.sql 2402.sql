select * from census1..Data1

---avg sex ratio aggregate function
select state ,round( avg(Sex_Ratio),0 )as avgSex_Ratio From census1..Data1 group by state order by avgSex_Ratio desc

select state ,round( avg(literacy),0 )as avgliteracy_Ratio From census1..Data1 group by state order by avgliteracy_Ratio desc
