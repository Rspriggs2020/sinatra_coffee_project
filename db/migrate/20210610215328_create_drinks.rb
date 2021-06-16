class CreateDrinks < ActiveRecord::Migration[5.2]
  def change
    create_table :drinks do |t|
      t.string :name
      t.integer :size
      t.string :flavor
      t.string :milk
      t.string :toppings
      t.integer :user_id
    end
  end
end
