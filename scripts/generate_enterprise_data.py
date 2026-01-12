import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# --- 1. ГЕОГРАФИЯ И МАГАЗИНЫ ---
regions = {
    'Kyiv': 'Northern',
    'Lviv': 'Western',
    'Odesa': 'Southern',
    'Dnipro': 'Central',
    'Kharkiv': 'Eastern'
}

stores_data = []
for i, (city, region) in enumerate(regions.items(), 1):
    stores_data.append({
        'store_id': i,
        'store_name': f"Store {city} #{random.randint(10, 99)}",
        'city': city,
        'region': region,
        'format': random.choice(['Supermarket', 'Hypermarket', 'Mini-market'])
    })
df_stores = pd.DataFrame(stores_data)

# --- 2. КАТАЛОГ ТОВАРОВ ---
categories = {
    'Electronics': ['Smartphone', 'Laptop', 'Charger'],
    'Food': ['Bread', 'Milk', 'Cheese', 'Apples'],
    'Apparel': ['T-shirt', 'Jeans', 'Jacket']
}

products_data = []
p_id = 1
for cat, items in categories.items():
    for item in items:
        products_data.append({
            'product_id': p_id,
            'sku_name': item,
            'category': cat,
            'brand': random.choice(['Brand_A', 'Brand_B', 'Local_Hero']),
            'base_price': round(random.uniform(20, 2000), 2)
        })
        p_id += 1
df_products = pd.DataFrame(products_data)

# --- 3. ГЕНЕРАЦИЯ ПРОДАЖ (FACTS) ---
sales_data = []
start_date = datetime(2025, 1, 1)

for _ in range(5000):  # Генерируем 5000 строк продаж
    order_date = start_date + timedelta(days=random.randint(0, 365))
    store = df_stores.sample(1).iloc[0]
    product = df_products.sample(1).iloc[0]
    
    quantity = random.randint(1, 5)
    # Имитируем небольшую наценку или скидку
    unit_price = round(product['base_price'] * random.uniform(0.9, 1.2), 2)
    total_amount = round(quantity * unit_price, 2)
    
    sales_data.append({
        'sale_id': _,
        'date': order_date.strftime('%Y-%m-%d'),
        'store_id': store['store_id'],
        'product_id': product['product_id'],
        'quantity': quantity,
        'unit_price': unit_price,
        'total_amount': total_amount,
        'payment_type': random.choice(['Card', 'Cash', 'NFC'])
    })

df_sales = pd.DataFrame(sales_data)

# --- СОХРАНЕНИЕ ---
import os
os.makedirs('data', exist_ok=True)

df_stores.to_csv('data/stores.csv', index=False)
df_products.to_csv('data/products.csv', index=False)
df_sales.to_csv('data/sales.csv', index=False)

print(f"✅ Успешно создано: {len(df_stores)} магазинов, {len(df_products)} товаров и {len(df_sales)} транзакций.")