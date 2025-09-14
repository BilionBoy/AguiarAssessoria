# frozen_string_literal: true

class EContrato < ApplicationRecord
  belongs_to :e_empresa
  belongs_to :e_cliente
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :g_banco
  belongs_to :g_status_contrato
  belongs_to :g_tipo_operacao
  belongs_to :user_created, class_name: 'User'
  belongs_to :user_updated, class_name: 'User'

  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  validates :quantidade_parcelas, presence: true
  validates :numero_contrato,     presence: true
  validates :valor_total,         presence: true
  validates :valor_comissao,      presence: true
  validates :data_inicio,         presence: true
  validates :data_fim,            presence: true
end
