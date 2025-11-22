--1.write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.

Select 
    s.[Name] as Salesman,
    c.[Customer_Name] as Customer,
    s.[city] as City
from [dbo].[Salesman$] s
join [dbo].[Customer$] c on s.[city] = c.[City]

--2.write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.

select 
    o.[Order Number],
    o.[Purchase_Amount],
    c.[Customer_Name],
    c.[City]
from [dbo].[Order$] o
join [dbo].[Customer$] c on o.[Customer ID] = c.[Customer_ID]
join [dbo].[Salesman$] s on o.[Salesman_id] = s.[Salesman_id]
where o.[Purchase_Amount] between 500 and 2000

--3.write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission.

Select 
    c.[Customer_Name] as Customer,
    c.[city] as City,
    s.[Name] as Salesman,
    s.[commission]
from [dbo].[Customer$] c
join [dbo].[Salesman$] s on c.[Salesman_ID] = s.[Salesman_id]

--4.write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission.  

Select 
    c.[Customer_Name] as Customer,
    c.[city] as City,
    s.[Name] as Salesman,
    s.[commission]
from [dbo].[Customer$] c
join [dbo].[Salesman$] s on c.[Salesman_ID] = s.[Salesman_id]
where [commission] > 0.12

--5.write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission.  
select 
    c.[Customer_Name] as Customer,
    c.[city] as Customer_City,
    s.[Name] as Salesman,
    s.[city] as Salesman_city,
    s.[commission]
from [dbo].[Customer$] c
join [dbo].[Salesman$] s on c.[Salesman_ID] = s.[Salesman_id]
where s.[commission] > 0.12 and s.[city] != c.[City]

--6.write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission

select 
    o.[Order Number]as ord_no,
    o.[Order Date] as ord_date,
    o.[Purchase_Amount] as purch_amt,
    c.[Customer_Name],
    c.[Grade],
    s.[Name] as Salesman,
    s.[commission] 
from [dbo].[Order$] o
join [dbo].[Customer$] c on o.[Customer ID] = c.[Customer_ID]
join [dbo].[Salesman$] s on o.[Salesman_id] = s.[Salesman_id]

--7.Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned.

select 
    o.[Order Number],
    o.[Order Date],
    o.[Purchase_Amount],
    c.[Customer_Name],
    c.[City],
    c.[Grade],
    s.[Name] as Salesman,
    s.[commission] 
from [dbo].[Order$] o
join [dbo].[Customer$] c on o.[Customer ID] = c.[Customer_ID]
join [dbo].[Salesman$] s on o.[Salesman_id] = s.[Salesman_id]

--8.write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.

select 
    c.[Customer_Name] as Customer,
    c.[city] as Customer_City,
    c.[Grade],
    s.[Name] as Salesman,
    s.[city] as Salesman_city
from [dbo].[Customer$] c
join [dbo].[Salesman$] s on c.[Salesman_ID] = s.[Salesman_id]
order by c.[Customer_ID]

--9.write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity. The result should be ordered by ascending customer_id.

select 
    c.[Customer_Name] as cust_name,
    c.[city] as [customer city],
    c.[Grade],
    s.[Name] as Salesman,
    s.[city] as [Salesman city]
from [dbo].[Customer$] c
join [dbo].[Salesman$] s on c.[Salesman_ID] = s.[Salesman_id]
where c.[Grade] < 300
order by c.[Customer_ID]

--10.Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to determine whether any of the existing customers have placed an order or not.

select 
    c.[Customer_Name],
    c.[City],
    o.[Order Number],
    o.[Order Date],
    o.[Purchase_Amount] as [order amount] 
from [dbo].[Customer$] c
left join [dbo].[Order$] o on c.[Customer_ID] = o.[Customer ID]
order by o.[Order Date]

--11.SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission to determine if any of the existing customers have not placed orders or if they have placed orders through their salesman or by themselves.

select 
    c.[Customer_Name],
    c.[City],
    o.[Order Number],
    o.[Order Date],
    o.[Purchase_Amount] as [order amount],
    s.[Name] as Salesman,
    s.[commission], 
     case 
        when o.[Order Number] is null then 'No Orders Placed'
        when s.[Salesman_id] is not null then 'Order through Salesperson'
        else 'Order without Salesperson'
    end as "Order Type"
from [dbo].[Customer$] c
left join [dbo].[Order$] o on c.[Customer_ID] = o.[Customer ID]
left join [dbo].[Salesman$] s on c.[Salesman_ID] = s.[Salesman_id]
order by o.[Order Date]

--12.Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers or have not yet joined any of the customers.

select
    s.[Salesman_id],
    s.[Name] as [Salesperson Name],
    s.[city] as [Salesperson City],
    s.[commission],
    count(c.[Customer_ID]) as [Number of Customers],
    case 
        when count(c.customer_id) = 0 then 'No Customers Assigned'
        else 'Has Customers'
    end as [Status]
from [dbo].[Salesman$] s
left join [dbo].[Customer$] c on s.[Salesman_id] = c.[Salesman_ID]
group by s.[Salesman_id], s.[Name], s.[city], s.[commission]
order by s.[Name]

--13.write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.

select 
    s.[Name] as [Salesman Name],
    c.[Customer_Name],
    c.[City] as [Customer City],
    c.[Grade],
    o.[Order Number],
    o.[Order Date] as [Order Date],
    o.[Purchase_Amount] as [Order Amount]
from [dbo].[Salesman$] s
left join [dbo].[Customer$] c on s.salesman_id = c.salesman_id
left join [dbo].[Order$] o on c.[Customer_ID]= o.[Customer ID]
order by
    s.[Name], c.[Customer_Name]

--14.Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.
select 
    s.[Salesman_id],
    s.[Name] as [Salesperson Name],
    s.[city] as [Salesperson City],
    s.[commission],
    c.[Customer_Name],
    c.[Grade],
    o.[Order Number],
    o.[Purchase_Amount] as [Order Amount]
from [dbo].[Salesman$] s
left join [dbo].[Customer$] c on s.salesman_id = c.salesman_id
left join [dbo].[Order$] o on c.[Customer_ID]= o.[Customer ID]
where 
(
        -- Customers with grade who have placed orders ≥ 2000
        (c.[Grade] is not null and  o.[Purchase_Amount] >= 2000)
        -- OR Customers who have not placed any orders
        or (o.[Order Number] is null)
        -- OR Salesmen with no customers
        or ( c.[Customer_ID] is null)
    )
order by
 [Salesperson Name]
    
--15.For those customers from the existing list who put one or more orders, or which orders have been placed by the customer who is not on the list, create a report containing the customer name, city, order number, order date, and purchase amount

select 
    coalesce(c.[Customer_Name], 'Unknown Name') as [Customer Name],
    coalesce(c.[City], 'Unknown City') as [Customer City],
    o.[Order Number],
    o.[Order Date],
    o.[Purchase_Amount]
from [dbo].[Order$] o
left join [dbo].[Customer$] c on o.[Customer ID] = c.[Customer_ID]
where
    c.[Customer_ID] is not null     -- existing customers with orders
    or c.[Customer_ID] is null      -- orders by customers not on the list
order by 
    o.[Order Date]

--16.Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.

select 
    coalesce(c.[Customer_Name], 'Unknown Name') as [Customer Name],
    coalesce(c.[City], 'Unknown City') as [Customer City],
    o.[Order Number],
    o.[Order Date],
    o.[Purchase_Amount]
from [dbo].[Order$] o
left join [dbo].[Customer$] c on o.[Customer ID] = c.[Customer_ID]
where (
    (c.[Customer_ID] is not null and c.[Grade] is not null)   --customers with at least one order and a grade
    or (c.[Customer_ID] is null and c.[Grade] is null)     -- orders by customers not on the list or with no grade
    )
order by 
    o.[Order Date]    
   
--17.Write a SQL query to combine each row of the salesman table with each row of the customer table.
 select 
    s.Salesman_ID,
    s.Name as [Salesman Name],
    s.City as [Salesman City],
    s.Commission,
    c.Customer_ID,
    c.Customer_Name as [Customer Name],
    c.City as [Customer City],
    c.Grade
from [dbo].[Salesman$] s
cross join [dbo].[Customer$] c
order by s.Salesman_ID, c.Customer_ID

--18.Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for all customers and vice versa for that salesperson who belongs to that city.

select
    s.Salesman_ID,
    s.Name as [Salesman Name],
    c.Customer_ID,
    c.Customer_Name,
    s.City as [Shared City]
from [dbo].[Salesman$] s
cross join [dbo].[Customer$] c
where s.City = c.City
order by s.City, s.Name, c.Customer_Name

--19.Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for every customer and vice versa for those salesmen who belong to a city and customers who require a grade.
select 
    s.Salesman_ID,
    s.Name as [Salesman Name],
    s.City as [Salesman City],
    c.Customer_ID,
    c.Customer_Name as [Customer Name],
    c.City as [Customer City],
    c.Grade
from [dbo].[Salesman$] s
cross join [dbo].[Customer$] c
where s.City is not null 
  and c.Grade is not null
order by s.Name, c.Customer_Name

--20.Write a SQL statement to make a Cartesian product between salesman and customer i.e. each salesman will appear for all customers and vice versa for those salesmen who must belong to a city which is not the same as his customer and the customers should have their own grade.

select 
    s.Salesman_ID,
    s.Name as [Salesman Name],
    s.City as [Salesman City],
    c.Customer_ID,
    c.Customer_Name,
    c.City as [Customer City],
    c.Grade 
from [dbo].[Salesman$] s
cross join [dbo].[Customer$] c
where s.City is not null 
  and c.City is not null
  and s.City != c.City
  and c.Grade is not null
order by s.Name, c.Customer_Name
