WITH
  receita_mtd_atual AS (
    SELECT
      ROUND(SUM(subtotal), 2) AS receita_mtd_atual
    FROM
      {{ ref('fato_venda') }}
    WHERE
      DATE(criado_em) >= DATE_TRUNC(CURRENT_DATE('America/Sao_Paulo'), MONTH) 
      AND DATE(criado_em) <= CURRENT_DATE('America/Sao_Paulo') 
      AND pedido_status in ('Aberto', 'Fechado') 
      AND pagamento_status = 'Pago'

  ),

  receita_mtd_anterior AS (
    SELECT
      ROUND(SUM(subtotal), 2) AS receita_mtd_anterior
    FROM
      {{ ref('fato_venda') }}
    WHERE
      DATE(criado_em) >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH), MONTH) 
      AND DATE(criado_em) <= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH) 
      AND pedido_status in ('Aberto', 'Fechado') 
      AND pagamento_status = 'Pago'
  )

SELECT
  atual.receita_mtd_atual,
  anterior.receita_mtd_anterior,
  SAFE_DIVIDE(atual.receita_mtd_atual - anterior.receita_mtd_anterior, anterior.receita_mtd_anterior) AS variacao_percentual

FROM
  receita_mtd_atual AS atual
CROSS JOIN receita_mtd_anterior AS anterior