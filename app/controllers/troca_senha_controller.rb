# frozen_string_literal: true

# Troca de senha obrigatória. Todo usuário cadastrado pelo admin (ou que teve a
# senha redefinida por ele) cai aqui ao entrar e só usa o sistema depois de
# escolher uma senha que só ele conhece. Ver ApplicationController#exigir_troca_de_senha.
class TrocaSenhaController < ApplicationController
  layout 'devise_application'
  skip_before_action :set_layout_by_controller
  skip_before_action :exigir_troca_de_senha

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    nova_senha = troca_senha_params[:password].to_s

    if nova_senha.present? && @user.valid_password?(nova_senha)
      @user.errors.add(:password, 'deve ser diferente da senha que você recebeu')
      return render :edit, status: :unprocessable_entity
    end

    if @user.update(troca_senha_params.merge(must_change_password: false))
      # Trocar a senha invalida a sessão atual no Devise; mantém o usuário logado.
      bypass_sign_in(@user)
      redirect_to root_path, notice: 'Senha alterada com sucesso.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def troca_senha_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
