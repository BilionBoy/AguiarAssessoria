# frozen_string_literal: true

class GTipoOperacoesController < ApplicationController
  before_action :set_g_tipo_operacao, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GTipoOperacao.ransack(params[:q])
    @pagy, @g_tipo_operacoes = pagy(@q.result)
  end

  def new
    @g_tipo_operacao = GTipoOperacao.new
  end

  def edit
  end

  def create
    @g_tipo_operacao = GTipoOperacao.new(g_tipo_operacao_params)

    if @g_tipo_operacao.save
      redirect_to g_tipo_operacoes_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_tipo_operacao.update(g_tipo_operacao_params)
      redirect_to g_tipo_operacoes_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_tipo_operacao.destroy
      redirect_to g_tipo_operacoes_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_tipo_operacoes_url, alert: t('messages.delete_failed_due_to_dependencies')
    end
  end

  private

  def set_g_tipo_operacao
    @g_tipo_operacao = GTipoOperacao.find_by(id: params[:id])
    redirect_to g_tipo_operacoes_path, alert: t('messages.not_found') unless @g_tipo_operacao
  end

  def g_tipo_operacao_params
    permitted_attributes = GTipoOperacao.column_names.reject do |col|
      %w[deleted_at created_by updated_by].include?(col)
    end
    params.require(:g_tipo_operacao).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_tipo_operacoes_path, alert: t('messages.not_found')
  end
end
