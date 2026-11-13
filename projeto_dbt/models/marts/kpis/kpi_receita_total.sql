SELECT
  SUM(subtotal) AS receita_total
FROM
  {{ ref('fato_venda') }}
WHERE
  pedido_status IN ('Fechado', 'Aberto') AND pagamento_status = 'Pago'
