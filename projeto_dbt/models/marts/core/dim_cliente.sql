{{ config(labels={
    'camada': 'marts-core',
    'dominio': 'e-commerce',
    'ferramenta': 'dbt'
  })
}}

SELECT
  cliente_id,
  nome,
  email,
  celular,
  conta_ativada,
  criado_em,
  atualizado_em,
  endereco,
  cidade,
  estado,
  uf,
  total_gasto,
  ultimo_pedido
FROM
  {{ ref('stg_clientes') }}