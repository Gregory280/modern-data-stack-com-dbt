SELECT
  dp.nome_modelo,
  SUM(quantidade) AS qtd_vendida,
  SUM(subtotal) AS valor_bruto
FROM
  {{ ref('fato_venda') }} AS fv
JOIN
  {{ ref('dim_produto' ) }} AS dp ON fv.variante_id = dp.variante_id
WHERE
  pedido_status IN ('Aberto', 'Fechado')
  AND pagamento_status = 'Pago'
  AND DATE(fv.criado_em, 'America/Sao_Paulo') BETWEEN 
    DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 7 DAY)
    AND DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 1 DAY)
GROUP BY
  dp.nome_modelo
