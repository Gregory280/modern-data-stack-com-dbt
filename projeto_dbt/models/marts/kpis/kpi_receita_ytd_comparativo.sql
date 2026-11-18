WITH
  receita_ytd_atual AS (
    SELECT
      ROUND(SUM(subtotal), 2) AS receita_ytd_atual
    FROM
      {{ ref('fato_venda') }}
    WHERE
      DATE(criado_em, 'America/Sao_Paulo') >= DATE_TRUNC(CURRENT_DATE('America/Sao_Paulo'), YEAR)
      AND DATE(criado_em, 'America/Sao_Paulo') <= CURRENT_DATE('America/Sao_Paulo')
      AND pedido_status IN ('Aberto', 'Fechado')
      AND pagamento_status = 'Pago'
  ),

  receita_ytd_anterior AS (
    SELECT
      ROUND(SUM(subtotal), 2) AS receita_ytd_anterior
    FROM
      {{ ref('fato_venda') }}
    WHERE
      DATE(criado_em, 'America/Sao_Paulo') >= DATE_TRUNC(DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 1 YEAR), YEAR)
      AND DATE(criado_em, 'America/Sao_Paulo') <= DATE_SUB(CURRENT_DATE('America/Sao_Paulo'), INTERVAL 1 YEAR)
      AND pedido_status IN ('Aberto', 'Fechado')
      AND pagamento_status = 'Pago'
  )

SELECT
  atual.receita_ytd_atual,
  anterior.receita_ytd_anterior,
  SAFE_DIVIDE(atual.receita_ytd_atual - anterior.receita_ytd_anterior, anterior.receita_ytd_anterior) AS variacao_percentual
FROM
  receita_ytd_atual AS atual
CROSS JOIN receita_ytd_anterior AS anterior