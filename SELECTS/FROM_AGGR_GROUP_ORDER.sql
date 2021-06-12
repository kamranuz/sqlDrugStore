--цена выше средней
select p.barcode, psp.sellPrice from Product p 
inner join ProductSellPrice psp on p.barcode=psp.barcode 
WHERE sellPrice > (SELECT  AVG(sellPrice) from ProductSellPrice psp2) 
group by p.barcode, psp.sellPrice 
ORDER by sellPrice ASC;
