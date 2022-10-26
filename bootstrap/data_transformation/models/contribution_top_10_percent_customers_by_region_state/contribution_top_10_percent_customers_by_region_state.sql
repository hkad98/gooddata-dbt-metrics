with customer_group as (
    SELECT customer_id, state, region, sum(revenue) AS revenue_sum
    FROM {{ metrics.calculate(
        metric('revenue'),
        grain='day',
        dimensions=['customer_id', 'state', 'region']
    ) }}
    GROUP BY customer_id, state, region
),

region_group as (
    SELECT state, region, sum(revenue) AS revenue_sum
    FROM {{ metrics.calculate(
        metric('revenue'),
        grain='day',
        dimensions=['state', 'region']
    ) }}
    GROUP BY state, region
),

customer_top_10_percent_region_state as (
    SELECT 
    SUM(b.revenue_sum) AS revenue,
    b.state,
    b.region
	FROM 
    (SELECT 
        a.customer_id,
        a.revenue_sum,
        a.state,
        a.region,
        PERCENT_RANK() OVER (
            ORDER BY a.revenue_sum DESC NULLS LAST
        ) AS r FROM (
            SELECT * FROM customer_group
            ) AS a) AS b
    WHERE b.r <= 0.1
    GROUP BY b.state, b.region
),

result as (
    SELECT 
        c.state,
        c.region,
        c.revenue / r.revenue_sum AS ratio
    FROM 
        customer_top_10_percent_region_state c
    JOIN region_group r
    ON r.state = c.state
)


SELECT * FROM result
