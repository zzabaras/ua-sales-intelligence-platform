{{ config(
    materialized='table',
    partition_by={
      "field": "sale_date",
      "data_type": "date",
      "granularity": "day"
    }
) }}

-- Подключаем наши чистые Staging-модели
with sales as (
    select * from {{ ref('stg_sales') }}
),
products as (
    select * from {{ ref('stg_products') }}
),
external_factors as (
    select * from {{ ref('stg_external_factors') }}
),
logistics as (
    select * from {{ ref('stg_transport_expenses') }}
)

-- Основная сборка данных
select
    s.sale_id,
    s.sale_date,
    s.store_id,
    s.product_id,
    p.product_name,
    p.category_name,
    s.quantity,
    s.unit_price,
    s.payment_method,
    -- Финансовые показатели (UAH)
    s.total_revenue as revenue_uah,
    (s.quantity * p.purchase_cost) as cogs_uah, -- Себестоимость проданных товаров
    coalesce(l.logistics_cost_uah, 0) as logistics_cost_uah,
    
    -- Расчет чистой прибыли в гривне
    (s.total_revenue - (s.quantity * p.purchase_cost) - coalesce(l.logistics_cost_uah, 0)) as net_profit_uah,
    
    -- Интеграция внешних факторов (Валюта)
    e.exchange_rate_uah_usd,
    
    -- Пересчет прибыли в USD по курсу на день продажи
    round((s.total_revenue - (s.quantity * p.purchase_cost) - coalesce(l.logistics_cost_uah, 0)) / e.exchange_rate_uah_usd, 2) as net_profit_usd

from sales s
left join products p on s.product_id = p.product_id
left join external_factors e on s.sale_date = e.report_date
left join logistics l on s.sale_date = l.expense_date and s.store_id = l.store_id