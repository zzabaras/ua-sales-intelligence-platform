import pandas as pd
import numpy as np
import random
import os
from datetime import datetime

# --- ПРИНЦИП PRODUCTION-READY: Логгирование и структура ---

def generate_expanded_data():
    try:
        # Загружаем уже созданные базовые данные
        df_sales = pd.read_csv('data/sales.csv')
        df_products = pd.read_csv('data/products.csv')
        df_stores = pd.read_csv('data/stores.csv')
        df_ext = pd.read_csv('data/external_factors.csv')
        
        print("Начинаю генерацию дополнительных Enterprise-таблиц...")

        # 1. ГЕНЕРАЦИЯ CUSTOMERS (Клиенты)
        customer_names = ['Oleksandr', 'Maria', 'Ivan', 'Olena', 'Andriy', 'Natalia', 'Dmytro', 'Svitlana']
        customers_data = []
        for i in range(1, 501):  # 500 клиентов
            customers_data.append({
                'customer_id': i,
                'name': f"{random.choice(customer_names)} {chr(65 + random.randint(0, 25))}.",
                'city': random.choice(df_stores['city'].unique()),
                'segment': random.choice(['Regular', 'VIP', 'New']),
                'registration_date': '2024-01-01'
            })
        df_customers = pd.DataFrame(customers_data)

        # 2. ГЕНЕРАЦИЯ INVENTORY (Остатки на складах)
        # Делаем Snapshot: на каждый магазин и товар — случайное кол-во
        inventory_data = []
        for _, store in df_stores.iterrows():
            for _, product in df_products.iterrows():
                inventory_data.append({
                    'store_id': store['store_id'],
                    'product_id': product['product_id'],
                    'stock_qty': random.randint(10, 500),
                    'last_updated': '2025-04-07'
                })
        df_inventory = pd.DataFrame(inventory_data)

        # 3. ГЕНЕРАЦИЯ TRANSPORT_EXPENSES (Логистика)
        # Привязываем затраты к дате (через цену топлива) и магазину
        logistics_data = []
        for _, row in df_ext.iterrows():
            for _, store in df_stores.iterrows():
                # Базовая стоимость поездки зависит от региона + цена топлива
                distance_factor = random.uniform(50, 300) 
                fuel_price = row['fuel_price']
                expense = round(distance_factor * fuel_price * 0.1, 2)
                
                logistics_data.append({
                    'date': row['date'],
                    'store_id': store['store_id'],
                    'fuel_price_at_moment': fuel_price,
                    'transport_cost': expense,
                    'delivery_status': 'Delivered'
                })
        df_logistics = pd.DataFrame(logistics_data)

        # Сохранение новых файлов
        df_customers.to_csv('data/customers.csv', index=False)
        df_inventory.to_csv('data/inventory.csv', index=False)
        df_logistics.to_csv('data/transport_expenses.csv', index=False)

        print(f"✅ Успешно добавлено: {len(df_customers)} клиентов, "
              f"{len(df_inventory)} записей остатков и {len(df_logistics)} логистических транзакций.")

    except Exception as e:
        print(f"❌ Ошибка при генерации данных: {e}")

if __name__ == "__main__":
    generate_expanded_data()