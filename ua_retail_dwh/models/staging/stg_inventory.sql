with source as (
        select * from {{ source('retail_raw', 'inventory') }}
  )

select
    cast(store_id as int64) as store_id,
    cast(product_id as int64) as product_id,
    cast(stock_qty as int64) as stock_qty,
    cast(last_updated as timestamp) as last_updated

from source

    