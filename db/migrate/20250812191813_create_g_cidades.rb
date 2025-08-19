# frozen_string_literal: true

class CreateGCidades < ActiveRecord::Migration[7.2]
  unless table_exists?(:g_cidades)
    def up
      create_table :g_cidades do |t|
        t.string :nome_fantasia
        t.references :g_estado, foreign_key: true
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :g_cidades if table_exists?(:g_cidades)
  end
end
