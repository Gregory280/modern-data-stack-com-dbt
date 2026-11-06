SELECT
  id AS cliente_id,
  TRIM(name) AS nome,
  LOWER(email) AS email,
  phone AS celular,
  active AS conta_ativada,
  created_at AS criado_em,
  updated_at AS atualizado_em,
  default_address.address AS endereco,
  default_address.city AS cidade,
  default_address.province AS estado,
  CASE UPPER(TRIM(default_address.province))
    WHEN 'ACRE' THEN 'AC'
    WHEN 'ALAGOAS' THEN 'AL'
    WHEN 'AMAPÁ' THEN 'AP'
    WHEN 'AMAZONAS' THEN 'AM'
    WHEN 'BAHIA' THEN 'BA'
    WHEN 'CEARÁ' THEN 'CE'
    WHEN 'DISTRITO FEDERAL' THEN 'DF'
    WHEN 'ESPÍRITO SANTO' THEN 'ES'
    WHEN 'GOIÁS' THEN 'GO'
    WHEN 'MARANHÃO' THEN 'MA'
    WHEN 'MATO GROSSO' THEN 'MT'
    WHEN 'MATO GROSSO DO SUL' THEN 'MS'
    WHEN 'MINAS GERAIS' THEN 'MG'
    WHEN 'PARÁ' THEN 'PA'
    WHEN 'PARAÍBA' THEN 'PB'
    WHEN 'PARANÁ' THEN 'PR'
    WHEN 'PERNAMBUCO' THEN 'PE'
    WHEN 'PIAUÍ' THEN 'PI'
    WHEN 'RIO DE JANEIRO' THEN 'RJ'
    WHEN 'RIO GRANDE DO NORTE' THEN 'RN'
    WHEN 'RIO GRANDE DO SUL' THEN 'RS'
    WHEN 'RONDÔNIA' THEN 'RO'
    WHEN 'RORAIMA' THEN 'RR'
    WHEN 'SANTA CATARINA' THEN 'SC'
    WHEN 'SÃO PAULO' THEN 'SP'
    WHEN 'SERGIPE' THEN 'SE'
    WHEN 'TOCANTINS' THEN 'TO'
    ELSE NULL
  END AS uf,
  SAFE_CAST(total_spent AS NUMERIC) AS total_gasto,
  last_order_id AS ultimo_pedido
FROM {{ source('raw', 'clientes') }}