# frozen_string_literal: true

class EMetasController < ApplicationController
  before_action :set_e_meta, only: %i[show edit update destroy]
  before_action :load_form_data, only: %i[index]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    # Carregar empresas para o filtro
    @empresas = EEmpresa.order(:razao_social)

    # Filtros básicos
    @q = EMeta.ransack(params[:q])

    # Aplicar filtros customizados
    scope = EMeta.includes(:e_empresa, :user)

    scope = scope.where(e_empresa_id: params[:empresa_id]) if params[:empresa_id].present?

    scope = scope.where('descricao ILIKE ?', "%#{params[:descricao]}%") if params[:descricao].present?

    scope = scope.where(referencia: params[:referencia]) if params[:referencia].present?

    @pagy, @e_metas = pagy(scope.order(referencia: :desc))

    # Calcular estatísticas do mês atual
    calcular_estatisticas_mes

    # Gerar ranking de vendedores
    gerar_ranking_vendedores
  end

  def new
    @e_meta = EMeta.new
  end

  def edit
  end

  def create
    @e_meta = EMeta.new(e_meta_params)

    if @e_meta.save
      redirect_to e_metas_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @e_meta.update(e_meta_params)
      redirect_to e_metas_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @e_meta.destroy
      redirect_to e_metas_url, notice: t('messages.deleted_successfully')
    else
      redirect_to e_metas_url, alert: t('messages.delete_failed_due_to_dependencies')
    end
  end

  private

  def set_e_meta
    @e_meta = EMeta.find_by(id: params[:id])
    redirect_to e_metas_path, alert: t('messages.not_found') unless @e_meta
  end

  def e_meta_params
    permitted_attributes = EMeta.column_names.reject { |col| %w[deleted_at created_by updated_by].include?(col) }
    params.require(:e_meta).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to e_metas_path, alert: t('messages.not_found')
  end

  def load_form_data
    @empresas = EEmpresa.order(:razao_social)
    @usuarios = User.order(:nome_completo)
  end

  def calcular_estatisticas_mes
    referencia = Date.current.beginning_of_month

    # Meta total do mês
    @meta_total_mes = EMeta.where(referencia: referencia..referencia.end_of_month)
                           .sum(:valor_meta) || 0

    # Realizado no mês (soma das comissões pagas)
    @realizado_mes = EContrato.where(data_pagamento: referencia..referencia.end_of_month)
                              .sum(:valor_comissao) || 0

    # Percentual atingido
    @percentual_atingido = if @meta_total_mes > 0
                             ((@realizado_mes / @meta_total_mes) * 100).round(1)
                           else
                             0
                           end

    # Metas ativas
    @metas_ativas = EMeta.where(referencia: referencia..referencia.end_of_month).count
  end

  def gerar_ranking_vendedores
    referencia = Date.current.beginning_of_month

    # Query corrigida usando a tabela e_contratos diretamente
    @ranking_vendedores = User.joins('LEFT JOIN e_contratos ON e_contratos.user_id = users.id')
                              .where('e_contratos.data_pagamento >= ? AND e_contratos.data_pagamento <= ?',
                                     referencia, referencia.end_of_month)
                              .select('users.*, COALESCE(SUM(e_contratos.valor_comissao), 0) as total_vendas')
                              .group('users.id')
                              .order('total_vendas DESC')
                              .limit(10)
  end
end
