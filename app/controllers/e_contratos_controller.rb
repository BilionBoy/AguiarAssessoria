# frozen_string_literal: true

class EContratosController < ApplicationController
  before_action :set_e_contrato, only: %i[show edit update destroy pdf]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = EContrato.ransack(params[:q])
    @pagy, @e_contratos = pagy(@q.result)
  end

  def new
    @e_contrato = EContrato.new
  end

  def edit
  end

  def pdf
    html = render_to_string(template: 'e_contratos/pdf', layout: false)
    pdf_data = WickedPdf.new.pdf_from_string(
      html,
      page_size: 'A4',
      margin: { top: 0, bottom: 0, left: 0, right: 0 },
      enable_local_file_access: true
    )
    send_data pdf_data,
              filename: "ficha_#{@e_contrato.numero_contrato}_#{Date.today.strftime('%d%m%Y')}.pdf",
              type: 'application/pdf',
              disposition: 'inline'
  end

  def create
    @e_contrato = EContrato.new(e_contrato_params)
    @e_contrato.user        = current_user
    @e_contrato.e_empresa   = current_user.e_empresa

    if @e_contrato.save
      redirect_to e_contratos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @e_contrato.update(e_contrato_params)
      redirect_to e_contratos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @e_contrato.destroy
      redirect_to e_contratos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to e_contratos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end
  end

  private

  def set_e_contrato
    @e_contrato = EContrato.find_by(id: params[:id])
    redirect_to e_contratos_path, alert: t('messages.not_found') unless @e_contrato
  end

  def e_contrato_params
    permitted_attributes = EContrato.column_names.reject do |col|
      %w[deleted_at created_by updated_by user_id e_empresa_id].include?(col)
    end
    params.require(:e_contrato).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to e_contratos_path, alert: t('messages.not_found')
  end
end
