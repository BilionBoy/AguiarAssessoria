# frozen_string_literal: true

class EContrato < ApplicationRecord
  belongs_to :e_empresa
  belongs_to :e_cliente
  belongs_to :g_margem_tipo
  belongs_to :g_banco
  belongs_to :g_status_contrato
  belongs_to :g_tipo_operacao
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  validates :quantidade_parcelas, presence: true
  validates :numero_contrato,     presence: true
  validates :valor_total,         presence: true
  validates :valor_comissao,      presence: true
  validates :data_pagamento,      presence: true
  validates :data_cadastro,       presence: true
end
