create trigger InvoiceHeader_Update
on ProductBuyPrice after insert
AS
if @@rowcount = 1
begin
DECLARE @barcode int, @price decimal
SELECT @barcode = i.barcode, @price = i.buyPrice 
FROM inserted i
UPDATE InvoiceHeader SET total = total + @price*(select p.qty from Product p where p.barcode = @barcode)
WHERE InvoiceHeader.invoice_id = (select p2.invoice_id from Product p2 where p2.barcode = @barcode)
end
