/*4. Produce a report that calculates the Incremental Sold Quantity(ISU%) for each category during the Diwali campaign.
Additionally, provide rankings for the categories based on their ISU%. The report will include three key fields:
category, ISU%, and rank order. This information will assist in assessing the category-wise success and imapct of the 
Diwali campaign on incremental sales.*/
With Diwali_promotions as (
select category, 
round(sum((case
           when promo_type = 'BOGOF' then `quantity_sold(after_promo)` * 2
           else `quantity_sold(after_promo)` 
           END
	- `quantity_sold(before_promo)`) * 100) / 
    Sum(`quantity_sold(before_promo)`), 2) as 'ISU%'
from fact_events
join dim_products using (product_code)
join dim_campaigns using (campaign_id)
where campaign_name = "Diwali"
group by category)
Select category, `ISU%`, 
row_number() over(order by `ISU%` desc) as rank_order
from Diwali_promotions;