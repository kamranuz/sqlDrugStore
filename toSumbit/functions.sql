create function func_products_count
(@b_id int)
returns int 
AS 
begin 
		declare @num int, @q int 
		set @num = (select count(*) from ReservationDetail rd 
			inner join ReservationHeader rh 
			on rd.reservation_id  = rh.reservation_id 
			where (rd.barcode = @b_id) and (rh.reservationStatus_id = 2))
		set @q = (select rd2.qty from ReservationDetail rd2 
			inner join ReservationHeader rh2 
			on rd2.reservation_id  = rh2.reservation_id  
			where (rd2.barcode = @b_id) and (rh2.reservationStatus_id = 2))
		return (@num * @q)
end

select dbo.func_products_count(3) as Total_Number_of_Sells;

create FUNCTION func_supplier_count
(@city_id int)
returns int 
AS 
begin 
	DECLARE @totalnumber int 
	set @totalnumber = (select count(*) from SupplierDict where city_id = @city_id)
	RETURN (@totalnumber)
end

select dbo.func_supplier_count(1062) as Total_Number_of_Suppliers;
