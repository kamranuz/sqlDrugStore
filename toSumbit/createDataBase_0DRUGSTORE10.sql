-- [0DRUGSTORE8].dbo.CountryDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.CountryDict GO

CREATE TABLE [0DRUGSTORE8].dbo.CountryDict (
	country_id int IDENTITY(374,1) NOT NULL,
	name nvarchar(32) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_CountryDict_country_id PRIMARY KEY (country_id)
) ;


-- [0DRUGSTORE8].dbo.EmployeeDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.EmployeeDict GO

CREATE TABLE [0DRUGSTORE8].dbo.EmployeeDict (
	employee_id int IDENTITY(11,1) NOT NULL,
	name nvarchar(32) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	surname nvarchar(32) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	dob date DEFAULT NULL NULL,
	salary decimal(10,2) DEFAULT NULL NULL,
	[role] nvarchar(45) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_EmployeeDict_employee_id PRIMARY KEY (employee_id)
)
 CREATE NONCLUSTERED INDEX employee_name ON dbo.EmployeeDict (  name ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ]  ;


-- [0DRUGSTORE8].dbo.IStatusDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.IStatusDict GO

CREATE TABLE [0DRUGSTORE8].dbo.IStatusDict (
	invoiceStatus_id int IDENTITY(3,1) NOT NULL,
	name nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_IStatusDict_invoiceStatus_id PRIMARY KEY (invoiceStatus_id)
) ;


-- [0DRUGSTORE8].dbo.OStatusDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.OStatusDict GO

CREATE TABLE [0DRUGSTORE8].dbo.OStatusDict (
	orderStatus_id int IDENTITY(3,1) NOT NULL,
	name nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_OStatusDict_orderStatus_id PRIMARY KEY (orderStatus_id)
) ;


-- [0DRUGSTORE8].dbo.PStatusDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.PStatusDict GO

CREATE TABLE [0DRUGSTORE8].dbo.PStatusDict (
	productStatus_id int IDENTITY(6,1) NOT NULL,
	name nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_PStatusDict_productStatus_id PRIMARY KEY (productStatus_id)
) ;


-- [0DRUGSTORE8].dbo.ProductTypeDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.ProductTypeDict GO

CREATE TABLE [0DRUGSTORE8].dbo.ProductTypeDict (
	productType_id int IDENTITY(28,1) NOT NULL,
	name nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK_ProductTypeDict_productType_id PRIMARY KEY (productType_id)
) ;


-- [0DRUGSTORE8].dbo.RStatusDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.RStatusDict GO

CREATE TABLE [0DRUGSTORE8].dbo.RStatusDict (
	reservationStatus_id int IDENTITY(4,1) NOT NULL,
	name nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_RStatusDict_reservationStatus_id PRIMARY KEY (reservationStatus_id)
) ;


-- [0DRUGSTORE8].dbo.RTypeDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.RTypeDict GO

CREATE TABLE [0DRUGSTORE8].dbo.RTypeDict (
	reservationType_id int IDENTITY(4,1) NOT NULL,
	name nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_RTypeDict_reservationType_id PRIMARY KEY (reservationType_id)
) ;

-- [0DRUGSTORE8].dbo.CityDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.CityDict GO

CREATE TABLE [0DRUGSTORE8].dbo.CityDict (
	country_id int DEFAULT NULL NULL,
	name nvarchar(32) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	city_id int IDENTITY(102201,1) NOT NULL,
	CONSTRAINT PK_CityDict_city_id PRIMARY KEY (city_id),
	CONSTRAINT CityDict$CityDict_ibfk_1 FOREIGN KEY (country_id) REFERENCES [0DRUGSTORE8].dbo.CountryDict(country_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.ManufacturerDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.ManufacturerDict GO

CREATE TABLE [0DRUGSTORE8].dbo.ManufacturerDict (
	country_id int DEFAULT NULL NULL,
	manufacturer_id int IDENTITY(1004,1) NOT NULL,
	name nvarchar(64) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	CONSTRAINT PK_ManufacturerDict_manufacturer_id PRIMARY KEY (manufacturer_id),
	CONSTRAINT ManufacturerDict$ManufacturerDict_ibfk_1 FOREIGN KEY (country_id) REFERENCES [0DRUGSTORE8].dbo.CountryDict(country_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.OrderHeader definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.OrderHeader GO

CREATE TABLE [0DRUGSTORE8].dbo.OrderHeader (
	order_id int NOT NULL,
	orderStatus_id int DEFAULT NULL NULL,
	[date] date DEFAULT NULL NULL,
	CONSTRAINT PK_OrderHeader_order_id PRIMARY KEY (order_id),
	CONSTRAINT OrderHeader$OrderHeader_ibfk_1 FOREIGN KEY (orderStatus_id) REFERENCES [0DRUGSTORE8].dbo.OStatusDict(orderStatus_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.ProductSubTypeDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.ProductSubTypeDict GO

CREATE TABLE [0DRUGSTORE8].dbo.ProductSubTypeDict (
	productSubType_id int IDENTITY(306,1) NOT NULL,
	name nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	productType_id int DEFAULT NULL NULL,
	CONSTRAINT PK_ProductSubTypeDict_productSubType_id PRIMARY KEY (productSubType_id),
	CONSTRAINT ProductSubTypeDict$ProductSubTypeDict_ibfk_1 FOREIGN KEY (productType_id) REFERENCES [0DRUGSTORE8].dbo.ProductTypeDict(productType_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.ReservationHeader definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.ReservationHeader GO

CREATE TABLE [0DRUGSTORE8].dbo.ReservationHeader (
	reservation_id int NOT NULL,
	saleAbsolute decimal(10,2) DEFAULT NULL NULL,
	saleRelative decimal(10,2) DEFAULT NULL NULL,
	details nvarchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	reservationStatus_id int DEFAULT NULL NULL,
	startDate date DEFAULT NULL NULL,
	endDate nchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	reservationType_id int DEFAULT NULL NULL,
	employee_id int DEFAULT NULL NULL,
	Total decimal(10,2) DEFAULT 0 NULL,
	CONSTRAINT PK_ReservationHeader_reservation_id PRIMARY KEY (reservation_id),
	CONSTRAINT ReservationHeader$ReservationHeader_ibfk_1 FOREIGN KEY (reservationStatus_id) REFERENCES [0DRUGSTORE8].dbo.RStatusDict(reservationStatus_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ReservationHeader$ReservationHeader_ibfk_2 FOREIGN KEY (reservationType_id) REFERENCES [0DRUGSTORE8].dbo.RTypeDict(reservationType_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ReservationHeader$ReservationHeader_ibfk_3 FOREIGN KEY (employee_id) REFERENCES [0DRUGSTORE8].dbo.EmployeeDict(employee_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.SupplierDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.SupplierDict GO

CREATE TABLE [0DRUGSTORE8].dbo.SupplierDict (
	city_id int DEFAULT NULL NULL,
	name nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	address nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	supplier_id int IDENTITY(19,1) NOT NULL,
	CONSTRAINT PK_SupplierDict_supplier_id PRIMARY KEY (supplier_id),
	CONSTRAINT SupplierDict$SupplierDict_ibfk_1 FOREIGN KEY (city_id) REFERENCES [0DRUGSTORE8].dbo.CityDict(city_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.InvoiceHeader definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.InvoiceHeader GO

CREATE TABLE [0DRUGSTORE8].dbo.InvoiceHeader (
	supplier_id int DEFAULT NULL NULL,
	invoice_id int NOT NULL,
	invoiceStatus_id int DEFAULT NULL NULL,
	[date] date DEFAULT NULL NULL,
	total decimal(10,2) NULL,
	CONSTRAINT PK_InvoiceHeader_invoice_id PRIMARY KEY (invoice_id),
	CONSTRAINT InvoiceHeader$InvoiceHeader_ibfk_1 FOREIGN KEY (supplier_id) REFERENCES [0DRUGSTORE8].dbo.SupplierDict(supplier_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT InvoiceHeader$InvoiceHeader_ibfk_2 FOREIGN KEY (invoiceStatus_id) REFERENCES [0DRUGSTORE8].dbo.IStatusDict(invoiceStatus_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.ProductDict definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.ProductDict GO

CREATE TABLE [0DRUGSTORE8].dbo.ProductDict (
	divider int DEFAULT NULL NULL,
	manufacturer_id int DEFAULT NULL NULL,
	product_id int IDENTITY(4293,1) NOT NULL,
	name nvarchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT NULL NULL,
	productSubType_id int DEFAULT NULL NULL,
	CONSTRAINT PK_ProductDict_product_id PRIMARY KEY (product_id),
	CONSTRAINT ProductDict$ProductDict_ibfk_1 FOREIGN KEY (manufacturer_id) REFERENCES [0DRUGSTORE8].dbo.ManufacturerDict(manufacturer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ProductDict$ProductDict_ibfk_2 FOREIGN KEY (productSubType_id) REFERENCES [0DRUGSTORE8].dbo.ProductSubTypeDict(productSubType_id) ON DELETE CASCADE ON UPDATE CASCADE
)
 CREATE NONCLUSTERED INDEX ix_productNames ON dbo.ProductDict (  name ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ]  ;


-- [0DRUGSTORE8].dbo.OrderDetail definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.OrderDetail GO

CREATE TABLE [0DRUGSTORE8].dbo.OrderDetail (
	order_id int NOT NULL,
	qty int DEFAULT NULL NULL,
	product_id int NOT NULL,
	supplier_id int NOT NULL,
	CONSTRAINT PK_OrderDetail_order_id PRIMARY KEY (order_id,product_id,supplier_id),
	CONSTRAINT OrderDetail$OrderDetail_ibfk_1 FOREIGN KEY (order_id) REFERENCES [0DRUGSTORE8].dbo.OrderHeader(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT OrderDetail$OrderDetail_ibfk_2 FOREIGN KEY (product_id) REFERENCES [0DRUGSTORE8].dbo.ProductDict(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT OrderDetail$OrderDetail_ibfk_3 FOREIGN KEY (supplier_id) REFERENCES [0DRUGSTORE8].dbo.SupplierDict(supplier_id)
) ;


-- [0DRUGSTORE8].dbo.Product definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.Product GO

CREATE TABLE [0DRUGSTORE8].dbo.Product (
	product_id int DEFAULT NULL NULL,
	barcode int NOT NULL,
	invoice_id int DEFAULT NULL NULL,
	qty int DEFAULT NULL NULL,
	productStatus_id int DEFAULT NULL NULL,
	CONSTRAINT PK_Product_barcode PRIMARY KEY (barcode),
	CONSTRAINT Product$Product_ibfk_1 FOREIGN KEY (product_id) REFERENCES [0DRUGSTORE8].dbo.ProductDict(product_id),
	CONSTRAINT Product$Product_ibfk_2 FOREIGN KEY (invoice_id) REFERENCES [0DRUGSTORE8].dbo.InvoiceHeader(invoice_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT Product$Product_ibfk_3 FOREIGN KEY (productStatus_id) REFERENCES [0DRUGSTORE8].dbo.PStatusDict(productStatus_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.ProductBuyPrice definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.ProductBuyPrice GO

CREATE TABLE [0DRUGSTORE8].dbo.ProductBuyPrice (
	barcode int NOT NULL,
	[start] date NOT NULL,
	buyPrice decimal(10,2) DEFAULT NULL NULL,
	finish date NULL,
	CONSTRAINT PK_ProductBuyPrice_barcode PRIMARY KEY (barcode,[start]),
	CONSTRAINT ProductBuyPrice$ProductBuyPrice_ibfk_1 FOREIGN KEY (barcode) REFERENCES [0DRUGSTORE8].dbo.Product(barcode) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.ProductSellPrice definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.ProductSellPrice GO

CREATE TABLE [0DRUGSTORE8].dbo.ProductSellPrice (
	barcode int NOT NULL,
	[start] date NOT NULL,
	sellPrice decimal(10,2) DEFAULT NULL NULL,
	finish date NULL,
	CONSTRAINT PK_ProductSellPrice_barcode PRIMARY KEY (barcode,[start]),
	CONSTRAINT ProductSellPrice$ProductSellPrice_ibfk_1 FOREIGN KEY (barcode) REFERENCES [0DRUGSTORE8].dbo.Product(barcode) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- [0DRUGSTORE8].dbo.ReservationDetail definition

-- Drop table

-- DROP TABLE [0DRUGSTORE8].dbo.ReservationDetail GO

CREATE TABLE [0DRUGSTORE8].dbo.ReservationDetail (
	barcode int NOT NULL,
	qty int DEFAULT NULL NULL,
	reservation_id int NOT NULL,
	CONSTRAINT PK_ReservationDetail_barcode PRIMARY KEY (barcode,reservation_id),
	CONSTRAINT ReservationDetail$ReservationDetail_ibfk_1 FOREIGN KEY (barcode) REFERENCES [0DRUGSTORE8].dbo.Product(barcode) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ReservationDetail$ReservationDetail_ibfk_2 FOREIGN KEY (reservation_id) REFERENCES [0DRUGSTORE8].dbo.ReservationHeader(reservation_id) ON DELETE CASCADE ON UPDATE CASCADE
) ;
