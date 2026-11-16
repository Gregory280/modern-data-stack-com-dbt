SELECT
  DATE(criado_em, 'America/Sao_Paulo') AS data_pedido,
  COUNT(DISTINCT pedido_id) AS quantidade_pedidos,
  ROUND(SUM(subtotal), 2) AS valor_bruto
FROM
  {{ ref('fato_venda') }}
WHERE
  pedido_status IN ('Aberto', 'Fechado')
  AND pagamento_status = 'Pago'
  AND DATE(criado_em, 'America/Sao_Paulo') BETWEEN
  DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 7 DAY)
  AND DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 1 DAY)
GROUP BY DATE(criado_em, 'America/Sao_Paulo')
ORDER BY DATE(criado_em, 'America/Sao_Paulo') DESC