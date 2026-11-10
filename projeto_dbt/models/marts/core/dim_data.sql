{{ config(labels={
    'camada': 'marts-core',
    'ferramenta': 'dbt'
  })
}}

WITH CALENDARIO AS (
  SELECT DATA
  FROM UNNEST(
    GENERATE_DATE_ARRAY(
      DATE('2025-01-01'),
      DATE('2029-12-31'),
      INTERVAL 1 DAY
    )
  ) AS DATA
)

SELECT
  data AS data,
  EXTRACT(YEAR FROM data) AS ano,
  FORMAT_DATE('%Y-%m', DATA) AS ano_mes,
  EXTRACT(QUARTER FROM data) AS trimestre,
  EXTRACT(MONTH FROM data) AS mes,
  FORMAT_DATE('%B', data) AS nome_mes,
  EXTRACT(DAY FROM data) AS dia,
  EXTRACT(DAYOFWEEK FROM data) AS dia_semana
FROM
  CALENDARIO