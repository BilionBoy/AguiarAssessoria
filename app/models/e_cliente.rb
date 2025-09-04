# frozen_string_literal: true

class ECliente < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :e_empresa
  belongs_to :g_status_cliente, optional: true
end
