{{ config(labels={
    'camada': 'staging',
    'dominio': 'e-commerce',
    'ferramenta': 'dbt'
  })
}}

SELECT
  item_id,
  order_id AS pedido_id,
  product_id AS produto_id,
  variant_id AS variante_id,
  product_name AS nome_produto,
  sku,
  quantity AS quantidade,
  SAFE_CAST(unit_price AS NUMERIC) AS preco_unitario
FROM
  {{ source('raw', 'itens_pedidos') }}