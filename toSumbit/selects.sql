--1 Easy select with condition and math. || All propereties of sum of invoices in 2021
SELECT 
  COUNT(total) 'количество', 
  AVG(total) 'средняя сумма', 
  MAX(total) 'максимальная сумма', 
  MIN(total) 'минимальная сумма', 
  SUM(total) 'сумма всех инвойсов', 
  STDEV(total) 'стандартное отклонение суммы',
  AVG(total)-3*STDEV(total) 'нижний охват в 3 сигмы',
  AVG(total)+3*STDEV(total) 'верхний охват в 3 сигмы'
FROM InvoiceHeader
WHERE date BETWEEN  '2021-01-01' and '2022-01-01';

--2 Easy select with condition and math. || The list of invoices, which is the sum is  in 2021
SELECT * 
FROM InvoiceHeaderWHERE total NOT BETWEEN total-3* STDEV(total) and total+3* STDEV(total);


--3 Co-related query in Select || For info look table in googel docs...
SELECT DISTINCT 
supplier_id, 
(SELECT COUNT(*) FROM OrderHeader WHERE supplier_id= od.supplier_id   AND orderStatus_id = 1) AS 'Количество открытых Заказов'
FROM 
	OrderDetail od 
	LEFT JOIN 
	OrderHeader oh 
	ON od.order_id = oh.order_id;



--4 Co-related query in Select || For info look table in googel docs...
-- MAKES THE SAME STUFF AS GROUP BY HERE:
-- SELECT
-- 	reservation_id,
-- 	SUM(qty*sellPrice)
-- FROM 
-- 	ReservationDetail rd 
-- 	LEFT JOIN 
-- 	ProductSellPrice psp 
-- 	ON rd.barcode = psp.barcode
-- GROUP BY reservation_id;
SELECT DISTINCT 
	reservation_id,
	(SELECT SUM(qty*sellPrice) 
		FROM ReservationDetail rd2 LEFT JOIN ProductSellPrice psp2 
		ON rd2.barcode = psp2.barcode
		WHERE rd2.reservation_id = rd.reservation_id)
FROM 
	ReservationDetail rd 
	LEFT JOIN 
	ProductSellPrice psp 
	ON rd.barcode = psp.barcode;
	
	
	

--5 Subquery in FROM || For info look table in googel docs...
SELECT 
	COUNT(total) 'количество', 
	AVG(total) 'средняя сумма', 
	MAX(total) 'максимальная сумма', 
	MIN(total) 'минимальна я сумма', 
	SUM(total) 'сумма всех инвойсов', 
	STDEV(total) 'стандартное отклонение суммы',
	AVG(total)-3*STDEV(total) 'нижний охват в 3 сигмы',
	AVG(total)+3*STDEV(total) 'верхний охват в 3 сигмы'
FROM 
	 (
		 SELECT
		 	reservation_id AS r_id,
		 	SUM(qty*sellPrice) AS total
		 FROM 
		 	ReservationDetail rd 
		 	LEFT JOIN 
		 	ProductSellPrice psp 
		 	ON rd.barcode = psp.barcode
		 GROUP BY reservation_id
	 ) AS r_total;




--7 Subquery in FROM with agregate and ordering || For info look table in googel docs...
 SELECT employee_id, total
 FROM 
	 (
		 SELECT
		 	employee_id ,
		 	SUM(qty*sellPrice) AS total
		 FROM 
		 	ReservationDetail rd 
		 	LEFT JOIN 
		 	ProductSellPrice psp ON rd.barcode = psp.barcode
		 	LEFT JOIN 
		 	ReservationHeader rh ON rh.reservation_id = rd.reservation_id 
		 GROUP BY employee_id 
	 ) AS total
	 WHERE total.total > (SELECT AVG(total) FROM (
													 SELECT
													 	employee_id ,
													 	SUM(qty*sellPrice) AS total
													 FROM 
													 	ReservationDetail rd 
													 	LEFT JOIN 
													 	ProductSellPrice psp ON rd.barcode = psp.barcode
													 	LEFT JOIN 
													 	ReservationHeader rh ON rh.reservation_id = rd.reservation_id 
													 GROUP BY employee_id 
												 ) AS total2
	 )
	 ORDER BY total DESC;	 


--16 Query with set operation|| For info look table in googel docs...
SELECT barcode FROM Product p2 
EXCEPT
SELECT barcode FROM ProductSellPrice psp;


--18 Query with outer join and NULL Check|| For info look table in googel docs...
SELECT od.product_id, od.order_id,  od.qty, od.supplier_id 
FROM
	(
	SELECT 
		price.barcode as barcode
	FROM
		(
			SELECT
				barcode,
				MAX(start) AS date
			FROM
				ProductBuyPrice pbp
			GROUP BY barcode
		) AS price
		LEFT JOIN 
		ProductBuyPrice pbp2 
		ON price.barcode = pbp2.barcode 
		WHERE price.date = pbp2.[start]
	) AS price
	LEFT JOIN Product p ON price.barcode = p.barcode
	RIGHT JOIN OrderDetail od ON od.product_id = p.product_id 
WHERE p.product_id IS NULL;


--20 Query with having|| For info look table in googel docs...
SELECT 
	pstd.productSubType_id AS 'id Типа',
	pstd.name AS 'Название типа',
	COUNT(*) AS N'Количетво Товаров с таким типом'
FROM 
	ProductDict pd
	LEFT JOIN ProductSubTypeDict pstd ON pd.productSubType_id = pstd.productSubType_id
GROUP BY pstd.productSubType_id, pstd.name
HAVING COUNT(*) <= 5
ORDER BY COUNT(*) ASC;


-- 22
SELECT COUNT(*)
    FROM EmployeeDict ed
    WHERE name = 'Emma';
    
-- lag query
select barcode, name, prev, sellPrice, isHIgher from (
select pbp.barcode, pbp.finish , p.product_id, pd.name, 
	lag(pbp.sellPrice) over (ORDER by pbp.start) as prev,
	pbp.sellPrice, isHigher =
		CASE
			when pbp.sellPrice > lag(pbp.sellPrice) over (ORDER by pbp.start) then 'higher'
			when pbp.sellPrice < lag(pbp.sellPrice) over (ORDER by pbp.start) then 'lower'
			else 'Prev price is null'
		END 

from ProductBuyPrice pbp
	inner join Product p on p.barcode=pbp.barcode
	inner join ProductDict pd on pd.product_id=p.product_id
) as a where a.finish is null;

--вывод названия товара в списке товарного запаса
SELECT *, (SELECT name from ProductDict pd where p.product_id=pd.product_id) from Product p; 

  
--если цена выше средней со средней ценой продажи товара 
select p.barcode, AVG(psp.sellPrice) as p_average  from Product p 
inner join ProductSellPrice psp on p.barcode=psp.barcode 
WHERE sellPrice > (SELECT  AVG(sellPrice) from ProductSellPrice psp2) 
group by p.barcode
ORDER by p_average ASC;


--количество поставщиков по странам
select cd.name, COUNT(md.manufacturer_id) as amount from CountryDict cd inner join ManufacturerDict md on md.country_id=cd.country_id GROUP by cd.name; 

--количество накладных по поставщикам
select sd.name, COUNT(ih.invoice_id) from SupplierDict sd inner join InvoiceHeader ih on ih.supplier_id=sd.supplier_id GROUP BY sd.name;

--позиции по количеству в заказе
select pd.name, SUM(od.qty) as 'total ordered' from OrderDetail od inner join ProductDict pd on pd.product_id=od.product_id GROUP BY pd.name;

--выручка по отдельному товару
select pd.name, SUM(psp.sellPrice) from Product p 
inner join ProductDict pd on pd.product_id=p.product_id and p.productStatus_id=3 
inner join ProductSellPrice psp on psp.barcode=p.barcode 
GROUP BY pd.name;




-- 9 Запрос с коррелированным подзапросом в WHERE
--список всех заказов, где покупатели приобрели меньше 15% от общих продаж определенного товара, чтобы выявить наименее популярные товары
select distinct reservation_id
  from [ReservationDetail] RD
	where 
		qty <= (select avg(qty)  *  .15
			from [ReservationDetail] 
			where RD.barcode = barcode)

-- 10 Запрос с коррелированным подзапросом в WHERE
--находим всех сотрудников с зарплатой больше средней
SELECT employee_id, name, salary
FROM EmployeeDict 
WHERE salary > (SELECT AVG(salary) from EmployeeDict )
	
-- 15 Запрос с EXISTS
--находим все продукты, которые когда либо были заказаны, чтобы можно было вести учет продаж
SELECT barcode, product_id
  FROM Product
 WHERE EXISTS 
  (SELECT *
     FROM ReservationDetail
    WHERE Product.barcode = ReservationDetail.barcode); 
    
--0
SELECT sum(psp.sellPrice * rd.qty)
		from ProductSellPrice psp 
		inner join ReservationDetail rd 
		on psp.barcode = rd.barcode 
		inner join ReservationHeader rh 
		on rd.reservation_id  = rh.reservation_id 
		where (psp.barcode = rd.barcode) and (rh.reservationStatus_id = 2)

--2
select SUM(qty) Products_in_Stock
from Product 
where productStatus_id = 2

--19
select 
	SUM(CASE when rh.reservationType_id = 1 then 1 else 0 end) Online_order,
	SUM(case when rh.reservationType_id = 2 then 1 else 0 end) Offline_order,
	SUM(case when rh.reservationType_id = 3 then 1 else 0 end) Phone_order
from ReservationHeader rh 

--21
DECLARE @ResTableVar table(  
    Res_id INT not null,  
    OldTotal decimal,  
    NewTotal decimal); 
UPDATE TOP (2) ReservationHeader 
SET Total = Total * 0.25   
OUTPUT INSERTED.reservation_id,  
       DELETED.Total,    
       INSERTED.Total  
INTO @ResTableVar;  
SELECT * into #ResTempTable FROM @ResTableVar; 
select * from #ResTempTable;
