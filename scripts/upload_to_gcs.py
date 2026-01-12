from google.cloud import storage
import os

# Укажи свои данные
BUCKET_NAME = 'ua-retail-raw-data-zabaras'
KEY_PATH = 'gcp-key.json'

def upload_files():
    # Авторизация
    client = storage.Client.from_service_account_json(KEY_PATH)
    bucket = client.get_bucket(BUCKET_NAME)
    
    data_folder = 'data/'
    files = [f for f in os.listdir(data_folder) if f.endswith('.csv')]
    
    for file_name in files:
        blob = bucket.blob(f"raw/{file_name}")
        blob.upload_from_filename(f"{data_folder}{file_name}")
        print(f"🚀 Файл {file_name} успешно загружен в GCP!")

if __name__ == "__main__":
    upload_files()