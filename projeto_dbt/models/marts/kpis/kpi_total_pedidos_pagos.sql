SELECT
  COUNT(DISTINCT pedido_id) AS pedidos_total
FROM  
  {{ ref('fato_venda') }}
WHERE
  pedido_status IN ('closed', 'open') AND pagamento_status = 'paid'