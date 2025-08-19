# frozen_string_literal: true

class GTipoBeneficiosController < ApplicationController
  before_action :set_g_tipo_beneficio, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GTipoBeneficio.ransack(params[:q])
    @pagy, @g_tipo_beneficios = pagy(@q.result)
  end

  def new
    @g_tipo_beneficio = GTipoBeneficio.new
  end

  def edit
  end

  def create
    @g_tipo_beneficio = GTipoBeneficio.new(g_tipo_beneficio_params)

    if @g_tipo_beneficio.save
      redirect_to g_tipo_beneficios_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_tipo_beneficio.update(g_tipo_beneficio_params)
      redirect_to g_tipo_beneficios_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_tipo_beneficio.destroy
      redirect_to g_tipo_beneficios_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_tipo_beneficios_url, alert: t('messages.delete_failed_due_to_dependencies')
    end
  end

  private

  def set_g_tipo_beneficio
    @g_tipo_beneficio = GTipoBeneficio.find_by(id: params[:id])
    redirect_to g_tipo_beneficios_path, alert: t('messages.not_found') unless @g_tipo_beneficio
  end

  def g_tipo_beneficio_params
    permitted_attributes = GTipoBeneficio.column_names.reject do |col|
      %w[deleted_at created_by updated_by].include?(col)
    end
    params.require(:g_tipo_beneficio).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_tipo_beneficios_path, alert: t('messages.not_found')
  end
end
