# frozen_string_literal: true

class CreateGEstados < ActiveRecord::Migration[7.2]
  def up
    create_table :g_estados do |t|
      t.string :nome_fantasia
      t.string :sigla
          
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :g_estados
  end
end
