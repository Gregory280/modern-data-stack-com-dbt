SELECT
  COUNT(DISTINCT pedido_id) AS pedidos_total
FROM  
  {{ ref('fato_venda') }}
WHERE
  pedido_status IN ('Fechado', 'Aberto') AND pagamento_status = 'Pago'