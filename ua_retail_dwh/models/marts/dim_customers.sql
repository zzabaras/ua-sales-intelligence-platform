{{ config(materialized='table') }}

select
    customer_id,
    name as customer_name,
    city,
    segment,
    registration_date
from {{ ref('stg_customers') }}