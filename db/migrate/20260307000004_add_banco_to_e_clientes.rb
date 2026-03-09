# frozen_string_literal: true

# Schema migration (DDL only): adiciona banco ao cliente
class AddBancoToEClientes < ActiveRecord::Migration[7.2]
  def up
    return if column_exists?(:e_clientes, :g_banco_id)

    add_reference :e_clientes, :g_banco, foreign_key: true
  end

  def down
    remove_reference :e_clientes, :g_banco, foreign_key: true if column_exists?(:e_clientes, :g_banco_id)
  end
end
