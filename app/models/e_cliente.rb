# frozen_string_literal: true

class ECliente < ApplicationRecord
  include ValidacoesPorOrgao

  # Associações
  belongs_to       :e_empresa
  belongs_to       :g_status_cliente, optional: true
  belongs_to       :g_sexo
  belongs_to       :g_estado
  belongs_to       :g_cidade
  belongs_to       :g_bairro
  belongs_to       :g_orgao
  belongs_to       :g_tipo_beneficio, optional: true
  belongs_to       :g_margem_tipo,    optional: true
  has_one_attached :foto_cliente
  has_one_attached :foto_contracheque
  has_one_attached :foto_rg

  # Validações
  validates :nome_completo,   presence: true
  validates :cpf,             presence: true
  validates :data_nascimento, presence: true
  validates :matricula,       presence: true
  validates :ultima_margem,   presence: true
end
