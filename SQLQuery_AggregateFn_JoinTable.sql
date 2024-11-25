--������ҧ�ѹ�����ҹ������ Northwind
--Calculate Column ����������Դ�ҡ��äӹǳ

--���ʴ���������ͧ��ѡ�ҹ�ء��   --Alias Name ����繪��͢��������
Select EmployeeID,TitleOfCourtesy+FirstName+' '+LastName [Employee Name]
from Employees
Select EmployeeID,[Employee Name] = TitleOfCourtesy+FirstName+' '+LastName
from Employees

--���ʴ��������Թ��ҷ���ըӹǹ�ʵ�͡(UnitsInStock)��ӡ��Ҩӹǹ����ͧ��觫���(ReorderLevel)
Select productID,productName,UnitsInStock, ReorderLevel, 
       UnitsInStock-ReorderLevel  Defference
from Products

--���ʴ������Թ��� �����Թ��� �Ҥ��Թ��� ��� �Ҥ��Թ��ҷ���Ѻ��� 10%
select ProductID, ProductName,UnitPrice, 
         Convert(Decimal(10,2),UnitPrice*1.1) NewPrice,
		 Convert(Decimal(10,2),round(UnitPrice*1.1,2)) NewPrice2
from products

--���ʴ����;�ѡ�ҹ ��Шӹǹ�շ��ӧҹ (�Ѻ�ӹǹ�繻�Ẻ�����)
Select EmployeeID,TitleOfCourtesy+FirstName+' '+LastName [Employee Name] , 
       year(getdate()) - year(hiredate) Experience, 
	   year(getdate()) - year(birthdate) Age,
	   DATEDIFF(hour,BirthDate,GETDATE())/8766 AS AgeYearsIntTrunc
from Employees

--���ʴ������Թ�����§ 5 ����ѡ�� ����Ҥ��Թ���
Select productID, left(productName,5) PName, UnitPrice
from Products

--���ʴ������Թ��� �ӹǹ �Ҥ� ��ǹŴ �ʹ�Թ��� ��ǹŴ(���ӹǳ����) �ʹ�Թ����ѡ��ǹŴ����
--�ҡ���ҧ [order Details]
--��ͧ��Ҩӹǳ*�ҤҢ�¡�͹���Ǥ����ѡ��ǹŴ
select ProductID, Quantity,UnitPrice,Discount, 
       Quantity*UnitPrice TotalCash���, 
	   Quantity*UnitPrice*Discount DiscountCash��ǹŴ,
	   (Quantity*UnitPrice)-(Quantity*UnitPrice*Discount) NetCash�ʹ�ش����
from [Order Details]
order by 1, 7 desc
--order by ProductID, NetCash�ʹ�ش���� desc
------------------------------------------------
--Aggregate Function 
Select count(*)
from Products
Where UnitsInStock<15


Select CategoryID,Max(Unitprice), Min(UnitPrice),Avg(UnitPrice), Sum(UnitsInStock)
from Products
group by CategoryID

--��ͧ��÷�Һ�ӹǹ�������������ͧ�Թ������¡�â�µ���������Ţ 11000 �繵��
--���͡��੾�����ʹ��µ�ӡ��� 20 ���
Select ProductID,Sum(Quantity) �ӹǹ�������
from [Order Details]
where orderID>=11000
group by productID
having Sum(quantity)<20
order by 2 desc

--��ͧ��÷�Һ�Ҥ������ �Ҥ��٧�ش ����Ҥҵ���ش �ͧ�Թ���������Ǵ����
Select CategoryID, Avg(UnitPrice), Max(UnitPrice), min(UnitPrice)
from Products
group by categoryID
order by CategoryID
--��ͧ��÷�Һ�ӹǹ�١�������л���� ੾���١��ҷ���� owner ��ҹ�� //�ʴ�੾����¡�÷���� 1 ���
Select country,count(*)
from customers
where ContactTitle = 'owner'
group by country
having count(*) =1   --����������ѧ
order by Country
--��ͧ��÷�Һ�ӹǹ���觫��� ����ʹ����ͧ����� ���١��任���ȵ�ҧ� ੾��㹻� 1998 
Select ShipCountry,count(*), sum(Freight)
from orders
where year(OrderDate) = 1998
group by ShipCountry
order by 3 desc

-- ��ͧ��������Թ��� �����Թ��� �Ҥ� ������Ǵ���� ������Ǵ���� ੾����Ǵ���������Ţ 2,4,6,8
select productID, ProductName, UnitPrice,p.categoryID, categoryName
from products p, categories c
where (p.CategoryID = c.CategoryID) and (p.categoryID in (2,4,6,8))
order by 4

select productID, ProductName, UnitPrice,p.categoryID, categoryName
from products p join categories c on p.CategoryID = c.CategoryID
where p.categoryID in (2,4,6,8)
order by 4

--��ͧ��ê��;�ѡ�ҹ����Ѻ����觫��������Ţ 10275 (�ʴ���;�ѡ�ҹ ���ʤ���觫��� �ѹ����Ѻ����觫���)
select FirstName, orderID, OrderDate
from orders o join Employees e on o.EmployeeID = e.EmployeeID
where orderID = 10275

--��ͧ��â������Թ��� ����ȷ���� ������Ǵ���� ������Ǵ���� 
--੾���Թ��ҷ���Ҩҡ����� USA, Mexico, Canada,Brazil �����ʶҹШ�˹����Թ���
select ProductID, ProductName, UnitPrice, s.Country, c.CategoryID , CategoryName

from products p join Categories c on p.CategoryID = c.CategoryID
                join Suppliers s on p.SupplierID = s.SupplierID

where s.Country in ('USA', 'Mexico', 'Canada','Brazil') and Discontinued = 0
order by 4, 5

--���ʴ� �����Թ��� �����Թ��� ����ȷ���Ңͧ�Թ��� ��Ǵ�����Թ��� �ӹǹ����� �����١��Ҽ����� 
--���͹��ʡ�ž�ѡ�ҹ����� ���ͺ���ѷ���� ����ȷ���觢ͧ ੾����¡���Թ������� 77 �����������觫���������� 11077
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

