class CreateAddImagesToDrinks < ActiveRecord::Migration[5.2]
  def change
    add_column :drinks, :image_url, :string
  end
end

