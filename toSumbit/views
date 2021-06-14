-- FIRST VIEW

CREATE VIEW ReportStockBalance
AS
	SELECT 
		X.barcode AS N'Штрих-код',
		pd.name AS N'Название Товара',
		md.name AS N'Производитель',
		X.Остаток,
		p2.qty AS N'Всего было заказано',
		sd.name AS N'Поставщик',
		ih.[date] AS N'Дата Поставки'
	FROM 
		(
			SELECT 
				barcode, 
				SUM(qty) AS N'Остаток'
			FROM 
			(		
				SELECT 
					barcode,
					qty 
				FROM Product p
				WHERE p.productStatus_id < 3
				UNION
				SELECT 
					barcode, 
					-rd.qty AS qty
				FROM 
					ReservationDetail rd
					INNER JOIN ReservationHeader rh ON rd.reservation_id  = rh.reservation_id
				WHERE rh.reservationStatus_id < 3
			) AS X 
			GROUP BY barcode
		) AS X
		LEFT JOIN Product p2 			ON p2.barcode = X.barcode
		LEFT JOIN ProductDict pd 		ON pd.product_id = p2.product_id
		LEFT JOIN ManufacturerDict md 	ON md.manufacturer_id = pd.manufacturer_id
		LEFT JOIN InvoiceHeader ih 		ON ih.invoice_id = p2.invoice_id 
		LEFT JOIN SupplierDict sd 		ON sd.supplier_id = ih.supplier_id;
		
		
		
-- SECOND VIEW

CREATE VIEW ReportInvoicesMain
AS
	SELECT 
		sd.name	AS 'Поставщик',
		ih.invoice_id AS 'Номер Инвойса',
		id.name AS 'Статус',
		ih.[date] AS 'Дата Инвойса',
		ih.total AS 'Сумма Инвойса'
	FROM InvoiceHeader ih
	LEFT JOIN SupplierDict sd ON ih.supplier_id = sd.supplier_id
	LEFT JOIN IStatusDict id ON ih.invoiceStatus_id = id.invoiceStatus_id;
