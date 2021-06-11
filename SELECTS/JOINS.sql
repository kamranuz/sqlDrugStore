select p.*, pd.name from Product p inner join ProductDict pd on p.product_id=pd.product_id;
select md.*, cd.name from ManufacturerDict md inner join CountryDict cd on cd.country_id=md.country_id;
select sd.*, cd.name from SupplierDict sd inner join CityDict cd on cd.city_id=cd.city_id;