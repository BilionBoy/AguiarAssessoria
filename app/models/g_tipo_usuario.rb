# frozen_string_literal: true

class GTipoUsuario < ApplicationRecord
  validates :descricao, presence: true

  before_save :uppercase_descricao

  private

  def uppercase_descricao
    self.descricao = descricao.to_s.upcase
  end
end
