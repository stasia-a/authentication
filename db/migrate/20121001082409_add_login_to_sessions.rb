class AddLoginToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :login, :string
  end
end
