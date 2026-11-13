SELECT
  ROUND(SUM(subtotal) / COUNT(DISTINCT pedido_id), 2) AS ticket_medio
FROM
  {{ ref('fato_venda') }}
WHERE
  pedido_status IN ('Fechado', 'Aberto') AND pagamento_status = 'Pago'