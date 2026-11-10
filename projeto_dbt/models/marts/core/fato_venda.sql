{{ config(labels={
    'camada': 'marts-core',
    'dominio': 'e-commerce',
    'ferramenta': 'dbt'
  })
}}

SELECT
  item_id,
  pedido_id,
  cliente_id,
  criado_em,
  atualizado_em,
  pedido_status,
  pagamento_status,
  variante_id,
  sku,
  nome_produto,
  quantidade,
  preco_unitario,
  subtotal
FROM
  {{ ref('int_itens_pedidos_detalhados') }}