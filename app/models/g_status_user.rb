# frozen_string_literal: true

class GStatusUser < ApplicationRecord
  ATIVO = 'ativo'
  INATIVO = 'inativo'
  BLOQUEADO = 'bloqueado'
  CODIGOS = [ATIVO, INATIVO, BLOQUEADO].freeze

  before_validation :normalize_codigo

  validates :descricao, presence: true
  validates :codigo, presence: true, uniqueness: true, inclusion: { in: CODIGOS }

  def ativo?
    codigo == ATIVO
  end

  def inativo?
    codigo == INATIVO
  end

  private

  def normalize_codigo
    self.codigo = codigo.to_s.parameterize(separator: '_') if codigo.present?
  end
end
