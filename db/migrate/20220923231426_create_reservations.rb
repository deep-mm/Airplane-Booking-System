class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :passengers
      t.string :class
      t.string :amenities
      t.decimal :cost

      t.timestamps
    end
  end
end
