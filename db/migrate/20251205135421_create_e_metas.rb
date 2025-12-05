# frozen_string_literal: true

class CreateEMetas < ActiveRecord::Migration[7.2]
  def up
    return if table_exists?(:e_metas)

    create_table :e_metas do |t|
      t.references :e_empresa, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :valor_meta, precision: 12, scale: 2, null: false
      t.date :referencia, null: false

      t.string :descricao
      t.string :created_by
      t.string :updated_by

      t.datetime :deleted_at

      t.timestamps
    end
  end

  def down
    drop_table :e_metas if table_exists?(:e_metas)
  end
end
