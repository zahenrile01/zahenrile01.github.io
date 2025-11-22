--1.How many incidents occurred at each plant?

select Plant, count(*) as Incident_Count
from [dbo].['Workplace Safety Data$']
group by Plant

--2.What is the total incident cost per department?

select Department, sum([Incident Cost]) as Total_Cost_Per_Department
from [dbo].['Workplace Safety Data$']
group by Department

--3.Which incident type resulted in the highest total days lost?

select top 1 [Incident Type],sum([Days Lost]) as Total_Days_Lost
from [dbo].['Workplace Safety Data$']
group by [Incident Type]
order by Total_Days_Lost desc

--OR Rank all

select [Incident Type],
    sum([Days Lost]) AS Total_Days_Lost,
    rank() OVER (ORDER BY SUM([Days Lost]) DESC) as rank
from [dbo].['Workplace Safety Data$']
group by [Incident Type]
order by  Total_Days_Lost desc

--4.What is the distribution of incident types by shift?

select [Shift],[Incident Type] , count(*) as Incident_count
from [dbo].['Workplace Safety Data$']
group by [Shift],[Incident Type]
order by [Shift],[Incident Type]

--5.What is the average incident cost for each injury location?

select [Injury Location],avg([Incident Cost]) as Average_Location_Cost
from [dbo].['Workplace Safety Data$']
group by [Injury Location] 
order by Average_Location_Cost desc

--6.Which age group has the highest number of incidents?

select top 1 [Age Group],count(*) as Incident_Count
from [dbo].['Workplace Safety Data$']
group by [Age Group] 
order by Incident_Count desc

--7.How many incidents were reported as 'Lost Time' by each plant?

select Plant,count(*) as LostTime_Report
from [dbo].['Workplace Safety Data$']
where [Report Type] = 'Lost Time'
group by [Plant]
order by LostTime_Report desc

--8.Which department had the highest number of 'Crush & Pinch' incidents?

select top 1 Department,count(*) as  Hightest_Crush$Pinch
from [dbo].['Workplace Safety Data$']
where [Incident Type] = 'Crush & Pinch'
group by Department
order by Hightest_Crush$Pinch desc

--OR Use CTE

with IncidentCounts as (
    select
        Department,
        count(*) AS Hightest_Crush$Pinch,
        rank() OVER (ORDER BY COUNT(*) DESC) as incident_rank
    from [dbo].['Workplace Safety Data$']
    where [Incident Type] = 'Crush & Pinch'
    group by Department
)
select
    Department,
    Hightest_Crush$Pinch
from IncidentCounts
where  incident_rank = 1;

--9.Which plants reported the most "Near Miss" incidents?

Select top 1 Plant,count(*) as NearMiss_Report
from [dbo].['Workplace Safety Data$']
where [Report Type] = 'Near Miss'
group by [Plant]
order by NearMiss_Report desc

--10.What is the total number of incidents by year and month?

select [Year], [Month],count(*) as Total_Incidents
from [dbo].['Workplace Safety Data$']
group by [Year], [Month]
order by [Year], [Month] 

--11.Which gender has the most reported incidents?

select Top 1 Gender,count(*) as  Most_Incident
from [dbo].['Workplace Safety Data$']
group by Gender
order by Most_Incident desc

--12.What is the total cost of incidents per year?

select Year,sum([Incident Cost]) as  Total_Cost
from [dbo].['Workplace Safety Data$']
group by Year

--13.Which incident resulted in the highest cost?

select top 1 [Incident Type],sum([Incident Cost]) as  Highest_Cost
from [dbo].['Workplace Safety Data$']
group by [Incident Type]
order by Highest_Cost desc

--14.What is the total cost of incidents for each report type?
select [Report Type],sum([Incident Cost]) as  Total_Cost
from [dbo].['Workplace Safety Data$']
group by [Report Type]
order by Total_Cost desc

--15.Which departments had incidents with more than 2 days lost?

select distinct Department 
from [dbo].['Workplace Safety Data$']
where [Days Lost] >2 
group by Department

--16.What is the average number of days lost per incident type?

select [Incident Type],round(avg([Days Lost]),2) as  Average_Days_Lost
from [dbo].['Workplace Safety Data$']
group by [Incident Type]
order by Average_Days_Lost desc

--17.Which months have the highest number of incidents?
select Top 5 [Month],count(*) as  Incident_Number
from [dbo].['Workplace Safety Data$']
group by [Month]
order by Incident_Number desc

--18.What is the total cost of "Vehicle" related incidents?

select [Incident Type] ,sum([Incident Cost]) as  Total_Cost
from [dbo].['Workplace Safety Data$']
where [Incident Type] = 'Vehicle'
group by [Incident Type]

--19.Which age group is most affected by "Falling Object" incidents?

Select Top 1 [Age Group] ,count([Incident Type]) as  Total_Incident
from [dbo].['Workplace Safety Data$']
where [Incident Type] = 'Falling Object'
group by [Age Group]
order by Total_Incident desc
