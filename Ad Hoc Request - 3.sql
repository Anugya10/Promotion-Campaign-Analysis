
/*3. Generate a report that displays each campaign along with the total revenue generated before and after the campaign? 
The report includes three key fields: 
campaign_name, total_revenue (before_promotion), total_revenue(after_promotion). This report should help
in evaluating the financial impact of our promotional campaigns.*/
SELECT 
     campaign_name,
     ROUND(SUM(base_price * `quantity_sold(before_promo)`) / 1000000,2) AS total_revenue_before_promotion,
     ROUND(SUM(CASE
            WHEN promo_type = 'BOGOF' THEN base_price * 0.5 * (`quantity_sold(after_promo)` * 2)
            WHEN promo_type = '500 Cashback' THEN (base_price - 500) * `quantity_sold(after_promo)`
            WHEN promo_type = '50% OFF' THEN base_price * 0.5 * `quantity_sold(after_promo)`
            WHEN promo_type = '33% OFF' THEN base_price * 0.67 * `quantity_sold(after_promo)`
            WHEN promo_type = '25% OFF' THEN base_price * 0.75 * `quantity_sold(after_promo)` END) / 1000000,2) AS total_revenue_after_promotion
     FROM
     fact_events
     JOIN
     dim_campaigns USING (campaign_id)
     GROUP BY campaign_name;