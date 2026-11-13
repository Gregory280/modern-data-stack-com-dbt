SELECT 
  COUNT(cliente_id) AS total_clientes_compradores
FROM
  {{ ref('dim_cliente') }}
WHERE 
  ultimo_pedido IS NOT NULL
