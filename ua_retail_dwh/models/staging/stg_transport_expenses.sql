with source as (
        select * from {{ source('retail_raw', 'transport_expenses') }}
  )
select
    cast(date as date) as expense_date,
    cast(store_id as int64) as store_id,
    cast(fuel_price_at_moment as numeric) as fuel_price_at_moment,
    cast(transport_cost as numeric) as transport_cost,
    trim(delivery_status) as delivery_status
from source
