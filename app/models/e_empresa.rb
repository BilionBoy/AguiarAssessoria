# frozen_string_literal: true

class EEmpresa < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :g_cidade
  has_many   :e_clientes, dependent: :nullify

  validates :nome_fantasia, presence: true
  validates :razao_social,  presence: true
  validates :cnpj,          presence: true
  validates :endereco,      presence: true
  validates :email,         presence: true
end
