-- Easy select with condition and math  1. || All propereties of sum of invoices in 2021
SELECT 
  COUNT(total) 'количество', 
  AVG(total) 'средняя сумма', 
  MAX(total) 'максимальная сумма', 
  MIN(total) 'минимальная сумма', 
  SUM(total) 'сумма всех инвойсов', 
  STDEV(total) 'стандартное отклонение суммы',
  AVG(total)-3*STDEV(total) 'нижний охват в 3 сигмы',
  AVG(total)+3*STDEV(total) 'верхний охват в 3 сигмы'
FROM InvoiceHeader
WHERE date BETWEEN  '2021-01-01' and '2022-01-01';

-- Easy select with condition and math 2. || The list of invoices, which is the sum is  in 2021
SELECT * FROM InvoiceHeader
WHERE total NOT BETWEEN total-3* STDEV(total) and total+3* STDEV(total);
