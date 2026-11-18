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
  AND DATE(fv.criado_em, 'America/Sao_Paulo') BETWEEN 
    DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 7 DAY)
    AND DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 1 DAY)
GROUP BY
  dp.categoria
ORDER BY
  valor_bruto DESC