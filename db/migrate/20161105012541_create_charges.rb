class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :amount
      t.string :data

      t.timestamps
    end
  end
end
