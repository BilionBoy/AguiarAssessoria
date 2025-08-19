# frozen_string_literal: true

class GOrgao < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos

  validates :descricao, presence: true, uniqueness: true
end
