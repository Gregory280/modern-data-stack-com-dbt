{{ config(labels={
    'camada': 'marts-core',
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
  nome_modelo,
  nome_variante
FROM
  {{ ref('int_rotulo_produtos') }}