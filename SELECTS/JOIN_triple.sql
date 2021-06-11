--выручка по отдельному товару
select pd.name, SUM(psp.sellPrice) from Product p 
inner join ProductDict pd on pd.product_id=p.product_id and p.productStatus_id=3 
inner join ProductSellPrice psp on psp.barcode=p.barcode 
GROUP BY pd.name;
