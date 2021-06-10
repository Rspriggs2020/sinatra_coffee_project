class CreateFlavors < ActiveRecord::Migration[5.2]
  def change
    create_table :flavors do |t|
      t.string :syrup
      t.string :milk
      t.string :toppings
    end
  end
end
