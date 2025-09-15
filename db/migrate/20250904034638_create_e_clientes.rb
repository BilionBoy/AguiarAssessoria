# frozen_string_literal: true

class CreateEClientes < ActiveRecord::Migration[7.2]
  def up
    unless table_exists?(:e_clientes)
      create_table :e_clientes do |t|
        t.references :e_empresa, null: false, foreign_key: true

        t.string     :nome_completo, null: false
        t.string     :cpf, null: false
        t.date       :data_nascimento
        t.string     :email
        t.string     :telefone
        t.string     :nome_social
        t.string     :endereco
        t.string     :matricula
        t.boolean    :alfabetizado, default: false
        t.decimal    :ultima_margem, precision: 10, scale: 2
        t.date       :data_ultima_margem

        # 🔹 Condicionais
        t.integer    :ano_admissao
        t.boolean    :pensionista, default: false
        t.string     :numero_beneficio
        t.boolean    :possui_representante_legal, default: false

        # 🔹 Auditoria
        t.string     :created_by
        t.string     :updated_by
        t.datetime   :deleted_at

        # 🔹 Foreign Keys
        t.references :g_sexo,           foreign_key: true
        t.references :g_estado,         foreign_key: true
        t.references :g_cidade,         foreign_key: true
        t.references :g_bairro,         foreign_key: true
        t.references :g_orgao,          foreign_key: true
        t.references :g_margem_tipo,    foreign_key: true
        t.references :g_tipo_beneficio, foreign_key: true
        t.references :g_status_cliente, foreign_key: true

        t.timestamps
      end
    end

    add_index :e_clientes, :cpf, unique: true unless index_exists?(:e_clientes, :cpf)
    add_index :e_clientes, :email unless index_exists?(:e_clientes, :email)
  end

  def down
    drop_table :e_clientes if table_exists?(:e_clientes)
  end
end
