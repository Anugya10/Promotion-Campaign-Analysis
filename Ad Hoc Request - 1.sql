
/*1. Provide a list of products with a base price greater than 500 and that are featured in 
promo type of "BOGOF" (Buy One Get One Free). This information will help us identify high-value products that are currently being
heavily dsicounted, which can be useful for evaluting our pricing and promotion strategies*/
Select distinct(f.product_code), p.product_name, promo_type, base_price
from fact_events f
join dim_products p on f.product_code = p.product_code
Where f.base_price > 500 and f.promo_type = "BOGOF";