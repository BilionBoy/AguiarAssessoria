# frozen_string_literal: true

class AddGStatusUserToUsers < ActiveRecord::Migration[7.2]
  def up
    return if column_exists?(:users, :g_status_user_id)

    add_reference :users, :g_status_user, null: false, foreign_key: true, default: 1, index: true
  end

  def down
    return unless column_exists?(:users, :g_status_user_id)

    remove_reference :users, :g_status_user, foreign_key: true, index: true
  end
end
