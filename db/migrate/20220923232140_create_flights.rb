class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.string :name
      t.string :class
      t.string :manufacturer
      t.integer :capacity
      t.string :status
      t.decimal :cost

      t.timestamps
    end
  end
end
