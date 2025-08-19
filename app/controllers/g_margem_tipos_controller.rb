# frozen_string_literal: true
class GMargemTiposController < ApplicationController
  before_action :set_g_margem_tipo, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GMargemTipo.ransack(params[:q])
    @pagy, @g_margem_tipos = pagy(@q.result)
  end

  def new
    @g_margem_tipo = GMargemTipo.new
  end

  def edit
  end

  def create
    @g_margem_tipo = GMargemTipo.new(g_margem_tipo_params)

    if @g_margem_tipo.save
      redirect_to g_margem_tipos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_margem_tipo.update(g_margem_tipo_params)
      redirect_to g_margem_tipos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_margem_tipo.destroy
      redirect_to g_margem_tipos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_margem_tipos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_margem_tipo
    @g_margem_tipo = GMargemTipo.find_by(id: params[:id])
    return redirect_to g_margem_tipos_path, alert: t('messages.not_found') unless @g_margem_tipo
  end

  def g_margem_tipo_params
    permitted_attributes = GMargemTipo.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_margem_tipo).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_margem_tipos_path, alert: t('messages.not_found')
  end
end
