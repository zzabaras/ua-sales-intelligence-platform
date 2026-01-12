import pandas as pd
import requests
import time
from datetime import datetime

def get_nbu_rate(date_str):
    """Получает курс USD от НБУ на конкретную дату."""
    # Формат даты для НБУ: YYYYMMDD
    formatted_date = date_str.replace('-', '')
    url = f"https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?valcode=USD&date={formatted_date}&json"
    
    try:
        response = requests.get(url)
        data = response.json()
        if data:
            return data[0]['rate']
    except Exception as e:
        print(f"Ошибка при запросе курса на {date_str}: {e}")
    return 41.5  # Дефолтный курс, если API упал

def fetch_external_data():
    # Загружаем даты из наших продаж, чтобы знать, за какие дни искать данные
    sales = pd.read_csv('data/sales.csv')
    unique_dates = sales['date'].unique()
    
    external_records = []
    
    print(f"Начинаю сбор данных за {len(unique_dates)} дней...")

    for date in sorted(unique_dates):
        print(f"Обработка даты: {date}")
        
        # 1. Получаем реальный курс НБУ
        usd_rate = get_nbu_rate(date)
        
        # 2. Имитируем цену топлива (привязка к курсу + небольшой шум)
        # В реальности это мог бы быть парсинг minfin.com.ua
        fuel_price = round(usd_rate * 1.35 + random.uniform(-1, 1), 2)
        
        # 3. Имитируем погоду (зависит от месяца)
        month = datetime.strptime(date, '%Y-%m-%d').month
        if month in [12, 1, 2]: temp = random.uniform(-10, 2)
        elif month in [6, 7, 8]: temp = random.uniform(20, 32)
        else: temp = random.uniform(8, 18)
        
        external_records.append({
            'date': date,
            'usd_rate': usd_rate,
            'fuel_price': fuel_price,
            'avg_temp': round(temp, 1)
        })
        
        # Небольшая пауза, чтобы не спамить API НБУ
        time.sleep(0.1)

    df_ext = pd.DataFrame(external_records)
    df_ext.to_csv('data/external_factors.csv', index=False)
    print("✅ Файл external_factors.csv создан!")

import random # добавим для шума в топливе
if __name__ == "__main__":
    fetch_external_data()