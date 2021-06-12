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
-- SELECT * FROM InvoiceHeader
-- WHERE total NOT BETWEEN total-3* STDEV(total) and total+3* STDEV(total);


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
