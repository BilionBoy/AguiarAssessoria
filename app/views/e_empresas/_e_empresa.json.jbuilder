json.extract! e_empresa, :id, :razao_social, :cnpj, :endereco, :email, :telefone, :g_cidade_id, :created_at, :updated_at
json.url e_empresa_url(e_empresa, format: :json)
