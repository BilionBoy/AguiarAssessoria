# frozen_string_literal: true

class ECliente < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :e_empresa
  belongs_to :g_status_cliente, optional: true
  belongs_to :g_sexo
  belongs_to :g_estado
  belongs_to :g_cidade
  belongs_to :g_bairro
  belongs_to :g_orgao
  belongs_to :g_margem_tipo
  belongs_to :g_tipo_beneficio
  belongs_to :g_margem_tipo
end
