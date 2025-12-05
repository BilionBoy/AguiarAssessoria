Rails.application.routes.draw do
  devise_for :users

  root 'admin#index'
  get  'admin/index'
  get  'home/index'

  # Rotas Scaffold
  resources :g_tipo_usuarios
  resources :g_sexos
  resources :g_estados
  resources :g_bairros
  resources :g_cidades
  resources :g_tipo_beneficios
  resources :g_tipos_beneficios
  resources :g_margem_tipos
  resources :g_orgaos
  resources :g_status_contratos
  resources :g_status_clientes
  resources :g_tipo_operacoes
  resources :g_bancos
  resources :g_status_users
  resources :e_contratos
  resources :e_empresas
  resources :e_clientes
  resources :e_metas

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
