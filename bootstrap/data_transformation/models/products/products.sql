with source as (

    select * from {{ source('demo', 'products') }}

),

renamed as (

    select
        product_id,
        product_name,
        category

    from source

)

select * from renamed