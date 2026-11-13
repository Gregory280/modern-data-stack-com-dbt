SELECT
  ROUND(
    SAFE_DIVIDE(
      (SELECT total_clientes_compradores FROM {{ ref('kpi_total_clientes_compradores') }}),
      (SELECT total_clientes FROM {{ ref('kpi_total_clientes') }})
    ) * 100, 2) AS taxa_clientes_compradores