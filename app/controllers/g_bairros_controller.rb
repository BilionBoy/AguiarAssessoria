# frozen_string_literal: true
class GBairrosController < ApplicationController
  before_action :set_g_bairro, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GBairro.ransack(params[:q])
    @pagy, @g_bairros = pagy(@q.result)
  end

  def new
    @g_bairro = GBairro.new
  end

  def edit
  end

  def create
    @g_bairro = GBairro.new(g_bairro_params)

    if @g_bairro.save
      redirect_to g_bairros_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_bairro.update(g_bairro_params)
      redirect_to g_bairros_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_bairro.destroy
      redirect_to g_bairros_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_bairros_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_bairro
    @g_bairro = GBairro.find_by(id: params[:id])
    return redirect_to g_bairros_path, alert: t('messages.not_found') unless @g_bairro
  end

  def g_bairro_params
    permitted_attributes = GBairro.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_bairro).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_bairros_path, alert: t('messages.not_found')
  end
end
