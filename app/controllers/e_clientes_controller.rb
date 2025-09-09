# frozen_string_literal: true

class EClientesController < ApplicationController
  before_action :set_e_cliente, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = current_user.e_empresa.e_clientes.ransack(params[:q])
    @pagy, @e_clientes = pagy(@q.result)
  end

  def new
    @e_cliente = ECliente.new
  end

  def edit
  end

  def create
    @e_cliente = current_user.e_empresa.e_clientes.new(e_cliente_params)

    if @e_cliente.save
      redirect_to e_clientes_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @e_cliente.update(e_cliente_params)
      redirect_to e_clientes_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @e_cliente.destroy
      redirect_to e_clientes_url, notice: t('messages.deleted_successfully')
    else
      redirect_to e_clientes_url, alert: t('messages.delete_failed_due_to_dependencies')
    end
  end

  private

  def e_cliente_params
    permitted_attributes = ECliente.column_names.reject do |col|
      %w[deleted_at created_by updated_by].include?(col)
    end
    params.require(:e_cliente).permit(permitted_attributes.map(&:to_sym))
  end

  def set_e_cliente
    @e_cliente = current_user.e_empresa.e_clientes.find_by(id: params[:id])
    redirect_to e_clientes_path, alert: t('messages.not_found') unless @e_cliente
  end

  def handle_not_found
    redirect_to e_clientes_path, alert: t('messages.not_found')
  end
end
