with source as (
        select * from {{ source('retail_raw', 'external_factors') }}
  )

select
    cast(date as date) as report_date,
    cast(usd_rate as numeric) as exchange_rate_uah_usd,
    cast(fuel_price as numeric) as fuel_price,
    cast(avg_temp as numeric) as average_temperature_celsius
from source
