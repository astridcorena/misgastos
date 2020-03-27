class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :type_id
      t.integer :category_id
      t.date :date
      t.string :concept
      t.integer :amount

      t.timestamps
    end
  end
end
