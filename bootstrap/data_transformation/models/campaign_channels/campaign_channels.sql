with source as (

    select * from {{ source('demo', 'campaign_channels') }}

),

renamed as (

    select
        campaign_channel_id,
        category,
        type,
        budget,
        spend,
        campaign_id

    from source

)

select * from renamed