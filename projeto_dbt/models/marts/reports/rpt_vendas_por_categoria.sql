SELECT
  dp.categoria,
  ROUND(SUM(fv.subtotal), 2) AS valor_bruto
FROM
 {{ ref('fato_venda' )}} AS fv
JOIN
  {{ ref('dim_produto') }} AS dp
    ON fv.variante_id = dp.variante_id
WHERE
  fv.pedido_status in ('Aberto', 'Fechado') AND fv.pagamento_status = 'Pago'
GROUP BY
  dp.categoria
ORDER BY
  valor_bruto DESC