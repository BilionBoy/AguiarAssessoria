# frozen_string_literal: true

class ECliente < ApplicationRecord
  include ValidacoesPorOrgao

  # Associações
  belongs_to :e_empresa,        optional: true
  belongs_to :g_status_cliente, optional: true
  belongs_to :g_sexo,           optional: true
  belongs_to :g_cidade,         optional: true
  belongs_to :g_bairro,         optional: true
  belongs_to :g_tipo_beneficio, optional: true
  belongs_to :g_margem_tipo,    optional: true
  belongs_to :g_banco,          optional: true

  has_and_belongs_to_many :g_orgaos, join_table: :e_clientes_g_orgaos

  has_one_attached  :comprovante_residencia
  has_one_attached  :foto_contracheque
  has_one_attached  :documento_identificacao
  has_many_attached :outros_documentos

  before_validation :set_status_padrao, on: :create

  # Validações
  validates :nome_completo,   presence: true
  validates :cpf,             presence: true
  validates :matricula, presence: true

  private

  def set_status_padrao
    return if g_status_cliente_id.present?

    status_ativo = GStatusCliente.find_by('lower(descricao) = ?', 'ativo')
    self.g_status_cliente = status_ativo if status_ativo
  end
end
