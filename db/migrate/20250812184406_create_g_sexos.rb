# frozen_string_literal: true

class CreateGSexos < ActiveRecord::Migration[7.2]
  def up
    create_table :g_sexos do |t|
      t.string :descricao
          
      t.string :created_by
      t.string :updated_by
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :g_sexos
  end
end
