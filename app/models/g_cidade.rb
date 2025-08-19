# frozen_string_literal: true

class GCidade < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :g_estado

  validates :nome_fantasia, presence: true
end
