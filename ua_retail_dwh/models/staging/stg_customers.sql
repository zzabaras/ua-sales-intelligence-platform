with source as (
        select * from {{ source('retail_raw', 'customers') }}
  )

select
    cast(customer_id as int64) as customer_id,
    cast(name as string) as name,
    cast(city as string) as city,
    cast(segment as string) as segment,
    cast(registration_date as date) as registration_date
from source

    