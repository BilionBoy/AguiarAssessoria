# frozen_string_literal: true
class GCidadesController < ApplicationController
  before_action :set_g_cidade, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GCidade.ransack(params[:q])
    @pagy, @g_cidades = pagy(@q.result)
  end

  def new
    @g_cidade = GCidade.new
  end

  def edit
  end

  def create
    @g_cidade = GCidade.new(g_cidade_params)

    if @g_cidade.save
      redirect_to g_cidades_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_cidade.update(g_cidade_params)
      redirect_to g_cidades_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_cidade.destroy
      redirect_to g_cidades_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_cidades_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_cidade
    @g_cidade = GCidade.find_by(id: params[:id])
    return redirect_to g_cidades_path, alert: t('messages.not_found') unless @g_cidade
  end

  def g_cidade_params
    permitted_attributes = GCidade.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_cidade).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_cidades_path, alert: t('messages.not_found')
  end
end
