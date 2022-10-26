with customer_group as (
    SELECT customer_id, sum(revenue) AS revenue_sum
    FROM {{ metrics.calculate(
        metric('revenue'),
        grain='day',
        dimensions=['customer_id']
    ) }}
    GROUP BY customer_id
),

product_group as (
    SELECT customer_id, product_name, category, sum(revenue) AS revenue_sum
    FROM {{ metrics.calculate(
        metric('revenue'),
        grain='day',
        dimensions=['customer_id', 'product_name', 'category']
    ) }}
    GROUP BY customer_id, product_name, category
),

customer_top_10_percent as (
    SELECT 
    b.customer_id,
	b.revenue_sum AS revenue
	FROM 
    (SELECT 
        a.customer_id,
        a.revenue_sum,
        PERCENT_RANK() OVER (
            ORDER BY a.revenue_sum DESC NULLS LAST
        ) AS r FROM (
            SELECT * FROM customer_group
            ) AS a) AS b
    WHERE b.r <= 0.1
),

result as (
    SELECT 
        a.category,
        a.product_name,
        a.top10percent / a.product_revenue_sum AS ratio
    FROM (
    SELECT 
        SUM(CASE WHEN c.customer_id IS NOT NULL THEN p.revenue_sum END) as top10percent,
        SUM(p.revenue_sum) as product_revenue_sum,
        p.product_name,
        p.category
    FROM 
        product_group p
    LEFT OUTER JOIN customer_top_10_percent c
    ON p.customer_id = c.customer_id
    GROUP BY p.product_name, p.category
    ) AS a
)

SELECT * FROM result
