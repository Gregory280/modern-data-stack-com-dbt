{{ config(labels={
    'camada': 'intermediate',
    'dominio': 'e-commerce',
    'ferramenta': 'dbt'
  })
}}

SELECT
  produto.variante_id,
  produto.produto_id,
  produto.categoria,
  produto.modelo,
  produto.cor,
  produto.nome,
  produto.tamanho,
  produto.sku,
  produto.preco,
  CONCAT(produto.categoria, ' ', produto.modelo) AS nome_modelo,
  CONCAT(produto.nome, ' . ', CAST(produto.tamanho AS STRING))  AS nome_variante
FROM
  {{ ref('stg_produtos') }} AS produto