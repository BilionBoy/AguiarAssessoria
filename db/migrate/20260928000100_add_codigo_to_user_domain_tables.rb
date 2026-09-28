# frozen_string_literal: true

class AddCodigoToUserDomainTables < ActiveRecord::Migration[8.0]
  def up
    add_column :g_status_users, :codigo, :string
    add_column :g_tipo_usuarios, :codigo, :string

    execute <<~SQL.squish
      UPDATE g_status_users
      SET codigo = CASE
        WHEN lower(descricao) = 'ativo' THEN 'ativo'
        WHEN lower(descricao) = 'inativo' THEN 'inativo'
        WHEN lower(descricao) = 'bloqueado' THEN 'bloqueado'
        ELSE 'status_user_' || id
      END
      WHERE codigo IS NULL
    SQL

    execute <<~SQL.squish
      UPDATE g_tipo_usuarios
      SET codigo = CASE
        WHEN lower(descricao) IN ('admin', 'administrador') THEN 'admin'
        WHEN lower(descricao) = 'gerente' THEN 'gerente'
        WHEN lower(descricao) IN ('usuario', 'usuário') THEN 'usuario'
        ELSE 'tipo_usuario_' || id
      END
      WHERE codigo IS NULL
    SQL

    deduplicate_catalog!(:g_status_users, :g_status_user_id)
    deduplicate_catalog!(:g_tipo_usuarios, :g_tipo_usuario_id)

    change_column_null :g_status_users, :codigo, false
    change_column_null :g_tipo_usuarios, :codigo, false

    add_index :g_status_users, :codigo, unique: true
    add_index :g_tipo_usuarios, :codigo, unique: true
  end

  def down
    remove_index :g_tipo_usuarios, :codigo
    remove_index :g_status_users, :codigo
    remove_column :g_tipo_usuarios, :codigo
    remove_column :g_status_users, :codigo
  end

  private

  def deduplicate_catalog!(table_name, users_fk)
    duplicate_codes = select_values(<<~SQL.squish)
      SELECT codigo
      FROM #{table_name}
      GROUP BY codigo
      HAVING COUNT(*) > 1
    SQL

    duplicate_codes.each do |codigo|
      ids = select_values(<<~SQL.squish)
        SELECT id
        FROM #{table_name}
        WHERE codigo = #{quote(codigo)}
        ORDER BY id
      SQL

      keep_id = ids.first
      duplicate_ids = ids.drop(1)
      next if duplicate_ids.empty?

      execute <<~SQL.squish
        UPDATE users
        SET #{users_fk} = #{keep_id}
        WHERE #{users_fk} IN (#{duplicate_ids.join(',')})
      SQL

      execute <<~SQL.squish
        DELETE FROM #{table_name}
        WHERE id IN (#{duplicate_ids.join(',')})
      SQL
    end
  end
end
