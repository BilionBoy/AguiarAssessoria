# frozen_string_literal: true

class CreateGSexos < ActiveRecord::Migration[7.2]
  unless table_exists?(:g_sexos)
    def up
      create_table :g_sexos do |t|
        t.string :descricao
        t.string :created_by
        t.string :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :g_sexos if table_exists?(:g_sexos)
  end
end
