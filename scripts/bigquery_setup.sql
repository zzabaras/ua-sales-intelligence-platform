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