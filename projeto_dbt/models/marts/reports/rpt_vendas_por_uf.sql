SELECT
  dc.uf,
  COUNT(DISTINCT fv.pedido_id) AS qtd_pedidos,
  COUNT(DISTINCT fv.cliente_id) AS qtd_clientes,
  SUM(fv.quantidade) AS qtd_vendida,
  SUM(subtotal) AS valor_total
FROM
  {{ ref('fato_venda') }} AS fv
JOIN
  `marts.dim_cliente` AS dc
    ON fv.cliente_id = dc.cliente_id
WHERE
  pedido_status IN ('Aberto', 'Fechado')
  AND pagamento_status = 'Pago'
GROUP BY
  dc.uf
ORDER BY
  valor_total DESC


