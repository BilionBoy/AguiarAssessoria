# frozen_string_literal: true
class GBancosController < ApplicationController
  before_action :set_g_banco, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GBanco.ransack(params[:q])
    @pagy, @g_bancos = pagy(@q.result)
  end

  def new
    @g_banco = GBanco.new
  end

  def edit
  end

  def create
    @g_banco = GBanco.new(g_banco_params)

    if @g_banco.save
      redirect_to g_bancos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_banco.update(g_banco_params)
      redirect_to g_bancos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_banco.destroy
      redirect_to g_bancos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_bancos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_banco
    @g_banco = GBanco.find_by(id: params[:id])
    return redirect_to g_bancos_path, alert: t('messages.not_found') unless @g_banco
  end

  def g_banco_params
    permitted_attributes = GBanco.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_banco).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_bancos_path, alert: t('messages.not_found')
  end
end
