class ApplicationController < ActionController::Base
  include Pagy::Backend
  include LayoutByUser
  include DevisePermittedParameters
  before_action :authenticate_user!
  before_action :exigir_troca_de_senha

  private

  # Usuário com senha definida por outra pessoa (cadastro ou redefinição pelo
  # admin) não usa o sistema até escolher a própria senha. As telas do Devise
  # ficam liberadas para ele conseguir sair.
  def exigir_troca_de_senha
    return unless user_signed_in? && current_user.must_change_password?
    return if devise_controller?

    redirect_to edit_troca_senha_path
  end
end
