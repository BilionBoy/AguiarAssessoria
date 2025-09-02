# frozen_string_literal: true

class CreateGBancos < ActiveRecord::Migration[7.2]
  unless table_exists?(:g_bancos)
    def up
      create_table :g_bancos do |t|
        t.string   :nome_fantasia
        t.string   :codigo
        t.string   :created_by
        t.string   :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :g_bancos if table_exists?(:g_bancos)
  end
end
