-- "Замените YOUR_BUCKET_NAME на имя вашего бакета"


-- Создание таблицы продаж (Core Fact)
CREATE OR REPLACE EXTERNAL TABLE `retail_raw.sales`
OPTIONS (
  format = 'CSV',
  uris = ['gs://YOUR_BUCKET_NAME/raw/sales.csv'],
  skip_leading_rows = 1
);

-- Создание таблицы товаров (Dimension)
CREATE OR REPLACE EXTERNAL TABLE `retail_raw.products`
OPTIONS (
  format = 'CSV',
  uris = ['gs://YOUR_BUCKET_NAME/raw/products.csv'],
  skip_leading_rows = 1
);

-- Создание таблицы магазинов (Dimension)
CREATE OR REPLACE EXTERNAL TABLE `retail_raw.stores`
OPTIONS (
  format = 'CSV',
  uris = ['gs://YOUR_BUCKET_NAME/raw/stores.csv'],
  skip_leading_rows = 1
);

-- Создание таблицы внешних факторов (Context)
CREATE OR REPLACE EXTERNAL TABLE `retail_raw.external_factors`
OPTIONS (
  format = 'CSV',
  uris = ['gs://YOUR_BUCKET_NAME/raw/external_factors.csv'],
  skip_leading_rows = 1
);

-- Создание таблицы логистики (Context)
CREATE OR REPLACE EXTERNAL TABLE `retail_raw.transport_expenses`
OPTIONS (
  format = 'CSV',
  uris = ['gs://YOUR_BUCKET_NAME/raw/transport_expenses.csv'],
  skip_leading_rows = 1
);

-- Создание таблицы остатков на складах (Context)
CREATE OR REPLACE EXTERNAL TABLE `retail_raw.inventory`
OPTIONS (
  format = 'CSV',
  uris = ['gs://YOUR_BUCKET_NAME/raw/inventory.csv'],
  skip_leading_rows = 1
);

-- Создание таблицы клиентов (Dimension)
CREATE OR REPLACE EXTERNAL TABLE `retail_raw.customers`
OPTIONS (
  format = 'CSV',
  uris = ['gs://YOUR_BUCKET_NAME/raw/customers.csv'],
  skip_leading_rows = 1
);

-- Создание таблицы расходов на логистику (Context)
CREATE OR REPLACE EXTERNAL TABLE `retail_raw.transport_expenses`
OPTIONS (
  format = 'CSV',
  uris = ['gs://YOUR_BUCKET_NAME/raw/transport_expenses.csv'],
  skip_leading_rows = 1
);