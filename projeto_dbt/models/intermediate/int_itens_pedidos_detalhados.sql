{{ config(labels={
    'camada': 'intermediate',
    'dominio': 'e-commerce',
    'ferramenta': 'dbt'
  })
}}

SELECT
  item.item_id,
  item.pedido_id,
  pedido.cliente_id,
  pedido.criado_em,
  pedido.atualizado_em,
  pedido.pedido_status,
  pedido.pagamento_status,
  item.variante_id,
  item.sku,
  item.nome_produto,
  item.quantidade,
  item.preco_unitario,
  item.quantidade * item.preco_unitario AS subtotal
FROM
  {{ ref('stg_itens_pedidos') }} AS item
JOIN
  {{ ref('stg_pedidos') }} AS pedido
    ON item.pedido_id = pedido.pedido_id

