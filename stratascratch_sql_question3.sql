-- Number of Shipments Per Month
-- Write a query that will calculate the number of shipments per month. The unique key for one shipment is a combination of shipment_id and sub_id. Output the year_month in format YYYY-MM and the number of shipments in that month.

-- Table: amazon_shipment

-- shipment_id: int 
-- sub_id: int 
-- weight: int 
-- shipment_date: datetime

SELECT CONCAT(YEAR(shipment_date), '-', MONTH(shipment_date)) AS year_month, COUNT(*) AS shipment_count
FROM amazon_shipment
GROUP BY YEAR(shipment_date), MONTH(shipment_date)
ORDER BY YEAR(shipment_date), MONTH(shipment_date);