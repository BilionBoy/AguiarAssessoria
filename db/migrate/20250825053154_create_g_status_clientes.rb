# frozen_string_literal: true

class CreateGStatusClientes < ActiveRecord::Migration[7.2]
  unless table_exists?(:g_status_clientes)
    def up
      create_table :g_status_clientes do |t|
        t.string    :descricao
        t.string    :created_by
        t.string    :updated_by
        t.datetime :deleted_at
        t.timestamps
      end
    end
  end

  def down
    drop_table :g_status_clientes if table_exists?(:g_status_clientes)
  end
end
