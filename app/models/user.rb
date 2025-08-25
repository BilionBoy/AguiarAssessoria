# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associações
  belongs_to :g_tipo_usuario
  belongs_to :e_empresa

  # Validações
  validates :nome_completo,  presence: true, length: { minimum: 3 }
  validates :cpf,            presence: true, uniqueness: true, format: { with: /\A\d{11}\z/, message: 'deve ter 11 dígitos'}
  validates :telefone,       presence: true
  validates :g_tipo_usuario, presence: true
  validates :e_empresa,      presence: true
end
