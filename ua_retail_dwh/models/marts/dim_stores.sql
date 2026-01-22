{{ config(materialized='table') }}

select
    store_id,
    store_name, 
    format as store_type,
    city as store_city,
    region
from {{ ref('stg_stores') }}
