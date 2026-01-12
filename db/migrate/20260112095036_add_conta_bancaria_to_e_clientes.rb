class AddContaBancariaToEClientes < ActiveRecord::Migration[7.2]
  def up
    add_column :e_clientes, :agencia, :string unless column_exists?(:e_clientes, :agencia)

    return if column_exists?(:e_clientes, :conta)

    add_column :e_clientes, :conta, :string
  end

  def down
    remove_column :e_clientes, :agencia if column_exists?(:e_clientes, :agencia)

    return unless column_exists?(:e_clientes, :conta)

    remove_column :e_clientes, :conta
  end
end
