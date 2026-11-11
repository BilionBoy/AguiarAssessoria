# frozen_string_literal: true

# Usuário com must_change_password = true é levado à tela de troca de senha
# assim que entra no sistema e não consegue usar nada até escolher a própria senha.
class AddMustChangePasswordToUsers < ActiveRecord::Migration[8.1]
  def up
    return if column_exists?(:users, :must_change_password)

    add_column :users, :must_change_password, :boolean, default: false, null: false

    # Nenhum usuário existente escolheu a própria senha: o admin usa a senha do
    # seed (que ficou exposta no histórico do repositório) e os demais foram
    # cadastrados pelo admin, que portanto conhece a senha deles.
    execute 'UPDATE users SET must_change_password = TRUE'
  end

  def down
    remove_column :users, :must_change_password if column_exists?(:users, :must_change_password)
  end
end
