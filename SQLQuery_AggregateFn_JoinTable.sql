# -*- coding: utf-8 -*-
--µÑÇÍÂèÒ§ÇÑ¹¹Õéãªé°Ò¹¢éÍÁÙÅ Northwind
--Calculate Column ¤ÍÅÑÁ¹ì·Õèà¡Ô´¨Ò¡¡ÒÃ¤Ó¹Ç³

--¨§áÊ´§ª×èÍàµçÁ¢Í§¾¹Ñ¡§Ò¹·Ø¡¤¹   --Alias Name µÑé§à»ç¹ª×èÍ¢Öé¹ÁÒãËÁè
Select EmployeeID,TitleOfCourtesy+FirstName+' '+LastName [Employee Name]
from Employees
Select EmployeeID,[Employee Name] = TitleOfCourtesy+FirstName+' '+LastName
from Employees

--¨§áÊ´§¢éÍÁÙÅÊÔ¹¤éÒ·ÕèÁÕ¨Ó¹Ç¹ã¹ÊµêÍ¡(UnitsInStock)µèÓ¡ÇèÒ¨Ó¹Ç¹·ÕèµéÍ§ÊÑè§«×éÍ(ReorderLevel)
Select productID,productName,UnitsInStock, ReorderLevel, 
       UnitsInStock-ReorderLevel  Defference
from Products

--¨§áÊ´§ÃËÑÊÊÔ¹¤éÒ ª×èÍÊÔ¹¤éÒ ÃÒ¤ÒÊÔ¹¤éÒ áÅÐ ÃÒ¤ÒÊÔ¹¤éÒ·Õè»ÃÑº¢Öé¹ 10%
select ProductID, ProductName,UnitPrice, 
         Convert(Decimal(10,2),UnitPrice*1.1) NewPrice,
		 Convert(Decimal(10,2),round(UnitPrice*1.1,2)) NewPrice2
from products

--¨§áÊ´§ª×èÍ¾¹Ñ¡§Ò¹ áÅÐ¨Ó¹Ç¹»Õ·Õè·Ó§Ò¹ (¹Ñº¨Ó¹Ç¹à»ç¹»ÕáººàµçÁ»Õ)
Select EmployeeID,TitleOfCourtesy+FirstName+' '+LastName [Employee Name] , 
       year(getdate()) - year(hiredate) Experience, 
	   year(getdate()) - year(birthdate) Age,
	   DATEDIFF(hour,BirthDate,GETDATE())/8766 AS AgeYearsIntTrunc
from Employees

--¨§áÊ´§ª×èÍÊÔ¹¤éÒà¾ÕÂ§ 5 µÑÇÍÑ¡ÉÃ áÅÐÃÒ¤ÒÊÔ¹¤éÒ
Select productID, left(productName,5) PName, UnitPrice
from Products

--¨§áÊ´§ÃËÑÊÊÔ¹¤éÒ ¨Ó¹Ç¹ ÃÒ¤Ò ÊèÇ¹Å´ ÂÍ´à§Ô¹àµçÁ ÊèÇ¹Å´(·Õè¤Ó¹Ç³áÅéÇ) ÂÍ´à§Ô¹·ÕèËÑ¡ÊèÇ¹Å´áÅéÇ
--¨Ò¡µÒÃÒ§ [order Details]
--µéÍ§àÍÒ¨Ó¹Ç³*ÃÒ¤Ò¢ÒÂ¡èÍ¹áÅéÇ¤èÍÂËÑ¡ÊèÇ¹Å´
select ProductID, Quantity,UnitPrice,Discount, 
       Quantity*UnitPrice TotalCashÃÇÁ, 
	   Quantity*UnitPrice*Discount DiscountCashÊèÇ¹Å´,
	   (Quantity*UnitPrice)-(Quantity*UnitPrice*Discount) NetCashÂÍ´ÊØ´·éÒÂ
from [Order Details]
order by 1, 7 desc
--order by ProductID, NetCashÂÍ´ÊØ´·éÒÂ desc
------------------------------------------------
--Aggregate Function 
Select count(*)
from Products
Where UnitsInStock<15


Select CategoryID,Max(Unitprice), Min(UnitPrice),Avg(UnitPrice), Sum(UnitsInStock)
from Products
group by CategoryID

--µéÍ§¡ÒÃ·ÃÒº¨Ó¹Ç¹·Õè¢ÒÂä´é·Ñé§ËÁ´¢Í§ÊÔ¹¤éÒã¹ÃÒÂ¡ÒÃ¢ÒÂµÑé§áµèËÁÒÂàÅ¢ 11000 à»ç¹µé¹ä»
--àÅ×Í¡ÁÒà©¾ÒÐÁÕÂÍ´¢ÒÂµèÓ¡ÇèÒ 20 ªÔé¹
Select ProductID,Sum(Quantity) ¨Ó¹Ç¹·Õè¢ÒÂä´é
from [Order Details]
where orderID>=11000
group by productID
having Sum(quantity)<20
order by 2 desc

--µéÍ§¡ÒÃ·ÃÒºÃÒ¤Òà©ÅÕèÂ ÃÒ¤ÒÊÙ§ÊØ´ áÅÐÃÒ¤ÒµèÓÊØ´ ¢Í§ÊÔ¹¤éÒáµèÅÐËÁÇ´ËÁÙè
Select CategoryID, Avg(UnitPrice), Max(UnitPrice), min(UnitPrice)
from Products
group by categoryID
order by CategoryID
--µéÍ§¡ÒÃ·ÃÒº¨Ó¹Ç¹ÅÙ¡¤éÒã¹áµèÅÐ»ÃÐà·È à©¾ÒÐÅÙ¡¤éÒ·Õèà»ç¹ owner à·èÒ¹Ñé¹ //áÊ´§à©¾ÒÐÃÒÂ¡ÒÃ·ÕèÁÕ 1 ÃÒÂ
Select country,count(*)
from customers
where ContactTitle = 'owner'
group by country
having count(*) =1   --ÁÒà¾ÔèÁ·ÕËÅÑ§
order by Country
--µéÍ§¡ÒÃ·ÃÒº¨Ó¹Ç¹ãºÊÑè§«×éÍ áÅÐÂÍ´ÃÇÁ¢Í§¤èÒÊè§ ·Õè¶Ù¡Êè§ä»»ÃÐà·ÈµèÒ§æ à©¾ÒÐã¹»Õ 1998 
Select ShipCountry,count(*), sum(Freight)
from orders
where year(OrderDate) = 1998
group by ShipCountry
order by 3 desc

-- µéÍ§¡ÒÃÃËÑÊÊÔ¹¤éÒ ª×èÍÊÔ¹¤éÒ ÃÒ¤Ò ÃËÑÊËÁÇ´ËÁÙè ª×èÍËÁÇ´ËÁÙè à©¾ÒÐËÁÇ´ËÁÙèËÁÒÂàÅ¢ 2,4,6,8
select productID, ProductName, UnitPrice,p.categoryID, categoryName
from products p, categories c
where (p.CategoryID = c.CategoryID) and (p.categoryID in (2,4,6,8))
order by 4

select productID, ProductName, UnitPrice,p.categoryID, categoryName
from products p join categories c on p.CategoryID = c.CategoryID
where p.categoryID in (2,4,6,8)
order by 4

--µéÍ§¡ÒÃª×èÍ¾¹Ñ¡§Ò¹·ÕèÃÑº¤ÓÊÑè§«×éÍËÁÒÂàÅ¢ 10275 (áÊ´§ª×Í¾¹Ñ¡§Ò¹ ÃËÑÊ¤ÓÊÑè§«×éÍ ÇÑ¹·ÕèÃÑº¤ÓÊÑè§«×éÍ)
select FirstName, orderID, OrderDate
from orders o join Employees e on o.EmployeeID = e.EmployeeID
where orderID = 10275

--µéÍ§¡ÒÃ¢éÍÁÙÅÊÔ¹¤éÒ »ÃÐà·È·ÕèÁÒ ÃËÑÊËÁÇ´ËÁÙè ª×èÍËÁÇ´ËÁÙè 
--à©¾ÒÐÊÔ¹¤éÒ·ÕèÁÒ¨Ò¡»ÃÐà·È USA, Mexico, Canada,Brazil áÅÐÁÕÊ¶Ò¹Ð¨ÓË¹èÒÂÊÔ¹¤éÒ
select ProductID, ProductName, UnitPrice, s.Country, c.CategoryID , CategoryName

from products p join Categories c on p.CategoryID = c.CategoryID
                join Suppliers s on p.SupplierID = s.SupplierID

where s.Country in ('USA', 'Mexico', 'Canada','Brazil') and Discontinued = 0
order by 4, 5

--¨§áÊ´§ ÃËÑÊÊÔ¹¤éÒ ª×èÍÊÔ¹¤éÒ »ÃÐà·È·ÕèÁÒ¢Í§ÊÔ¹¤éÒ ËÁÇ´ËÁÙèÊÔ¹¤éÒ ¨Ó¹Ç¹·Õè¢ÒÂ ª×èÍÅÙ¡¤éÒ¼Ùé«×éÍ 
--ª×èÍ¹ÒÁÊ¡ØÅ¾¹Ñ¡§Ò¹¼Ùé¢ÒÂ ª×èÍºÃÔÉÑ·¢¹Êè§ »ÃÐà·È·ÕèÊè§¢Í§ à©¾ÒÐÃÒÂ¡ÒÃÊÔ¹¤éÒÃËÑÊ 77 ·ÕèÍÂÙèã¹ãºÊÑè§«×éÍËÁÒÂàÅÂ 11077
select p.ProductID,p.ProductName, s.Country,c.CategoryName, od.Quantity, cu.CompanyName,
       FirstName+' '+LastName EmployeeName, sh.CompanyName, o.ShipCountry
from orders o join [Order Details] od on o.orderID = od.OrderID
			  join products p on p.ProductID = od.ProductID
			  join Categories c on p.CategoryID = c.CategoryID
			  join Suppliers s on p.SupplierID = s.SupplierID
			  join Shippers sh on o.ShipVia = sh.ShipperID
			  join Employees e on o.EmployeeID = e.EmployeeID
			  join customers cu on o.CustomerID = cu.CustomerID
where p.ProductID = 77 and o.OrderID=11077

