class CreateCoffeeBeans < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_beans do |t|
      t.string :name
      t.string :region
      t.string :wash_process
      t.string :flavor_notes
    end
  end
end