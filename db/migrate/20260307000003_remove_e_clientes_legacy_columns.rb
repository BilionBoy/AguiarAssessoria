# frozen_string_literal: true

# Schema migration (DDL only): remove colunas legadas após migração dos dados.
# Deve rodar APÓS 20260307000002.
class RemoveEClientesLegacyColumns < ActiveRecord::Migration[7.2]
  def up
    remove_column :e_clientes, :ano_admissao if column_exists?(:e_clientes, :ano_admissao)
  end

  def down
    add_column :e_clientes, :ano_admissao, :integer unless column_exists?(:e_clientes, :ano_admissao)
  end
end
