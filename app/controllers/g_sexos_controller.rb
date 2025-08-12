# frozen_string_literal: true
class GSexosController < ApplicationController
  before_action :set_g_sexo, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GSexo.ransack(params[:q])
    @pagy, @g_sexos = pagy(@q.result)
  end

  def new
    @g_sexo = GSexo.new
  end

  def edit
  end

  def create
    @g_sexo = GSexo.new(g_sexo_params)

    if @g_sexo.save
      redirect_to g_sexos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_sexo.update(g_sexo_params)
      redirect_to g_sexos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_sexo.destroy
      redirect_to g_sexos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_sexos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_sexo
    @g_sexo = GSexo.find_by(id: params[:id])
    return redirect_to g_sexos_path, alert: t('messages.not_found') unless @g_sexo
  end

  def g_sexo_params
    permitted_attributes = GSexo.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_sexo).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_sexos_path, alert: t('messages.not_found')
  end
end
