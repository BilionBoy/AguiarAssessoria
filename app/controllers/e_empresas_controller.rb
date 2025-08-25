# frozen_string_literal: true
class EEmpresasController < ApplicationController
  before_action :set_e_empresa, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = EEmpresa.ransack(params[:q])
    @pagy, @e_empresas = pagy(@q.result)
  end

  def new
    @e_empresa = EEmpresa.new
  end

  def edit
  end

  def create
    @e_empresa = EEmpresa.new(e_empresa_params)

    if @e_empresa.save
      redirect_to e_empresas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @e_empresa.update(e_empresa_params)
      redirect_to e_empresas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @e_empresa.destroy
      redirect_to e_empresas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to e_empresas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_e_empresa
    @e_empresa = EEmpresa.find_by(id: params[:id])
    return redirect_to e_empresas_path, alert: t('messages.not_found') unless @e_empresa
  end

  def e_empresa_params
    permitted_attributes = EEmpresa.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:e_empresa).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to e_empresas_path, alert: t('messages.not_found')
  end
end
