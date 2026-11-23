WITH clientes_sem_compras AS (
SELECT
  *,
  DATE_DIFF(CURRENT_DATE('America/Sao_Paulo'), DATE(criado_em, 'America/Sao_Paulo'), DAY) AS dias_desde_cadastro
FROM
  {{ ref('dim_cliente') }}
WHERE
  ultimo_pedido IS NULL
)

SELECT
  cliente_id,
  nome,
  email,
  celular,
  conta_ativada,
  criado_em,
  uf,
  dias_desde_cadastro,
    CASE
    WHEN dias_desde_cadastro <= 10 THEN 'Até 10 dias'
    WHEN dias_desde_cadastro <= 30 THEN '11 a 30 dias'
    WHEN dias_desde_cadastro <= 60 THEN '31 a 60 dias'
    WHEN dias_desde_cadastro <= 120 THEN '61 a 120 dias'
    ELSE 'Mais de 120 dias'
  END AS faixa_de_tempo
FROM
  clientes_sem_compras