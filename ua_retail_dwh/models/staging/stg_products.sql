with source as (
        select * from {{ source('retail_raw', 'products') }}
  )
select
    cast(product_id as int64) as product_id,
    cast(sku_name as string) as product_name,
    cast(category as string) as category_name,
    cast(brand as string) as brand,
    cast(base_price as numeric) as purchase_cost
from source
    