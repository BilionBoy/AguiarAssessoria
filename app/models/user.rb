class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associações
  belongs_to :g_tipo_usuario
  belongs_to :e_empresa
  belongs_to :g_status_user

  # Scopes
  scope :ativos,   -> { where(g_status_user_id: GStatusUser.find_by(descricao: 'Ativo')&.id) }
  scope :inativos, -> { where(g_status_user_id: GStatusUser.find_by(descricao: 'Inativo')&.id) }

  # Validações
  validates :nome_completo,  presence: true, length: { minimum: 3 }
  validates :cpf,            presence: true, uniqueness: true,
                             format: { with: /\A\d{11}\z/, message: 'deve ter 11 dígitos' }
  validates :telefone,       presence: true
  validates :g_tipo_usuario, presence: true
  validates :g_status_user,  presence: true
  validates :e_empresa,      presence: true

  def admin?
    g_tipo_usuario&.descricao == 'ADMIN'
  end
end
