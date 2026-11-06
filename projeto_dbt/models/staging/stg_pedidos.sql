{{ config(labels={
    'camada': 'staging',
    'dominio': 'e-commerce',
    'ferramenta': 'dbt'
  })
}}

SELECT
  id AS pedido_id,
  number AS pedido_numero,
  store_id AS loja_id,
  customer.id AS cliente_id,
  created_at AS criado_em,
  updated_at AS atualizado_em,
  shipping_status AS status_envio,
  status AS pedido_status,
  payment_status AS pagamento_status,
  paid_at AS pago_em,
  CASE LOWER(TRIM(payment_details.method))
    WHEN 'credit_card' THEN 'Cartão de Crédito'
    WHEN 'pix' THEN 'Pix'
    WHEN 'boleto' THEN 'Boleto Bancário'
    ELSE payment_details.method
  END AS metodo_pagamento,
  payment_details.installments AS parcelas_pagamento,
  cancelled_at AS cancelado_em,
  closed_at AS fechado_em,
  cancel_reason AS motivo_cancelamento,
  SAFE_CAST(subtotal AS NUMERIC) AS subtotal,
  SAFE_CAST(discount AS NUMERIC) AS desconto,
  SAFE_CAST(discount_coupon AS NUMERIC) AS desconto_cupom,
  SAFE_CAST(shipping_cost_customer AS NUMERIC) AS frete_cobrado,
  SAFE_CAST(total AS NUMERIC) AS total,
  SAFE_CAST(total_paid_by_customer AS NUMERIC) AS total_pago_cliente,
  shipping_address.address AS endereco_entrega,
  shipping_address.city AS cidade_entrega,
  shipping_address.province AS estado_entrega
FROM
 {{ source('raw', 'pedidos')  }}