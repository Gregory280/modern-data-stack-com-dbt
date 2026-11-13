SELECT
  COUNT(DISTINCT cliente_id) AS total_clientes
FROM 
  {{ ref('dim_cliente') }}