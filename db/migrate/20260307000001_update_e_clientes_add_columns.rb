# frozen_string_literal: true

# Schema migration (DDL only): novos campos + join table de convênios
class UpdateEClientesAddColumns < ActiveRecord::Migration[7.2]
  def up
    change_column_default :e_clientes, :alfabetizado, from: false, to: true

    new_cols = {
      data_admissao: :date,
      nome_representante_legal: :string,
      cpf_representante_legal: :string,
      nome_instituidor: :string,
      matricula_instituidor: :string
    }
    new_cols.each { |col, type| add_column :e_clientes, col, type unless column_exists?(:e_clientes, col) }

    create_convenios_join_table
  end

  def down
    change_column_default :e_clientes, :alfabetizado, from: true, to: false

    %i[data_admissao nome_representante_legal cpf_representante_legal
       nome_instituidor matricula_instituidor].each do |col|
      remove_column :e_clientes, col if column_exists?(:e_clientes, col)
    end

    drop_table :e_clientes_g_orgaos if table_exists?(:e_clientes_g_orgaos)
  end

  private

  def create_convenios_join_table
    return if table_exists?(:e_clientes_g_orgaos)

    create_table :e_clientes_g_orgaos, id: false do |t|
      t.bigint :e_cliente_id, null: false
      t.bigint :g_orgao_id,   null: false
    end
    add_index :e_clientes_g_orgaos, %i[e_cliente_id g_orgao_id], unique: true
    add_foreign_key :e_clientes_g_orgaos, :e_clientes
    add_foreign_key :e_clientes_g_orgaos, :g_orgaos
  end
end
