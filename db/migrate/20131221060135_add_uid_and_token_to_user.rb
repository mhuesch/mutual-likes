class AddUidAndTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :integer
    add_column :users, :token, :string
  end
end
