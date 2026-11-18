SELECT
  DATE(fv.criado_em, 'America/Sao_Paulo') AS data_pedido,
  COUNT(DISTINCT fv.pedido_id) AS qtd_pedidos,
  SUM(fv.quantidade) AS qtd_vendida,
  SUM(fv.subtotal) AS valor_bruto
FROM
  {{ ref('fato_venda') }} AS fv
WHERE
  pedido_status IN ('Aberto', 'Fechado') AND pagamento_status = 'Pago'
  AND DATE(fv.criado_em, 'America/Sao_Paulo') BETWEEN
  DATE_TRUNC(CURRENT_DATE('America/Sao_Paulo'), MONTH)
  AND CURRENT_DATE('America/Sao_Paulo')
GROUP BY
  data_pedido
ORDER BY
  data_pedido DESC