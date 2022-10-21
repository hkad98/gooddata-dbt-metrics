with source as (

    select * from {{ source('demo', 'order_lines') }}

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
        wdf__state,
        wdf__region

    from source

)

select * from renamed