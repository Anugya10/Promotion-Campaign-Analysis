/*5. Create a report featuring the Top 5 products, ranked by Incremental Revenue Percentage(IR%), across all
campaigns. The report will provide essential information including product name, category, and ir%. This analysis
helps identify the most sucessful products in terms of incremental revenue across our campaigns, assisting in 
product optimization.*/
select product_name, category, 
     ROUND((SUM(CASE
            WHEN promo_type = 'BOGOF' THEN base_price * 0.5 * (`quantity_sold(after_promo)` * 2)
            WHEN promo_type = '500 Cashback' THEN (base_price - 500) * `quantity_sold(after_promo)`
            WHEN promo_type = '50% OFF' THEN base_price * 0.5 * `quantity_sold(after_promo)`
            WHEN promo_type = '33% OFF' THEN base_price * 0.67 * `quantity_sold(after_promo)`
            WHEN promo_type = '25% OFF' THEN base_price * 0.75 * `quantity_sold(after_promo)` else 0 end) - 
            SUM(base_price * `quantity_sold(before_promo)`)) * 100
            / SUM(base_price * `quantity_sold(before_promo)`),2) as `IR%`
from dim_products
join fact_events using (product_code)
group by product_name, category
order by `IR%` desc
limit 5;