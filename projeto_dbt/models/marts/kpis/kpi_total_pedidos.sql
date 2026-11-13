SELECT
  COUNT(DISTINCT pedido_id) AS pedidos_total
FROM  
  {{ ref('fato_venda') }}