--вывод названия товара в списке товарного запаса
SELECT *, (SELECT name from ProductDict pd where p.product_id=pd.product_id) from Product p; 