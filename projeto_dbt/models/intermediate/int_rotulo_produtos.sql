{{ config(labels={
    'camada': 'intermediate',
    'dominio': 'e-commerce',
    'ferramenta': 'dbt'
  })
}}

SELECT
  variante_id,
  produto_id,
  categoria,
  modelo,
  cor,
  nome,
  tamanho,
  sku,
  preco,
  CONCAT(categoria, ' ', modelo) AS nome_modelo,
  CONCAT(nome, ' . ', CAST(tamanho AS STRING))  AS nome_variante
FROM
  {{ ref('stg_produtos') }}