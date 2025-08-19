# frozen_string_literal: true

class CreateGBairros < ActiveRecord::Migration[7.2]
  def up
    create_table :g_bairros do |t|
      t.string     :descricao
      t.references :g_cidade, foreign_key: true
      t.string     :created_by
      t.string     :updated_by
      t.datetime   :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :g_bairros
  end
end
