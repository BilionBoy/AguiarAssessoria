class AllowNullEmpresaOnUsers < ActiveRecord::Migration[7.2]
  def change
    return unless column_exists?(:users, :e_empresa_id)

    change_column_null :users, :e_empresa_id, true
  end
end
