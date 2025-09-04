# frozen_string_literal: true

class ECliente < ApplicationRecord
  # Adicione aqui quaisquer métodos ou validações padrão para seus modelos
  belongs_to :e_empresa
end
