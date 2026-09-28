# frozen_string_literal: true

class GTipoUsuario < ApplicationRecord
  ADMIN = 'admin'
  GERENTE = 'gerente'
  USUARIO = 'usuario'
  CODIGOS = [ADMIN, GERENTE, USUARIO].freeze

  before_validation :normalize_codigo
  before_save :uppercase_descricao

  validates :descricao, presence: true
  validates :codigo, presence: true, uniqueness: true, inclusion: { in: CODIGOS }

  def admin?
    codigo == ADMIN
  end

  def gerente?
    codigo == GERENTE
  end

  private

  def normalize_codigo
    self.codigo = codigo.to_s.parameterize(separator: '_') if codigo.present?
  end

  def uppercase_descricao
    self.descricao = descricao.to_s.upcase
  end
end
