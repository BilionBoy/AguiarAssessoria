# frozen_string_literal: true

class CreateEEmpresas < ActiveRecord::Migration[7.2]
  unless table_exists?(:e_empresas)
    def up
      create_table :e_empresas do |t|
        t.string     :razao_social
        t.string     :cnpj
        t.string     :endereco
        t.string     :email
        t.string     :telefone
        t.references :g_cidade, foreign_key: true
        t.string     :created_by
        t.string     :updated_by
        t.datetime   :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :e_empresas if table_exists?(:e_empresas)
  end
end
