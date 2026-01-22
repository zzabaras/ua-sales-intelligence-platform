{{ config(
    materialized='table',
    partition_by={
      "field": "report_date",
      "data_type": "date"
    }
) }}

with inventory as (
    select * from {{ ref('stg_inventory') }}
),

products as (
    select * from {{ ref('stg_products') }}
)

select
    i.store_id,
    i.product_id,
    p.product_name,
    p.category_name,
    p.brand,
    p.purchase_cost,
    i.stock_qty,
    
    -- Стоимость остатков на складе (в закупочных ценах)
    round(i.stock_qty * p.purchase_cost, 2) as inventory_value_uah,
    
    -- Бизнес-логика: Флаги для алертов
    case 
        when i.stock_qty = 0 then 'Out of Stock'
        when i.stock_qty <= 10 then 'Low Stock'
        else 'Healthy Stock'
    end as stock_status,
    
    cast(i.report_date as date) as report_date

from inventory i
left join products p on i.product_id = p.product_id