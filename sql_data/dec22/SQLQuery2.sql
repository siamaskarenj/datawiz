SELECT*
FROM EMPLOYEESALARY


SELECT EMPLOYEEID,JOBTITLE,SALARY
FROM EMPLOYEESALARY
WHERE EMPLOYEEID IN (
          SELECT EMPLOYEEID
		  FROM EMPLOYEE
		  WHERE AGE >30)