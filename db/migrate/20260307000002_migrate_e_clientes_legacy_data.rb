# frozen_string_literal: true

# Data migration (DML only): copia dados das colunas legadas para a nova estrutura.
# Deve rodar APÓS 20260307000001 e ANTES de 20260307000003.
class MigrateEClientesLegacyData < ActiveRecord::Migration[7.2]
  def up
    migrate_admissao_data
    migrate_convenios_data
  end

  def down
    raise ActiveRecord::IrreversibleMigration, 'Migrações de dados não são reversíveis automaticamente.'
  end

  private

  def migrate_admissao_data
    return unless column_exists?(:e_clientes, :ano_admissao)

    connection.select_all('SELECT id, ano_admissao FROM e_clientes WHERE ano_admissao IS NOT NULL').each do |row|
      dt = connection.quote(Date.new(row['ano_admissao'].to_i, 1, 1))
      connection.update("UPDATE e_clientes SET data_admissao = #{dt} WHERE id = #{row['id'].to_i}")
    end
  end

  def migrate_convenios_data
    return unless table_exists?(:e_clientes_g_orgaos) && column_exists?(:e_clientes, :g_orgao_id)

    connection.select_all('SELECT id, g_orgao_id FROM e_clientes WHERE g_orgao_id IS NOT NULL').each do |row|
      eid = row['id'].to_i
      oid = row['g_orgao_id'].to_i
      sql = 'INSERT INTO e_clientes_g_orgaos (e_cliente_id, g_orgao_id) ' \
            "VALUES (#{eid}, #{oid}) ON CONFLICT DO NOTHING"
      connection.execute(sql)
    end
  end
end
