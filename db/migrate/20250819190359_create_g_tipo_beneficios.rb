# frozen_string_literal: true

class CreateGTipoBeneficios < ActiveRecord::Migration[7.2]
  unless table_exists?(:g_tipo_beneficios)
    def up
      create_table :g_tipo_beneficios do |t|
        t.string   :descricao
        t.string   :created_by
        t.string   :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end
  def down
    drop_table :g_tipo_beneficios if table_exists?(:g_tipo_beneficios)
  end
end
