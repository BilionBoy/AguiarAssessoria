# frozen_string_literal: true

class GEstado < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos

  validates :nome_fantasia, presence: true
  validates :sigla, presence: true
end
