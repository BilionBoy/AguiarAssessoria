class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  belongs_to :g_tipo_usuario
  belongs_to :g_status_user
  belongs_to :e_empresa, optional: true

  # -------------------------------------------------------------------
  # Scopes
  # -------------------------------------------------------------------

  scope :ativos, lambda {
    where(g_status_user_id: GStatusUser.find_by(descricao: 'Ativo')&.id)
  }

  scope :inativos, lambda {
    where(g_status_user_id: GStatusUser.find_by(descricao: 'Inativo')&.id)
  }

  # -------------------------------------------------------------------
  # Callbacks
  # -------------------------------------------------------------------

  before_validation :normalize_cpf

  # -------------------------------------------------------------------
  # Validations
  # -------------------------------------------------------------------

  validates :nome_completo, presence: true, length: { minimum: 3 }

  validates :cpf,
            presence: true,
            uniqueness: true,
            format: { with: /\A\d{11}\z/, message: 'deve ter 11 dígitos' }

  validates :telefone,       presence: true
  validates :g_tipo_usuario, presence: true
  validates :g_status_user,  presence: true
  validates :e_empresa,      presence: true, unless: :admin?

  # -------------------------------------------------------------------
  # Roles
  # -------------------------------------------------------------------

  def admin?
    g_tipo_usuario&.descricao.to_s.casecmp?('admin')
  end

  def gerente?
    g_tipo_usuario&.descricao.to_s.casecmp?('gerente')
  end

  # -------------------------------------------------------------------
  # Private
  # -------------------------------------------------------------------

  private

  def normalize_cpf
    self.cpf = cpf.to_s.gsub(/\D/, '')
  end
end
