WITH vendas_diarias AS (
    SELECT
        DATE(criado_em, 'America/Sao_Paulo') AS data_pedido,
        COUNT(DISTINCT pedido_id) AS quantidade_pedidos,
        ROUND(SUM(subtotal), 2) AS valor_total
    FROM {{ ref('fato_venda') }}
    WHERE pedido_status IN ('Aberto', 'Fechado')
      AND pagamento_status = 'Pago'
      AND DATE(criado_em, 'America/Sao_Paulo') BETWEEN
          DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 7 DAY)
          AND DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 1 DAY)
    GROUP BY data_pedido
)

SELECT
    calendario.data AS data_pedido,
    CASE calendario.dia_semana
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Segunda-feira'
        WHEN 3 THEN 'Terça-feira'
        WHEN 4 THEN 'Quarta-feira'
        WHEN 5 THEN 'Quinta-feira'
        WHEN 6 THEN 'Sexta-feira'
        WHEN 7 THEN 'Sábado'
    END AS nome_dia_semana,
    COALESCE(vendas.quantidade_pedidos, 0) AS quantidade_pedidos,
    COALESCE(vendas.valor_total, 0) AS valor_total
FROM {{ ref('dim_data') }} AS calendario
LEFT JOIN vendas_diarias AS vendas
    ON calendario.data = vendas.data_pedido
WHERE calendario.data BETWEEN
    DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 7 DAY)
    AND DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 1 DAY)
ORDER BY data_pedido