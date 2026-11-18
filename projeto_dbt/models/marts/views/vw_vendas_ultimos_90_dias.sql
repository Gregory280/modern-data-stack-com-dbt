SELECT
  fv.item_id,
  fv.pedido_id,
  fv.cliente_id,
  dc.nome,
  dc.estado,
  dc.uf,
  fv.criado_em,
  fv.atualizado_em,
  fv.pedido_status,
  fv.pagamento_status,
  fv.variante_id,
  fv.sku,
  fv.nome_produto,
  dp.categoria,
  dp.modelo,
  dp.cor,
  dp.tamanho,
  fv.quantidade,
  fv.preco_unitario,
  fv.subtotal
FROM 
  {{ ref('fato_venda') }} AS fv
JOIN
  {{ ref('dim_produto') }} AS dp
    ON fv.variante_id = dp.variante_id
JOIN
  {{ ref('dim_cliente') }} AS dc
    ON fv.cliente_id = dc.cliente_id
WHERE DATE(criado_em, 'America/Sao_Paulo') BETWEEN
    DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 89 DAY)
    AND CURRENT_DATE('America/Sao_Paulo')