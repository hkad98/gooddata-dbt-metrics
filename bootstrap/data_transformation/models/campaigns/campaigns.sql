with source as (

    select * from {{ source('demo', 'campaigns') }}

),

renamed as (

    select
        campaign_id,
        campaign_name

    from source

)

select * from renamed