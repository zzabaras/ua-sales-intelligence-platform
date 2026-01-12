# Data Architecture (Enterprise Level)

Проект имитирует структуру реальной ERP-системы, разбитую на функциональные домены. 

## 1. Sales & Retail Domain (Core)
- **sales / sale_items**: Транзакции чеков.
- **stores**: География и форматы точек.
- **customers**: Данные программы лояльности.

## 2. Product & Inventory Domain
- **products / categories / brands**: Глубокая иерархия товаров.
- **inventory**: Ежедневные остатки (Snapshot).

## 3. Logistics & Finance Domain
- **transport_expenses**: Затраты на логистику (связаны с ценой топлива).
- **product_prices**: История изменения цен и маржи.

## 4. External Intelligence (Context)
- **ext_currency_rates**: Курс НБУ (USD/UAH).
- **ext_weather_data**: Метеоусловия в регионах.