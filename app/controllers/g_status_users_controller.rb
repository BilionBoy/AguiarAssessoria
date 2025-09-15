# frozen_string_literal: true
class GStatusUsersController < ApplicationController
  before_action :set_g_status_user, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = GStatusUser.ransack(params[:q])
    @pagy, @g_status_users = pagy(@q.result)
  end

  def new
    @g_status_user = GStatusUser.new
  end

  def edit
  end

  def create
    @g_status_user = GStatusUser.new(g_status_user_params)

    if @g_status_user.save
      redirect_to g_status_users_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @g_status_user.update(g_status_user_params)
      redirect_to g_status_users_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @g_status_user.destroy
      redirect_to g_status_users_url, notice: t('messages.deleted_successfully')
    else
      redirect_to g_status_users_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_g_status_user
    @g_status_user = GStatusUser.find_by(id: params[:id])
    return redirect_to g_status_users_path, alert: t('messages.not_found') unless @g_status_user
  end

  def g_status_user_params
    permitted_attributes = GStatusUser.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:g_status_user).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to g_status_users_path, alert: t('messages.not_found')
  end
end
