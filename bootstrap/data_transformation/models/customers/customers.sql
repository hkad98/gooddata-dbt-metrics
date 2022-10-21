with source as (

    select * from {{ source('demo', 'customers') }}

),

renamed as (

    select
        customer_id,
        customer_name,
        state,
        region,
        geo__state__location

    from source

)

select * from renamed