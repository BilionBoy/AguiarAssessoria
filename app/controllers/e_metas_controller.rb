# frozen_string_literal: true
class EMetasController < ApplicationController
  before_action :set_e_meta, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = EMeta.ransack(params[:q])
    @pagy, @e_metas = pagy(@q.result)
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
    return redirect_to e_metas_path, alert: t('messages.not_found') unless @e_meta
  end

  def e_meta_params
    permitted_attributes = EMeta.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:e_meta).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to e_metas_path, alert: t('messages.not_found')
  end
end
