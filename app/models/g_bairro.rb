# frozen_string_literal: true

class GBairro < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :g_cidade

  validates :descricao, presence: true
end
