class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  before_action :verify_admin

  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result.includes(:g_tipo_usuario, :e_empresa))
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    limpar_fks_vazias

    if @user.save
      redirect_to users_path, notice: 'Usuário cadastrado com sucesso'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    limpar_fks_vazias

    if @user.update(user_params)
      redirect_to users_path, notice: 'Usuário atualizado com sucesso'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'Usuário removido'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def verify_admin
    return if current_user&.g_tipo_usuario&.descricao == 'admin'

    redirect_to root_path, alert: 'Acesso negado'
  end

  def user_params
    params.require(:user).permit(:email, :cpf, :nome_completo, :telefone, :g_tipo_usuario_id, :e_empresa_id,
                                 :g_status_user_id, :password, :password_confirmation)
  end

  def limpar_fks_vazias
    @user.g_tipo_usuario_id = nil if @user.g_tipo_usuario_id.blank?
    @user.e_empresa_id      = nil if @user.e_empresa_id.blank?
  end
end
