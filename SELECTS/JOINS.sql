--количество поставщиков по странам
select cd.name, COUNT(md.manufacturer_id) as amount from CountryDict cd inner join ManufacturerDict md on md.country_id=cd.country_id GROUP by cd.name; 

--количество накладных по поставщикам
select sd.name, COUNT(ih.invoice_id) from SupplierDict sd inner join InvoiceHeader ih on ih.supplier_id=sd.supplier_id GROUP BY sd.name;

--позиции по количеству в заказе
select pd.name, SUM(od.qty) as 'total ordered' from OrderDetail od inner join ProductDict pd on pd.product_id=od.product_id GROUP BY pd.name;
