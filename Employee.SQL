--Delete the last empty row from the table

with LastRow as (
    select top 1 *
    from [dbo].['Employee Info$']
    order by [EmpID] DESC
)
delete from LastRow;

--1.Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.

select UPPER([EmpFname]) as EmpName
from [dbo].['Employee Info$']

--2.Write a query to fetch the number of employees working in the department ‘HR’.

select  count(*) as HR_employees
from [dbo].['Employee Info$']
where [Department] = 'HR'

--3.Write a query to get the current date.
Select GETDATE() as CurrentDate

--4.Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.

select 
    LEFT([EmpLname], 4) as First4_Character
from [dbo].['Employee Info$']

--5.Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

select  
      LTRIM(RTRIM(SUBSTRING([Address], 1, CHARINDEX('(',[Address] ) - 1))) AS PlaceName
from [dbo].['Employee Info$']

--6.Write a query to create a new table that consists of data and structure copied from the other table.

select *
into NewEmployeeInfo
from [dbo].['Employee Info$']

--7.Write q query to find all the employees whose salary is between 50000 to 100000.

select
    E.[EmpID],
    E.[EmpFname],
    E.[EmpLname],
    S.[Salary]
from [dbo].['Employee Info$'] E
inner join [dbo].['Employee position$'] S
           on E.[EmpID] = S.[EmpID]
where 
    S.[Salary] BETWEEN 50000 AND 100000

--8.Write a query to find the names of employees that begin with ‘S’

select [EmpFname],[EmpLname]
from [dbo].['Employee Info$']
where [EmpFname] like 'S%'

--9.Write a query to fetch top N records.

select top 3 *
from [dbo].['Employee Info$']

--10.Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.

select [EmpFname] + ' ' + [EmpLname] as [Full Name]
from [dbo].['Employee Info$']

--11.Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1995 and are grouped according to gender

select [Gender],count(*) as Gender_count 
from [dbo].['Employee Info$']
where [DOB] between '1970/05/02' and '1995/12/31'
group by rollup([Gender])

--12.Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.

select *
from [dbo].['Employee Info$']
order by [EmpLname]desc,[Department]

--13.Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.

select *
from [dbo].['Employee Info$']
where [EmpLname] like '%____A'

--14.Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.

select *
from [dbo].['Employee Info$']
where [EmpFname] not in ('sanjay','sonia')

--15.Write a query to fetch details of employees with the address as “DELHI(DEL)”

select *
from [dbo].['Employee Info$']
where [Address] = 'DELHI(DEL)'

--16.Write a query to fetch all employees who also hold the managerial position.

select e.*
from [dbo].['Employee Info$'] e
 join  [dbo].['Employee position$'] p
    on e.[EmpID]= p.[EmpID]
where  p.[EmpPosition]= 'Manager'

--17.Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order

select [Department],count(*) as Department_Count
from [dbo].['Employee Info$']
group by [Department]
order by Department_Count

--18.Write a query to fetch Male employees in HR department

select *
from [dbo].['Employee Info$']
where [Gender] = 'M' and [Department] = 'HR'

--19.Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table

select e.[EmpFname],e.[EmpLname],e.[Department], p.[DateOfJoining]
from [dbo].['Employee Info$'] e
join [dbo].['Employee position$'] p
    ON e.[EmpID] = p.[EmpID];

--20.Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table

Select * 
from (select top 2 [Salary], 'Minimum' as SalaryType
      from [dbo].['Employee position$']
      order by [Salary]
     ) as MinSalaries

union all

select * from (select top 2 [Salary],  'Maximum' AS SalaryType
    from [dbo].['Employee position$']
    order by [Salary] desc
)  as MaxSalaries;
 


