{{ config(labels={
    'camada': 'staging',
    'dominio': 'e-commerce',
    'ferramenta': 'dbt'
  })
}}

SELECT
  variante.id AS variante_id,
  produto.id AS produto_id,
  produto.category AS categoria,
  produto.model AS modelo,
  produto.color AS cor,
  produto.name AS nome,
  variante.size AS tamanho,
  variante.sku AS sku,
  SAFE_CAST(produto.price AS NUMERIC) AS preco
FROM
  {{ source('raw', 'produtos') }} AS produto
CROSS JOIN UNNEST(produto.variants) AS variante