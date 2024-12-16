-- ต้องการ รหัสสินค้า ชื่อสินค้า จำนวนในสต๊อก ราคาต่อหน่วย และต้องการทราบมูลค่าของสินค้าที่อยู่ในสต๊อกปัจจุบัน
-- เฉพาะสินค้าประเภท "Seafood"
Select p.ProductID, p.ProductName, p.UnitsInStock, p.UnitPrice, 
       p.UnitsInStock*p.UnitPrice มูลค่าปัจจุบัน
from Products p join Categories c on p.CategoryID = c.CategoryID
where CategoryName = 'seafood'

-- ต้องการรหัสใบสั่งซื้อ วันที่ออกใบสั่งซื้อ ยอดเงินรวมในใบสั่งซื้อ ที่ออกในเดือน ธันวาคม 1997 เรียงจากมากไปน้อย
select o.OrderID, o.OrderDate, 
       Convert(decimal(10,2),sum(od.Quantity * od.UnitPrice *(1-od.Discount))) ยอดเงินรวม
from orders o join [Order Details] od on o.OrderID = od.OrderID
where year(OrderDate) = 1997 and month(OrderDate) = 12
group by o.OrderID, o.OrderDate
order by 3 desc

-- ต้องการรหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ เฉพาะที่ขายได้ในเดือน ธันวาคม 1997
select p.ProductID, p.ProductName, sum(quantity) จำนวนที่ขายได้
from products p join [Order Details] od on p.ProductID = od.ProductID
                join orders o on o.OrderID = od.OrderID
where year(OrderDate) = 1997 and month(OrderDate) = 12
group by p.ProductID, p.ProductName

-- ต้องการรายการสินค้า(รหัส,ชื่อสินค้า,จำนวนที่ขาย, ราคาเฉลี่ย, ยอดเงินรวม) ที่ Nancy ขายได้ในปี 1998
-- เรียงตามยอดเงินรวมจากมากไปน้อย
select p.ProductID, p.ProductName, sum(quantity) จำนวนที่ขายได้, avg(od.unitprice) ราคาเฉลี่ย,
        Convert(decimal(10,2),sum(od.Quantity * od.UnitPrice *(1-od.Discount))) ยอดเงินรวม
from orders o join [Order Details] od on o.OrderID = od.OrderID
			  join products p on od.ProductID = p.ProductID
			  join Employees e on e.EmployeeID = o.EmployeeID
where firstname = 'Nancy' and year(OrderDate)  = 1998
group by p.ProductID, p.ProductName

-- จากข้อก่อนหน้านี้ จงหายอดขายทั้งปี 1998 ของ Nancy
select Convert(decimal(10,2),sum(od.Quantity * od.UnitPrice *(1-od.Discount))) ยอดเงินรวม
from orders o join [Order Details] od on o.OrderID = od.OrderID
			  join products p on od.ProductID = p.ProductID
			  join Employees e on e.EmployeeID = o.EmployeeID
where firstname = 'Nancy' and year(OrderDate)  = 1998

-- จงแสดงรหัสใบสั่งซื้อ วันที่ออกใบสั่งซื้อ วันที่รับสินค้า ชื่อบริษัทขนส่ง ชื่อเต็มพนักงาน ชื่อบริษัทลูกค้า เบอร์โทรลูกค้า
-- ยอดเงินรวม ในใบเสร็จเลขที่  10801

-- จงแสดง รหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ ราคาที่ขาย ส่วนลด(%), ยอดเงินเต็ม, ยอดเงินส่วนลด, ยอดเงินที่หักส่วนลด
-- ในแต่ละรายการในใบเสร็จเลขที่  10801



