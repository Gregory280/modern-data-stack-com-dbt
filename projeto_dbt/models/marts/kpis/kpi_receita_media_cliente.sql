SELECT
  ROUND(SAFE_DIVIDE(SUM(subtotal), 
  COUNT(DISTINCT cliente_id)), 2) AS receita_media_cliente
FROM
  {{ ref('fato_venda') }}
WHERE
  pedido_status IN ('Aberto', 'Fechado') AND pagamento_status = 'Pago'