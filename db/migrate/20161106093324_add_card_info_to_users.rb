class AddCardInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :card_brand, :string
    add_column :users, :last4, :string
    add_column :users, :exp_year, :integer
    add_column :users, :exp_month, :integer
  end
end
