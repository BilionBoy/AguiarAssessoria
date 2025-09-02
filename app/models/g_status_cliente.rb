# frozen_string_literal: true

class GStatusCliente < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  validates :descricao, presence: true
end
