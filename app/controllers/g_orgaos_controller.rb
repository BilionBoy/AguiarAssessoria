# frozen_string_literal: true

class GOrgaosController < ApplicationController
  before_action :set_g_orgao, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GOrgao.ransack(params[:q])
    @pagy, @g_orgaos = pagy(@q.result)
  end

  def new
    @g_orgao = GOrgao.new
  end

  def edit
  end

  def create
    @g_orgao = GOrgao.new(g_orgao_params)

    if @g_orgao.save
      redirect_to g_orgaos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_orgao.update(g_orgao_params)
      redirect_to g_orgaos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_orgao.destroy
      redirect_to g_orgaos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_orgaos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end
  end

  private

  def set_g_orgao
    @g_orgao = GOrgao.find_by(id: params[:id])
    redirect_to g_orgaos_path, alert: t('messages.not_found') unless @g_orgao
  end

  def g_orgao_params
    permitted_attributes = GOrgao.column_names.reject { |col| %w[deleted_at created_by updated_by].include?(col) }
    params.require(:g_orgao).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_orgaos_path, alert: t('messages.not_found')
  end
end
