SELECT 
  COUNT(pedido_id) AS total_pedidos_cancelados
FROM 
  {{ ref('fato_venda') }}
WHERE 
  pedido_status = 'cancelled'