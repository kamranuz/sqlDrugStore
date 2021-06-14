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
