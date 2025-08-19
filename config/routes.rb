Rails.application.routes.draw do
  resources :g_tipo_operacoes

  root 'admin#index'
  get  'admin/index'
  get  'admin/new'
  get  'admin/clientes'
  get  'admin/contratos'
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

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
