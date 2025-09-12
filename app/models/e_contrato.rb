# frozen_string_literal: true

class EContrato < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  validates :quantidade_parcelas, presence: true
  validates :numero_contrato,     presence: true
  validates :valor_total,         presence: true
  validates :valor_comissao,      presence: true
  validates :data_inicio,         presence: true
  validates :data_fim,            presence: true
end
