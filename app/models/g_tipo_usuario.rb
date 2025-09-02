# frozen_string_literal: true

class GTipoUsuario < ApplicationRecord
  before_save :uppercase_descricao

  validates :descricao, presence: true

  private

  def uppercase_descricao
    self.descricao = descricao.to_s.upcase
  end
end
