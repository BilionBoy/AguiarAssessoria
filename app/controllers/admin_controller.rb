class AdminController < ApplicationController
  def index
    @clientes = current_user.e_empresa.e_clientes.count
  end

  def new
  end

  def contratos
  end
end
