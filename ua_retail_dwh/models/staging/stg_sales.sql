-- Принцип Production-Ready: явное перечисление колонок и приведение типов
with raw_sales as (
    select * from {{ source('retail_raw', 'sales') }}
)

select
    -- Превращаем ID в строки для консистентности (опционально)
    cast(sale_id as string) as sale_id,
    cast(date as date) as sale_date,
    cast(store_id as int64) as store_id,
    cast(product_id as int64) as product_id,
    
    -- Бизнес-метрики
    cast(quantity as int64) as quantity,
    cast(unit_price as numeric) as unit_price,
    cast(total_amount as numeric) as total_revenue,
    
    -- Очистка текста
    trim(payment_type) as payment_method

from raw_sales

