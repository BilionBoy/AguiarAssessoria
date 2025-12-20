class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  belongs_to :g_tipo_usuario
  belongs_to :g_status_user
  belongs_to :e_empresa, optional: true

  scope :ativos,   -> { where(g_status_user_id: GStatusUser.find_by(descricao: 'Ativo')&.id) }
  scope :inativos, -> { where(g_status_user_id: GStatusUser.find_by(descricao: 'Inativo')&.id) }

  before_validation :normalize_cpf

  validates :nome_completo, presence: true, length: { minimum: 3 }

  validates :cpf,            presence: true, uniqueness: true,
                             format: { with: /\A\d{11}\z/, message: 'deve ter 11 dígitos' }
  validates :telefone,       presence: true
  validates :g_tipo_usuario, presence: true
  validates :g_status_user,  presence: true
  validates :e_empresa,      presence: true, unless: :admin?

  def admin?
    g_tipo_usuario&.descricao == 'admin'
  end

  def gerente?
    g_tipo_usuario&.descricao == 'gerente'
  end

  private

  def normalize_cpf
    self.cpf = cpf.to_s.gsub(/\D/, '')
  end
end
