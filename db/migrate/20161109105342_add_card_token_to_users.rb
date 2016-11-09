class AddCardTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :card_token, :string
  end
end
