# frozen_string_literal: true

class GStatusUser < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  #

  private

  def uppercase_descricao
    self.descricao = descricao.to_s.upcase
  end
end
