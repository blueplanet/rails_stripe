class AddStripeSubscriptionTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_sub_token, :string
  end
end
