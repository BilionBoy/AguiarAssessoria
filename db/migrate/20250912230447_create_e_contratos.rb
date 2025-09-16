class CreateEContratos < ActiveRecord::Migration[7.2]
  unless table_exists?(:e_contratos)
    def up
      create_table :e_contratos do |t|
        t.references :e_empresa,            null: false, foreign_key: true
        t.references :e_cliente,            null: false, foreign_key: true
        t.references :user,                 null: false, foreign_key: true
        t.references :g_banco,              null: false, foreign_key: true
        t.references :g_status_contrato,    null: false, foreign_key: true
        t.references :g_tipo_operacao,      null: false, foreign_key: true
        t.references :g_margem_tipo,        null: false, foreign_key: true
        t.string     :numero_contrato,      null: false
        t.string     :produto
        t.decimal    :valor_total,         null: false
        t.integer    :quantidade_parcelas, null: false
        t.decimal    :valor_parcela,       null: false
        t.decimal    :valor_comissao,      null: false
        t.date :data_pagamento,            null: false
        t.date :data_cadastro,             null: false
        t.timestamps
      end
    end
  end

  def down
    drop_table :e_contratos if table_exists?(:e_contratos)
  end
end
