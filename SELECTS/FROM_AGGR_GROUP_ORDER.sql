--если цена выше средней со средней ценой продажи товара 
select p.barcode, AVG(psp.sellPrice) as p_average  from Product p 
inner join ProductSellPrice psp on p.barcode=psp.barcode 
WHERE sellPrice > (SELECT  AVG(sellPrice) from ProductSellPrice psp2) 
group by p.barcode
ORDER by p_average ASC;


