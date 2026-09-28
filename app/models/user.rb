class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  belongs_to :g_tipo_usuario
  belongs_to :g_status_user
  belongs_to :e_empresa, optional: true

  scope :ativos, lambda {
    joins(:g_status_user).where(g_status_users: { codigo: GStatusUser::ATIVO })
  }

  scope :inativos, lambda {
    joins(:g_status_user).where(g_status_users: { codigo: GStatusUser::INATIVO })
  }

  before_validation :normalize_cpf

  validates :nome_completo, presence: true, length: { minimum: 3 }

  validates :cpf,
            presence: true,
            uniqueness: true,
            format: { with: /\A\d{11}\z/, message: 'deve ter 11 dígitos' }

  validates :telefone,       presence: true
  validates :g_tipo_usuario, presence: true
  validates :g_status_user,  presence: true
  validates :e_empresa,      presence: true, unless: :admin?

  def admin?
    g_tipo_usuario&.codigo == GTipoUsuario::ADMIN
  end

  def gerente?
    g_tipo_usuario&.codigo == GTipoUsuario::GERENTE
  end

  private

  def normalize_cpf
    self.cpf = cpf.to_s.gsub(/\D/, '')
  end
end
