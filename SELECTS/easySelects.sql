-- Easy select 1. The sum of all invoices in 2021
SELECT SUM(total) FROM InvoiceHeader
WHERE date BETWEEN  '2021-01-01' and '2022-01-01';
