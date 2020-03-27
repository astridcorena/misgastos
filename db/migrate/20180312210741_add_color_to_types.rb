class AddColorToTypes < ActiveRecord::Migration[5.1]
  def change
  	add_column :types, :color, :string
  end
end
