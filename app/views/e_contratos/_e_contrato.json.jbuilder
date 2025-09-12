json.extract! e_contrato, :id, :e_empresa_id, :e_cliente_id, :user_id, :numero_contrato, :g_banco_id, :g_status_contrato_id, :g_tipo_operacao_id, :produto, :valor_total, :quantidade_parcelas, :valor_parcela, :valor_comissao, :data_inicio, :data_fim, :user_created_id, :user_updated_id, :created_at, :updated_at
json.url e_contrato_url(e_contrato, format: :json)
