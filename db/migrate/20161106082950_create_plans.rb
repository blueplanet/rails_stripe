class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :amount
      t.string :stripe_plan_id
      t.string :currency
      t.string :interval

      t.timestamps
    end
  end
end
