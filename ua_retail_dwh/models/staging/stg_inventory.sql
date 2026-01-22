with source as (
        select * from {{ source('retail_raw', 'inventory') }}
  )

select
    cast(store_id as int64) as store_id,
    cast(product_id as int64) as product_id,
    cast(stock_qty as int64) as stock_qty,
    safe_cast(last_updated as date) as report_date

from source

    