with source as (

    select 
        o.order_line_id,
        o.order_id,
        o.order_status,
        o.date,
        o.campaign_id,
        o.customer_id,
        o.product_id,
        o.price,
        o.quantity,
        c.customer_name,
        c.state,
        c.region,
        p.product_name,
        p.category
    from {{ source('demo', 'order_lines') }} o 
    join {{ source('demo', 'customers') }} c on o.customer_id = c.customer_id
    join {{ source('demo', 'products') }} p on p.product_id = o.product_id

),

renamed as (

    select
        order_line_id,
        order_id,
        order_status,
        date,
        campaign_id,
        customer_id,
        product_id,
        price,
        quantity,
        customer_name,
        state,
        region,
        product_name,
        category
    from source

)

select * from renamed