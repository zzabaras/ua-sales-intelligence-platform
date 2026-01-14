with source as (
        select * from {{ source('retail_raw', 'stores') }}
  )

select
    cast(store_id as int64) as store_id,
    cast(store_name as string) as store_name,
    cast(city as string) as city,
    cast(region as string) as region,
    cast(format as string) as format
from source

    