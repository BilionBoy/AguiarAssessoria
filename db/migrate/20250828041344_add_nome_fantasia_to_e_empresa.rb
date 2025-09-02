# frozen_string_literal: true

class AddNomeFantasiaToEEmpresa < ActiveRecord::Migration[7.2]
  def up
    return if column_exists?(:e_empresas, :nome_fantasia)

    add_column :e_empresas, :nome_fantasia, :string
  end

  def down
    remove_column :e_empresas, :nome_fantasia if column_exists?(:e_empresas, :nome_fantasia)
  end
end
